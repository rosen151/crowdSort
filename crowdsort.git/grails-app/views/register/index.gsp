<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <title>Register</title>
    <meta name="layout" content="login"/>
</head>

<body>

<h1>Register</h1>

<g:if test="${flash.message}">
    <div class="alert alert-info">${flash.message}</div>
</g:if>

<g:hasErrors bean="${user}">
    <div class="alert alert-error">
        <g:renderErrors bean="${user}" as="list"/>
    </div>
</g:hasErrors>

<g:form action="register" class="form-table">
    <table>


    <tr>
       <th>
           <label for="username">Username:</label>
       </th>
        <td>
            <g:textField name="username" value="${user?.username}"/>

        </td>

    </tr>
    <tr>
    <th>

        <label for="password">Password:</label>
    </th>
    <td>
        <g:passwordField name="password" value=""/>
    </td>

    </tr>

    <tr>
        <th><label for="password">Confirm Password:</label></th>
        <td> <g:passwordField name="password2" value=""/></td>
    </tr>
    <tr>
        <td/>
       <td><g:submitButton name="submit" value="Register"/></td>
    </tr>


    </table>







</g:form>

</body>
</html>