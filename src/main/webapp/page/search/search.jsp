<%@ taglib prefix="s" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: king
  Date: 5/11/15
  Time: 11:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>搜索管理</title>

</head>

<body>

<div class="wrapper">

    <%--<jsp:include page="../common/head.jsp" flush="true" />--%>
    <%@ include file="../common/head.jsp" %>

    <div class="main-content">


        <div class="panel panel-default" style="margin: 20px;">
            <!-- Table -->
            <div class="panel-heading">
                <h3 class="panel-title">搜索管理

                    <span style="float:right;">
                        <a href="reIndex" class=""> <button type="button" class="btn btn-default">重建索引</button></a>
                    </span>
                </h3>


            </div>

            <div class="panel-body">
                <form class="form-inline" method="post" action="search">


                    <div class="form-group">
                        <input type="text" class="form-control" id="longitude"  name="lon" placeholder="经度" value="${searchParams.lon}">
                        <input type="text" class="form-control" id="latitude"  name="lat" placeholder="纬度" value="${searchParams.lat}">

                        <input type="text" class="form-control" id="keyword"  name="keyword" placeholder="keyword" value="${searchParams.keyword}">


                        <div class="form-group">

                            <select id="gender" name="gender" class="form-control">

                                <option value="1"<c:if test="${searchParams.gender == 1}">selected</c:if>>男</option>
                                <option value="2"<c:if test="${searchParams.gender == 2}">selected</c:if>>女</option>
                                <option value="" <c:if test="${searchParams.gender == null}">selected</c:if>>性别</option>
                            </select>
                        </div>

                        <div class="form-group">

                            <select id="ageRange" name="ageRange" class="form-control">

                                <option value="1"<c:if test="${searchParams.ageRange == 1}">selected</c:if>>18岁以下</option>
                                <option value="2"<c:if test="${searchParams.ageRange == 2}">selected</c:if>>18-22岁</option>
                                <option value="3"<c:if test="${searchParams.ageRange == 3}">selected</c:if>>23-26岁</option>
                                <option value="4"<c:if test="${searchParams.ageRange == 4}">selected</c:if>>27-35岁</option>
                                <option value="5"<c:if test="${searchParams.ageRange == 5}">selected</c:if>>35岁以上</option>
                                <option value="" <c:if test="${searchParams.ageRange == null}">selected</c:if>>年 龄</option>
                            </select>
                        </div>

                        <div class="form-group">

                            <select id="lastActiveTimeRange" name="lastActiveTimeRange" class="form-control">

                                <option value="1"<c:if test="${searchParams.lastActiveTimeRange == 1}">selected</c:if>>15分钟</option>
                                <option value="2"<c:if test="${searchParams.lastActiveTimeRange == 2}">selected</c:if>>1小时</option>
                                <option value="3"<c:if test="${searchParams.lastActiveTimeRange == 3}">selected</c:if>>一天</option>
                                <option value="4"<c:if test="${searchParams.lastActiveTimeRange == 4}">selected</c:if>>三天</option>
                                <option value="5"<c:if test="${searchParams.lastActiveTimeRange == 5}">selected</c:if>>不限</option>
                                <option value="" <c:if test="${searchParams.lastActiveTimeRange == null}">selected</c:if>>最后在线</option>
                            </select>
                        </div>

                        <input type="text" class="form-control" id="range"  name="range" placeholder="range" value="${searchParams.range}">
                        <input type="text" class="form-control" id="page"  name="page" placeholder="page" value="${searchParams.page}">
                        <input type="text" class="form-control" id="pageSize"  name="pageSize" placeholder="pageSize" value="${searchParams.pageSize}">
                    </div>

                    <button type="submit" class="btn btn-default">搜索(标签)</button>
                </form>

                <form class="form-inline" method="post" action="search2">


                    <div class="form-group">
                        <input type="text" class="form-control" id="trId"  name="trId" placeholder="trId" value="${trId}">
                        <input type="text" class="form-control" id="ids"  name="ids" placeholder="ids" value="${ids}">

                    </div>
                    <button type="submit" class="btn btn-default">搜索用户</button>
                </form>

                <form class="form-inline" method="post" action="asking">


                    <div class="form-group">
                        <input type="text" class="form-control"  name="lon" placeholder="经度" value="${searchParams.lon}">
                        <input type="text" class="form-control"  name="lat" placeholder="纬度" value="${searchParams.lat}">
                        <input type="text" class="form-control"  name="range" placeholder="range" value="${searchParams.range}">
                        <input type="text" class="form-control"  name="page" placeholder="page" value="${searchParams.page}">
                        <input type="text" class="form-control"  name="pageSize" placeholder="pageSize" value="${searchParams.pageSize}">

                    </div>
                    <button type="submit" class="btn btn-default">搜索(喊话)</button>
                </form>



                <div class="panel panel-default">
                            <div class="panel-heading">
                                <h3 class="panel-title">
                                    <span class="label label-info">结果</span>
                                </h3>

                            </div>
                            <div class="panel-body">

                                <pre>
                                    ${content}
                                </pre>


                            </div>
                        </div>





            </div>

        </div>





    </div>

</body>
</html>
