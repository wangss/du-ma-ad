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
    <title>举报投诉</title>
</head>

<body>

<div class="wrapper">

    <%--<jsp:include page="../common/head.jsp" flush="true" />--%>
    <%@ include file="../common/head.jsp" %>

    <div class="main-content">

        <div class="panel panel-default" style="margin-bottom: 10px;">
            <div class="panel-heading">
                <h3 class="panel-title">举报投诉</h3>
            </div>
            <div class="panel-body" style="padding: 10px;">
                <form class="form-inline" style="margin-bottom: 0px;"  method="post" action="list">

                    <div class="form-group">
                        <input type="text" class="form-control" id="reportId"  name="reportId" placeholder="reportId" value="${queryResult.param['reportId']}">
                    </div>

                    <div class="form-group">
                        <input type="text" class="form-control" id="uid"  name="uid" placeholder="举报人" value="${queryResult.param['uid']}">
                    </div>
                    <div class="form-group">
                        <input type="text" class="form-control" id="defendant"  name="defendant" placeholder="被举报人" value="${queryResult.param['defendant']}">
                    </div>

                    <div class="form-group">

                        <select id="reason" name="reason" class="form-control">

                            <option value="" <c:if test="${queryResult.param['reason'] == null}">selected</c:if>>举报原因</option>
                            <option value="1" <c:if test="${queryResult.param['reason'] == 1}">selected</c:if>>色情信息</option>
                            <option value="2"<c:if test="${queryResult.param['reason'] == 2}">selected</c:if>>骚扰信息</option>
                            <option value="3"<c:if test="${queryResult.param['reason'] == 3}">selected</c:if>>虚假广告</option>
                            <option value="4"<c:if test="${queryResult.param['reason'] == 4}">selected</c:if>>欺诈</option>
                            <option value="5"<c:if test="${queryResult.param['reason'] == 5}">selected</c:if>>其它</option>

                        </select>
                    </div>

                    <div class="form-group">

                        <select id="status" name="status" class="form-control">

                            <option value="1"<c:if test="${queryResult.param['status'] == 1}">selected</c:if>>新 建</option>
                            <option value="2"<c:if test="${queryResult.param['status'] == 2}">selected</c:if>>处理中</option>
                            <option value="3"<c:if test="${queryResult.param['status'] == 3}">selected</c:if>>已处理</option>
                            <option value="4"<c:if test="${queryResult.param['status'] == 4}">selected</c:if>>已驳回</option>
                            <option value="" <c:if test="${queryResult.param['status'] == null}">selected</c:if>>所有状态</option>

                        </select>
                    </div>

                    <button type="submit" class="btn btn-default">查找</button>
                </form>
            </div>
        </div>

        <c:if test="${queryResult != null}">
            <div class="panel panel-default" style="margin-bottom: 10px;">
                <!-- Table -->
                <table class="table  table-bordered table-hover table-striped">
                    <thead>
                    <tr>
                        <th>ID</th>
                        <th>举报人</th>
                        <th>被举报人</th>

                        <th>原因</th>
                        <%--<th>原因详细</th>--%>
                        <th>举报时间</th>
                        <%--<th>处理时间</th>--%>
                        <th>STATUS</th>
                        <th>已通知</th>
                        <%--<th>说明</th>--%>
                    </tr>


                    </thead>
                    <tbody>

                    <c:forEach items="${queryResult.list}" var="report">
                        <tr>
                            <%--<td>${report.id}</td>--%>
                            <td><a href="detail?reportId=${report.id}"> ${report.id}</a></td>
                            <td><a href="detail?uid=${report.uid}"> ${report.uid}</a></td>
                            <%--<td>${report.uid}</td>--%>

                            <td><a href="detail?defendant=${report.defendant}"> ${report.defendant}</a></td>

                            <%--<td>${report.defendant}</td>--%>
                            <%--<td>${report.reason}</td>--%>

                            <c:choose>
                                <c:when test="${report.reason == 1}">
                                    <td>色情信息</td>
                                </c:when>

                                <c:when test="${report.reason == 2}">
                                    <td>骚扰信息</td>
                                </c:when>

                                <c:when test="${report.reason == 3}">
                                    <td>虚假广告</td>
                                </c:when>

                                <c:when test="${report.reason == 4}">
                                    <td>欺诈</td>
                                </c:when>
                                <c:when test="${report.reason == 5}">
                                    <td>其它</td>
                                </c:when>
                                <c:otherwise>
                                    <td></td>
                                </c:otherwise>
                            </c:choose>

                            <%--<td>${report.reasonMsg}</td>--%>

                            <td>${report.reportTime}</td>
                            <%--<td>${report.editTime}</td>--%>

                            <c:choose>
                                <c:when test="${report.status == 1}">
                                    <td>新 建</td>
                                </c:when>

                                <c:when test="${report.status == 2}">
                                    <td>处理中</td>
                                </c:when>

                                <c:when test="${report.status == 3}">
                                    <td>已处理</td>
                                </c:when>

                                <c:when test="${report.status == 4}">
                                    <td>已驳回</td>
                                </c:when>

                                <c:otherwise>
                                    <td></td>
                                </c:otherwise>
                            </c:choose>

                            <%--<td>${report.status}</td>--%>

                            <td>${report.haveNoticed}</td>
                            <%--<td>${report.msg}</td>--%>
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
