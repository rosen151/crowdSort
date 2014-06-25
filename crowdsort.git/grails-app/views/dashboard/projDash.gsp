<%--
  Created by IntelliJ IDEA.
  User: Wes
  Date: 4/13/14
  Time: 5:12 PM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Crowdsort | Cardsort Results</title>
    <meta name="layout" content="home"/>
</head>

<body>
<h1>${project.projectTitle} Results</h1>

<table class="results-table" >
    <tr>
        <th>Page Name</th>
        <th>Results</th>
    </tr>
    <g:each in="${myMap}">
        <tr>
            <td>${it.key}</td>
        <td>
            <g:each in="${it.value}">
                    %{--These work, IntelliJ doesn't recognize nested maps.--}%
                    ${it.key}: <strong><g:formatNumber number="${it.value}" type="percent" maxFractionDigits="2" /></strong><br>
            </g:each>
        </td>
    </tr>
    </g:each>
</table>

<g:link action="turkResults" class="create" id="${project.id}">Individual Turker Results</g:link>

</body>
</html>