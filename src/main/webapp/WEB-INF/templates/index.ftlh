<#import "common.ftl" as c/>

<@c.page>
<ul>
    <#list posts as post>
        <li><@c.makepost post=post trunc="trunc"/> </li>
    </#list>
</ul>
</@c.page>
