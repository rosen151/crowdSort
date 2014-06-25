<%--
  Created by IntelliJ IDEA.
  User: Wes
  Date: 4/5/14
  Time: 7:54 PM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title></title>
</head>

<body>

%{--<h1>${project.projectTitle}</h1>--}%

<h4>Website for Sorting: ${project.projectTitle}</h4>

<p>Below you will find a list of categories, and below the categories you will find a list of pages that need to be sorted into the most appropriate category.</p>
<p>For each page, select the category that you feel the page should be sorted into.</p>

<table border="1">
    <tr>
        <th colspan="${categories.count[0]}">Categories</th>
    </tr>
    <tr>
    <g:each in="${categories}">
        <td>${it.category}</td>
    </g:each>
    </tr>
</table>

<g:form name="results" action="processInfo">
    <table border="1">
        <g:hiddenField name="projectID" value="${project.id}">${project.id}</g:hiddenField>
        <tr>
            <th colspan="${pages.count[0]}">Pages</th>
        </tr>
        <tr>
            <g:each in="${pages}">
                <td>${it.pageTitle}<br> <g:select name="${it.pageTitle}" from="${categories.category}" /></td>
            </g:each>
        </tr>
    </table>
    <g:submitButton name="Submit" value="Submit" />
</g:form>

</body>
</html>