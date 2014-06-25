<%--
  Created by IntelliJ IDEA.
  User: ADietrich
  Date: 4/7/14
  Time: 8:27 AM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>CrowdSort | View Status</title>
</head>

<body>
<shiro:isLoggedIn>
    <shiro:hasRole name="ROLE_USER">
        <g:each in="${cardsort}" var="csort">
        <table border="1">

            <tr>
                <th>Project ID</th>
                <td>${csort.projectID}</td>
            </tr>
            <tr>
                <th>Category</th>
                <td>${csort.category}</td>
            </tr>
            <tr>
                <th>Page</th>
                <td>${csort.page}</td>
            </tr>
            <tr>
                <th>Turker ID</th>
                <td>${csort.turkerID}</td>
            </tr>

        </table>
            <br>
        </g:each>






    </shiro:hasRole>

    <shiro:hasRole name="admin">



    </shiro:hasRole>

</shiro:isLoggedIn>
<shiro:isNotLoggedIn>

</shiro:isNotLoggedIn>
</body>
</html>