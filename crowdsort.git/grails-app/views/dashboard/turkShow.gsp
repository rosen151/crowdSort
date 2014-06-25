<%--
  Created by IntelliJ IDEA.
  User: Wes
  Date: 4/14/14
  Time: 12:50 AM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>CrowdSort | Results </title>
    <meta name="layout" content="home"/>
</head>

<body>

<table>
    <g:each in="${turkResults}">
        ${it.page} : ${it.category} <br />
    </g:each>

</table>

<g:link name="return" class="create" controller="project" action="index" >Return to Project List</g:link>

</body>
</html>