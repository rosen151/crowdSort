<%--
  Created by IntelliJ IDEA.
  User: alex
  Date: 4/2/14
  Time: 11:25 PM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Add Pages</title>
    <meta name="layout" content="home"/>
</head>

<body>
<h1>Add Pages</h1>
<h3>For each page, type the name into the text box and click "Add" to add it to your project.</h3>
<h3>To remove a page, choose it from the list and select "Remove" to remove it from your project.</h3>
<g:form name="pagesForm" action="updatePages">
    <g:textField name="pageTitle" />
    <g:submitButton name="addpage" value="Add" />
    <g:hiddenField name="projectID" value="${projectID}" />
</g:form>

<g:form name="removePage" action="removePage">
    <g:select name="pageDelete" from="${pages}" multiple="true"  optionKey="id"  optionValue="pageTitle"   />
    <g:submitButton name="removeCat" value="Remove Selected"  />
    <g:hiddenField name="projectID" value="${projectID}" />
</g:form>
<g:form name="makeit" action="makeHIT">
    <g:hiddenField name="projectID" value="${projectID}"/>
    <g:submitButton name="MakeHIT" value="Make HIT"/>
</g:form>
</body>
</html>