<%--
  Created by IntelliJ IDEA.
  User: casuser
  Date: 3/31/14
  Time: 3:48 PM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>New Project</title>
    <meta name="layout" content="home">
</head>

<body>
<h1>Create a New Project</h1>
<p>Provide a meaningful name for your website that you would like to have cardsorted. Specify the number of times you would like your website sorted completely.</p>
<g:form name="newProject" action="startProject">
   <label>Project Title:</label> <g:textField name="projectTitle" placeholder="ex. Sports"/> <br>
   <label>Times to Sort:</label> <g:textField name="timesToSort" placeholder="ex. 4"/> <br>
    <g:submitButton name="Add Categories"/>
</g:form>
</body>
</html>