<%--
  Created by IntelliJ IDEA.
  User: ADietrich
  Date: 4/1/14
  Time: 10:36 PM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Crowdsort | User Home</title>
    <meta name="layout" content="home"/>
</head>

<body>
<shiro:isLoggedIn>


<p class="welcome">Welcome ${username}!</p>
<g:if test="${!projects}">
    <h2>You have no Projects!</h2>
    <h3><g:link action="newProject" name="create">Create a New Project</g:link> </h3>
</g:if>
<g:else>
    <h1>Your Projects</h1>
<table>
    <tr>
        <th>Project #</th>
        <th>Project Title</th>
        <th>Categories</th>
        <th>Pages</th>
        <th>Sorts Wanted</th>
        <th>Times Sorted</th>
        <th>Username</th>
        <th>View</th>
        <th>Delete</th>
    </tr>

<g:each in="${projects.projects}" var="project">
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
            ${project.pages.timesSorted.join(', ')}
        </td>
        <td>
            ${project.user.username}
        </td>
        <td>
            <g:link action="projDash" controller="dashboard" id="${project.id}">View</g:link>
        </td>
        <td>
           <g:link action="deleteProject" id="${project.id}">Delete</g:link>
        </td>
    </tr>
</g:each>

</table>
    <h3><g:link action="newProject" name="create" class="create"><img src="${resource(dir: 'images', file: 'circle-arrow.png')}"/> Create</g:link> </h3>

</g:else>
<shiro:hasRole name="admin">
    <br>
    <g:link action="viewAll">View All Projects (Admin)</g:link>
</shiro:hasRole>
</shiro:isLoggedIn>
<shiro:isNotLoggedIn>
    <h1>Please <g:link controller="auth" action="login"> Login</g:link>to Continue</h1>
</shiro:isNotLoggedIn>
</body>
</html>