<%--
  Created by IntelliJ IDEA.
  User: alex
  Date: 4/3/14
  Time: 8:38 PM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Admin - View All</title>
</head>

<body>
<shiro:isLoggedIn>

    <shiro:hasRole name="admin">
<g:if test="${!projects}">
    <h2>No Projects to See!</h2>
</g:if>
<g:else>
    <h1>Admin Project View</h1>
    <table border="1">
        <tr>
            <th>Project #</th>
            <th>Project Title</th>
            <th>Categories</th>
            <th>Pages</th>
            <th>Sorts Wanted (per Page)</th>
            <th>Times Sorted</th>
            <th>Username</th>
        </tr>

        <g:each in="${projects}" var="project">
            <tr>
                <td>
                    ${project.id}
                </td>
                <td>
                    ${project.projectTitle}
                </td>
                <td>
                    ${project.categories.category.join(', ')}
                </td>
                <td>
                    ${project.pages.pageTitle.join(', ')}

                </td>
                <td>
                    ${project.timesToSort}
                </td>
                <td>
                    ${project.pages.timesSorted.join('')}
                </td>
                <td>
                    ${project.user.username}
                </td>
                <td>
                    <g:link action="deleteProject" id="${project.id}">Delete</g:link>
                </td>
            </tr>
        </g:each>

    </table>
</g:else>
    </shiro:hasRole>
    <shiro:lacksRole name="admin"><h3>You do not have permission to view this page</h3></shiro:lacksRole>
</shiro:isLoggedIn>
<shiro:isNotLoggedIn><g:link controller="auth" action="login">Please Login! </g:link> </shiro:isNotLoggedIn>
</body>
</html>