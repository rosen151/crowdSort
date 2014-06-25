<%--
  Created by IntelliJ IDEA.
  User: ADietrich
  Date: 4/14/14
  Time: 10:01 AM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Crowdsort | Dashboard</title>
    <meta name="layout" content="home"/>
</head>

<body>

<g:each in="${projects.projects}">
    <p><g:link action="projDash" id="${it.id}">${it.projectTitle}</g:link></p>
</g:each>



</body>
</html>