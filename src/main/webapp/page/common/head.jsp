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
    <title></title>

    <% String path = request.getContextPath();%>
    <% String cdnURL = "http://7xjx6c.com1.z0.glb.clouddn.com";%>
    <%--<% String cdnURL = "http://img.tfind.cn";%>--%>


    <!-- Bootstrap -->
    <link href="<%=path%>/css/bootstrap.min.css" rel="stylesheet"/>

    <link href="<%=path%>/css/base.css" rel="stylesheet"/>
    <link href="<%=path%>/css/skin.css" rel="stylesheet"/>

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
    <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>
<body>

    <div class="main-header">
        <a class="logo" href="#"><b>淘人科技</b></a>

        <nav class="navbar navbar-static-top">
            <div class="navbar-custom-menu">
                <ul class="nav navbar-nav">

                    <li style="background-color: #367FA9;">
                        <a style="color: #ffffff;" href="<%=path%>/login/out">退出</a>
                    </li>

                </ul>
            </div>
        </nav>
    </div>


    <div class="main-sidebar">
        <div class="sidebar" style="height:auto;">

            <div class="user-panel">
                <div class="pull-left image">

                    <a href="<%=path%>/user/detail?uid=${userOnline.uid}">
                        <img class="img-circle" src="<%=cdnURL%>/@${sessionScope.userOnline.avatar}?imageView2/2/w/35/h/35"/>
                    </a>
                </div>
                <div class="pull-left info">
                    ${sessionScope.userOnline.nickname}
                </div>
            </div>

            <ul class="sidebar-menu">

                <li>
                    <a href="<%=path%>/user/page"><span>用户管理</span></a>
                </li>

                <li>
                    <a href="<%=path%>/label/page"><span>标签管理</span></a>
                </li>

                <li>
                    <a href="<%=path%>/asking/page"><span>喊话管理</span></a>
                </li>

                <li>
                    <a href="<%=path%>/report/page"><span>举报投诉</span></a>
                </li>

                <li>
                    <a href="<%=path%>/customer/page"><span>客服管理</span></a>
                </li>

                <li>
                    <a href="<%=path%>/search/page"><span>搜索管理</span></a>
                </li>


            </ul>
        </div>
    </div>


<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script src="<%=path%>/js/jquery-1.11.3.min.js"></script>
<!-- Include all compiled plugins (below), or include individual files as needed -->
<script src="<%=path%>/js/bootstrap.min.js"></script>
</body>
</html>
