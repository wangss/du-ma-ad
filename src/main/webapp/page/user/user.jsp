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
    <title>用户管理</title>
</head>

<body>

<div class="wrapper">

    <%--<jsp:include page="../common/head.jsp" flush="true" />--%>
    <%@ include file="../common/head.jsp" %>

    <div class="main-content">

        <div class="panel panel-default" style="margin-bottom: 10px;">
            <div class="panel-heading">
                <h3 class="panel-title">用户管理</h3>
            </div>
            <div class="panel-body" style="padding: 10px;">
                <form class="form-inline" style="margin-bottom: 0px;" method="post" action="list">
                    <div class="form-group">
                        <input type="text" class="form-control" id="uid"  name="uid" placeholder="uid" value="${queryResult.param['uid']}">
                    </div>
                    <div class="form-group">
                        <input type="text" class="form-control" id="trId"  name="trId" placeholder="trId" value="${queryResult.param['trId']}">
                    </div>
                    <div class="form-group">
                        <input type="text" class="form-control" id="areaCode"  name="areaCode" placeholder="86" value="${queryResult.param['areaCode']}">
                    </div>
                    <div class="form-group">
                        <input type="text" class="form-control" id="phone"  name="phone" placeholder="phone" value="${queryResult.param['phone']}">
                    </div>
                    <div class="form-group">
                        <input type="text" class="form-control" id="nickname"  name="nickname" placeholder="nickname" value="${queryResult.param['nickname']}">
                    </div>
                    <div class="form-group">

                        <select id="status" name="status" class="form-control">

                            <option value="1"<c:if test="${queryResult.param['status'] == 1}">selected</c:if>>正常使用</option>
                            <option value="2"<c:if test="${queryResult.param['status'] == 2}">selected</c:if>>已经注销</option>
                            <option value="3"<c:if test="${queryResult.param['status'] == 3}">selected</c:if>>已被禁用</option>
                            <option value="" <c:if test="${queryResult.param['status'] == null}">selected</c:if>>所有状态</option>

                        </select>
                    </div>
                    <div class="form-group">

                        <select id="userType" name="userType" class="form-control">

                            <option value="1"<c:if test="${queryResult.param['userType'] == 1}">selected</c:if>>普通用户</option>
                            <option value="2"<c:if test="${queryResult.param['userType'] == 2}">selected</c:if>>公司运营</option>
                            <option value="" <c:if test="${queryResult.param['userType'] == null}">selected</c:if>>用户类型</option>

                        </select>
                    </div>

                    <button type="submit" class="btn btn-default">查找</button>
                </form>
            </div>
        </div>


        <c:if test="${queryResult != null}">
            <div class="panel panel-default" style="margin-bottom: 10px;">
                <!-- Table -->
                <table class="table table-bordered table-hover table-striped">
                    <thead>
                    <tr>
                        <th>UID</th>
                        <th>昵称</th>

                        <th>淘人ID</th>
                        <th>区号</th>

                        <th>PHONE</th>

                        <th>状态</th>
                        <th>环信用户</th>
                        <th>创建时间</th>

                        <th>用户类型</th>

                    </tr>


                    </thead>
                    <tbody>

                    <c:forEach items="${queryResult.list}" var="user">
                        <tr>
                            <td><a href="detail?uid=${user.uid}"> ${user.uid}</a></td>
                            <td>${user.nickname}</td>

                            <td>${user.trId}</td>
                            <td>${user.areaCode}</td>
                            <td>${user.phone}</td>

                            <c:choose>
                                <c:when test="${user.status == 1}">
                                    <td>正常</td>
                                </c:when>
                                <c:when test="${user.status == 2}">
                                    <td>注销</td>
                                </c:when>
                                <c:when test="${user.status == 2}">
                                    <td>禁用</td>
                                </c:when>
                                <c:otherwise>
                                    <td></td>
                                </c:otherwise>
                            </c:choose>


                            <c:choose>
                                <c:when test="${user.easemobStatus == 1}">
                                    <td>已创建</td>
                                </c:when>
                                <c:otherwise>
                                    <td></td>
                                </c:otherwise>
                            </c:choose>


                            <td>${user.createTime}</td>

                            <td>
                                <c:choose>
                                <c:when test="${user.userType == 2}">
                                管理员
                                </c:when>
                                <c:otherwise>
                                    用户
                                </c:otherwise>
                                </c:choose>
                            </td>
                        </tr>

                    </c:forEach>


                    </tbody>
                </table>
            </div>

            <tf:RollPage url="list" />

        </c:if>


    </div>


</div>

</body>
</html>
