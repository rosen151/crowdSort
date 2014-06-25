<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
  <meta name="layout" content="login" />
  <title>Login</title>
</head>
<body>
  <g:if test="${flash.message}">
    <div class="message">${flash.message}</div>
  </g:if>
  <g:form action="signIn" class="form-table">
    <input type="hidden" name="targetUri" value="${targetUri}" />
      <h1>Login</h1>
    <table>
      <tbody>
        <tr>
          <th>Username:</th>
          <td><input type="text" name="username" value="${username}" /></td>
        </tr>
        <tr>
          <th>Password:</th>
          <td><input type="password" name="password" value="" /></td>
        </tr>
        <tr>
          <th>Remember me?:</th>
          <td><g:checkBox name="rememberMe" value="${rememberMe}" /></td>
        </tr>
        <tr>
          <td />
          <td><input type="submit" value="Sign in" /></td>
        </tr>
      </tbody>
    </table>
  </g:form>
</body>
</html>
