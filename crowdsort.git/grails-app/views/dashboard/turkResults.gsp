<%--
  Created by IntelliJ IDEA.
  User: Wes
  Date: 4/14/14
  Time: 12:41 AM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>CrowdSort | Individual Results</title>
    <meta name="layout" content="home"/>
</head>

<body>
<h1>Individual Turker Results</h1>
<table border="1">
    <h3> Worker ID</h3>
    <br>
        <g:each in="${turkList}">

           <p>        <g:link action="turkShow" params="[projectID:project.id,turkerID:it]">${it}</g:link> </p>

        </g:each>
</table>
<br>
<g:link name="return" class="create" controller="project" action="index" >Return to Project List</g:link>

</body>
</html>