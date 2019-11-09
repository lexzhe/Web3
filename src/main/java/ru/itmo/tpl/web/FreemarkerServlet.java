package ru.itmo.tpl.web;

import freemarker.template.*;
import ru.itmo.tpl.util.DataUtil;
import ru.itmo.tpl.util.DebugUtil;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.net.URLDecoder;
import java.nio.charset.StandardCharsets;
import java.util.HashMap;
import java.util.Map;

public class FreemarkerServlet extends HttpServlet {
    private Configuration freemarkerConfiguration;

    @Override
    public void init() throws ServletException {
        super.init();

        freemarkerConfiguration = new Configuration(Configuration.VERSION_2_3_29);

        File freemarkerDirectory = DebugUtil.getFile(getServletContext(), "WEB-INF/templates");
        try {
            freemarkerConfiguration.setDirectoryForTemplateLoading(freemarkerDirectory);
        } catch (IOException e) {
            throw new ServletException("Unable to configure freemarker configuration:"
                    + " freemarkerConfiguration.setDirectoryForTemplateLoading(freemarkerDirectory) failed"
                    + " [freemarkerDirectory=" + freemarkerDirectory + "].", e);
        }

        freemarkerConfiguration.setDefaultEncoding(StandardCharsets.UTF_8.name());
        freemarkerConfiguration.setTemplateExceptionHandler(TemplateExceptionHandler.HTML_DEBUG_HANDLER);
        freemarkerConfiguration.setLogTemplateExceptions(false);
        freemarkerConfiguration.setWrapUncheckedExceptions(true);
        freemarkerConfiguration.setFallbackOnNullLoopVariable(false);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        request.setCharacterEncoding(StandardCharsets.UTF_8.name());
        response.setCharacterEncoding(StandardCharsets.UTF_8.name());


        response.setContentType("text/html");
        Map<String, Object> data = new HashMap<>();
        boolean goodParameters = putData(request, data);
        Template template;
        if (!goodParameters) {
            template = freemarkerConfiguration.getTemplate(
                    URLDecoder.decode("/error404", StandardCharsets.UTF_8.name()) + ".ftlh");
        } else {
            if (request.getRequestURI().equals("") || request.getRequestURI().equals("/")) {
//                response.sendRedirect("/index");
                template = freemarkerConfiguration.getTemplate(
                        URLDecoder.decode("/index", StandardCharsets.UTF_8.name()) + ".ftlh");
            } else {
                try {
                    template = freemarkerConfiguration.getTemplate(
                            URLDecoder.decode(request.getRequestURI(), StandardCharsets.UTF_8.name()) + ".ftlh");
                } catch (TemplateNotFoundException ignored) {
                    template = freemarkerConfiguration.getTemplate(
                            URLDecoder.decode("/error404", StandardCharsets.UTF_8.name()) + ".ftlh");
//            response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                }
            }
        }

        try {
            template.process(data, response.getWriter());
        } catch (TemplateException e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            e.printStackTrace();
        }
    }

    private boolean putData(HttpServletRequest request, Map<String, Object> data) {
        if (request.getRequestURI().endsWith("help"))
            data.put("pointHelp", true);
        if (request.getRequestURI().endsWith("index"))
            data.put("pointIndex", true);
        if (request.getRequestURI().endsWith("users"))
            data.put("pointUsers", true);
        for (Map.Entry<String, String[]> e : request.getParameterMap().entrySet()) {
            if (e.getValue() != null && e.getValue().length == 1) {
                if (e.getKey().endsWith("id")) {
                    try {
                        data.put("id", Long.parseLong(e.getValue()[0]));
                    } catch (NumberFormatException ignored) {
                        DataUtil.putData(data);
                        return false;
                    }

                } else {
                    data.put(e.getKey(), e.getValue()[0]);
                }
            }
        }

        DataUtil.putData(data);
        return true;
    }
}
