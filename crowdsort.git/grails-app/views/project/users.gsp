<%--
  Created by IntelliJ IDEA.
  User: alex
  Date: 4/4/14
  Time: 11:38 PM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>User List</title>
</head>

<body>
<shiro:isLoggedIn>
    <shiro:hasRole name="admin">
        <table border="1">
            <tr>
            <th>Username</th>
            <th>Projects</th>
            </tr>
            <g:each in="${users}" var="user">
                <tr>
                    <td>${user.username}</td>
                    <td>${user.projects.projectTitle}</td>
                    <td><g:link action="deleteUser" name="delete" id="${user.id}">Delete</g:link></td>
                </tr>
            </g:each>
        </table>
    </shiro:hasRole>
    <shiro:lacksRole name="admin">
        <h1>You are not authorized to view this page</h1>
    </shiro:lacksRole>
</shiro:isLoggedIn>
</body>
</html>