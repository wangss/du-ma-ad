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
    <title>标签管理</title>
</head>

<body>

<div class="wrapper">

    <%--<jsp:include page="../common/head.jsp" flush="true" />--%>
    <%@ include file="../common/head.jsp" %>

    <div class="main-content">

        <div class="panel panel-default"  style="margin-bottom: 10px;">
            <div class="panel-heading">
                <h3 class="panel-title">标签管理</h3>
            </div>
            <div class="panel-body" style="padding: 10px;">
                <form class="form-inline" style="margin-bottom: 0px;"  method="post" action="list">
                    <div class="form-group">
                        <input type="text" class="form-control" id="uid"  name="uid" placeholder="uid" value="${queryResult.param['uid']}">
                    </div>
                    <div class="form-group">
                        <input type="text" class="form-control" id="labelId"  name="labelId" placeholder="labelId" value="${queryResult.param['labelId']}">
                    </div>
                    <div class="form-group">
                        <input type="text" class="form-control" id="labelName"  name="labelName" placeholder="labelName" value="${queryResult.param['labelName']}">
                    </div>

                    <button type="submit" class="btn btn-default">查找</button>
                </form>
            </div>
        </div>

        <c:if test="${queryResult != null}">
            <div class="panel panel-default"  style="margin-bottom: 10px;">
                <!-- Table -->
                <table class="table  table-bordered table-hover table-striped">
                    <thead>
                    <tr>
                        <th>UID</th>
                        <th>LABEL_ID</th>

                        <th>标签名</th>
                        <th>添加时间</th>

                        <th>经度</th>
                        <th>纬度</th>
                        <th>位置类型</th>

                    </tr>


                    </thead>
                    <tbody>

                    <c:forEach items="${queryResult.list}" var="label">
                        <tr>
                            <td><a href="detail?uid=${label.uid}"> ${label.uid}</a></td>
                            <%--<td>${label.uid}</td>--%>
                            <td><a href="detail?labelId=${label.id}"> ${label.id}</a></td>
                            <%--<td>${label.id}</td>--%>

                            <td>${label.labelName}</td>
                            <td>${label.addTime}</td>

                            <td>${label.longitude}</td>
                            <td>${label.latitude}</td>

                            <c:choose>
                                <c:when test="${label.positionType == '1'}">
                                    <td>固定</td>
                                </c:when>
                                <c:otherwise>
                                    <td>移动</td>
                                </c:otherwise>
                            </c:choose>

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
