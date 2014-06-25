<%--
  Created by IntelliJ IDEA.
  User: ADietrich
  Date: 4/14/14
  Time: 10:49 AM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>CrowdSort</title>
    <meta name="layout" content="landing">
</head>

<body>
<div class="landing-text">


<h1>Online Cardsorting.</h1>
<h1>Using the Crowd.</h1>
<p>Cardsorting can help you effectively
organize content for your website using
the opinions of others. What better way
to do this than to ask a crowd? That's
where CrowdSort comes in. </p>
    <g:link controller="register" action="index" class="create"><img src="${resource(dir: 'images', file: 'circle-arrow.png')}"/>Get Started</g:link>
    <g:link controller="home" action="about" class="create"><img src="${resource(dir: 'images', file: 'info.png')}"/>Learn More</g:link>
</div>

<div class="front-graphic">
    <img src="${resource(dir: 'images', file: "page_image.png")}"/>
</div>

<div class="clear"></div>
</body>
</html>