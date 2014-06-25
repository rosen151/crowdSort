<%--
  Created by IntelliJ IDEA.
  User: casuser
  Date: 3/31/14
  Time: 3:21 PM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Project</title>
    <meta name="layout" content="home"/>
</head>

<body>
<h1>Add Categories</h1>
<h3>For each top level category, type the name into the text box and click "Add" to add it to your project.</h3>
<h3>To remove a category, choose it from the list and select "Remove" to remove it from your project.</h3>
<g:form name="categoryForm" action="addCategory">
    <g:textField name="category" />
    <g:submitButton name="addcategory" value="Add" />
    <g:hiddenField name="projectID" value="${projectID}" />
</g:form>

<g:form name="removeCategory" action="removeCategory">
    <g:select name="categoryDelete" from="${categories}" multiple="true"  optionKey="id"  optionValue="category"   />
    <g:submitButton name="removeCat" value="Remove Selected"  />
    <g:hiddenField name="projectID" value="${projectID}" />
</g:form>
<g:form name="addPages" action="addPages">
    <g:hiddenField name="projectID" value="${projectID}" />
    <g:submitButton name="continue" value="Continue"/>

</g:form>
</body>
</html>