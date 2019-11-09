<#macro header>
<header>
    <a href="/"><img src="/img/logo.png" alt="Codeforces" title="Codeforces"/></a>
    <div class="languages">
        <a href="#"><img src="/img/gb.png" alt="In English" title="In English"/></a>
        <a href="#"><img src="/img/ru.png" alt="In Russian" title="In Russian"/></a>
    </div>
    <div class="enter-or-register-box">
        <#if user??>
            <@userlink user=user/>
            |
            <a href="#">Logout</a>
        <#else>
            <a href="#">Enter</a>
            |
            <a href="#">Register</a>
        </#if>
    </div>
    <nav>
        <ul>
            <#if pointIndex??>
                <li><a href="/index" style="border-bottom: solid 0.25rem #3B5998">Index</a></li>
            <#else>
                <li><a href="/index">Index</a></li>
            </#if>
            <#if pointHelp??>
                <li><a href="/misc/help" style="border-bottom: solid 0.25rem #3B5998">Help</a></li>
            <#else>
                <li><a href="/misc/help">Help</a></li>
            </#if>
            <#if pointUsers??>
                <li><a href="/users" style="border-bottom: solid 0.25rem #3B5998">Users</a></li>
            <#else>
                <li><a href="/users">Users</a></li>
            </#if>
<#--            <li><a href="/index">Index</a></li>-->
<#--            <li><a href="/misc/help">Help</a></li>-->
        </ul>
    </nav>
</header>
</#macro>

<#macro sidebar>
<aside>
    <section>
        <div class="header">
            Pay attention
        </div>
        <div class="body">
            Lorem ipsum dolor sit amet, consectetur adipisicing elit. Cupiditate ducimus enim facere impedit nobis,
            nulla placeat quam suscipit unde voluptatibus.
        </div>
        <div class="footer">
            <a href="#">View all</a>
        </div>
    </section>
</aside>
</#macro>

<#macro footer>
<footer>
    <a href="#">Codeforces</a> &copy; 2010-2019 by Mike Mirzayanov
</footer>
</#macro>

<#macro page>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Codeforces</title>
    <link rel="stylesheet" type="text/css" href="/css/normalize.css">
    <link rel="stylesheet" type="text/css" href="/css/style.css">
    <link rel="icon" href="/favicon.ico" type="image/x-icon"/>
    <link rel="shortcut icon" href="/favicon.ico" type="image/x-icon"/>
</head>
<body>
    <@header/>
    <div class="middle">
        <@sidebar/>
        <main>
            <#nested/>
        </main>
    </div>
    <@footer/>
</body>
</html>
</#macro>

<#macro userlink user>
    <a href="/user?handle=${user.handle}">${user.name}</a>
</#macro>

<#macro makepost post trunc>
    <div class="middlePost">
        <link rel="stylesheet" type="text/css" href="/css/posts.css">
        <main>
            <article>
                <div class="title">${post.title}</div>
                <div class="information">${post.userId}</div>
                <#if trunc=="trunc">
                    <div class="body">${post.text?truncate(250)}</div>
                <#else>
                    <div class="body">${post.text}</div>
                </#if>

                <ul class="attachment">
                    <li>Announcement of <a href="#">Codeforces Round #510 (Div. 1)</a></li>
                    <li>Announcement of <a href="#">Codeforces Round #510 (Div. 2)</a></li>
                </ul>
                <div class="footer">
                    <div class="left">
                        <img src="img/voteup.png" title="Vote Up" alt="Vote Up"/>
                        <span class="positive-score">+173</span>
                        <img src="img/votedown.png" title="Vote Down" alt="Vote Down"/>
                    </div>
                    <div class="right">
                        <img src="img/date_16x16.png" title="Publish Time" alt="Publish Time"/>
                        2 days ago
                        <img src="img/comments_16x16.png" title="Comments" alt="Comments"/>
                        <a href="#">68</a>
                    </div>
                </div>
            </article>
        </main>
    </div>
</#macro>

<#function findBy items key id>
    <#list items as item>
        <#if item[key]==id>
            <#return item/>
        </#if>
    </#list>
</#function>

<#function findIndex items key id>
    <#list items as item>
        <#if item[key]==id>
            <#return item?index/>
        </#if>
    </#list>
</#function>

