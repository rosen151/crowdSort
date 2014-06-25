<%--
  Created by IntelliJ IDEA.
  User: Wes
  Date: 4/13/14
  Time: 5:05 PM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>CrowdSort | Dashboard</title>
    <meta name="layout" content="home"/>
</head>

<body>
<g:each in="${projects}">
    <p><g:link action="projDash" id="${it.id}">${it.projectTitle}</g:link></p>
</g:each>
<h1 id="dboard">Dashboard</h1>
<ul>

    <li><g:link name="create" controller="project" action="newProject"> <img src="${resource(dir: 'images', file: 'plus.png')}"/> <p>Create a Project</p></g:link></li>
    <li><g:link name="view"  controller="project" action="index"> <img src="${resource(dir: 'images', file: 'cards.png')}"/> <p>View Projects</p></g:link></li>
    <li><g:link name="info" controller="dashboard" action="viewAccount"> <img src="${resource(dir: 'images', file: 'info.png')}"/> <p>User Info</p></g:link></li>

</ul>
</body>
</html>