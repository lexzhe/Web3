<#-- @ftlvariable name="handle" type="java.lang.String" -->
<#import "common.ftl" as c/>

<@c.page>
    <link rel="stylesheet" type="text/css" href="/css/user.css">
    <#if handle??>
        <#assign viewedUser=c.findBy(users, "handle", handle)!/>
        <#assign index=c.findIndex(users, "handle", handle)!/>
    <#elseif id??>
        <#assign viewedUser=c.findBy(users, "id", id)!/>
        <#assign index=c.findIndex(users, "id", id)!/>
    </#if>
    <#if viewedUser.id?has_content>
        <div class="userbox">
            <div class="userbody">
                <img src="img/user.jpg" class="userjpg" align="right"/>
                <div class="username">
                    <@c.userlink user=viewedUser/>
                </div>
                <ul>
                    <li>Id: ${viewedUser.id}</li>
                    <li>Handle: ${viewedUser.handle}</li>
                    <li>Name: ${viewedUser.name}</li>
                    <li>
                        <a href="/posts?user_id=${viewedUser.id}">posts</a>
                    </li>
                </ul>
            </div>
            <div class="userfooter">
                <#if users[index]==users?first>
                    <a href="#" style="color: lightgray">←</a>
                <#else>
                    <a href="/user?handle=${users[index - 1].handle}">←</a>
                </#if>
                <#if users[index]==users?last>
                    <a href="#" style="color: lightgray">→</a>
                <#else>
                    <a href="/user?handle=${users[index + 1].handle}">→</a>
                </#if>
            </div>
        </div>
    <#else>
        <h1>No such user</h1>
    </#if>
</@c.page>
