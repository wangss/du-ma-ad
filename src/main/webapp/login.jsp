<%--
  Created by IntelliJ IDEA.
  User: king
  Date: 5/11/15
  Time: 11:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="tf" tagdir="/WEB-INF/tags" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <title>淘人科技</title>

    <% String path = request.getContextPath();%>

    <!-- Bootstrap -->
    <link href="<%=path%>/css/bootstrap.min.css" rel="stylesheet"/>

    <link href="<%=path%>/css/base.css" rel="stylesheet"/>
    <link href="<%=path%>/css/skin.css" rel="stylesheet"/>

</head>
<body>

    <div style="margin: 50px;">

        <form class="form-inline" action="<%=path%>/login/in" method="post">

            <div class="form-group">
                <input type="text" class="form-control" id="trId" name="trId" placeholder="TrId">
            </div>
            <div class="form-group">
                <input type="password" class="form-control" id="password" name="password" placeholder="Password">
            </div>
            <button type="submit" class="btn btn-default">登录</button>
        </form>
    </div>

</body>
</html>
