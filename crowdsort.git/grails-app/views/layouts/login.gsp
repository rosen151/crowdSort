<%--
  Created by IntelliJ IDEA.
  User: ADietrich
  Date: 4/14/14
  Time: 7:42 AM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title><g:layoutTitle default="Crowdsort"/> </title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'reset.css')}" type="text/css">
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'style.css')}" type="text/css">
    <link href='http://fonts.googleapis.com/css?family=Open+Sans:400,300,800' rel='stylesheet' type='text/css'>
    <g:layoutHead/>

</head>

<body>
<div class="masthead"></div>
<div class="nav">
    <img src="${resource(dir: 'images', file: 'crowdsort-logo.png')}"/>
    <ul>
        <li><g:link controller="home" action="index">Home</g:link> </li>
        <li><g:link controller="dashboard" action="index">Dashboard</g:link> </li>
        <li><g:link controller="project" action="newProject">Create</g:link> </li>
        <li><g:link controller="home" action="about">About</g:link> </li>
        <shiro:isLoggedIn>
            <li><g:link controller="project" action="logout">Logout</g:link> </li>
        </shiro:isLoggedIn>
        <shiro:isNotLoggedIn>
            <li><g:link controller="project" action="newProject">Login</g:link> </li>
        </shiro:isNotLoggedIn>
    </ul>
</div>
<div class="arrow-down"></div>


<div class="content-bg">
    <div class="content">
            <shiro:isLoggedIn>
                <h2>You are already logged in! <g:link controller="dashboard" action="index">Continue to home</g:link></h2>
            </shiro:isLoggedIn>

            <shiro:isNotLoggedIn>
                <g:layoutBody/>
            </shiro:isNotLoggedIn>




    </div>

</div>
<div class="footer"></div>

</body>
</html>