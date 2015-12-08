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
    <title>举报详情</title>
    <script language="JavaScript">
        function comform(tip){
            if(window.confirm(tip)){
                //alert("确定");
                return true;
            }else{
                //alert("取消");
                return false;
            }
        }
    </script>

</head>

<body>

<div class="wrapper">

    <%--<jsp:include page="../common/head.jsp" flush="true" />--%>
    <%@ include file="../common/head.jsp" %>

    <div class="main-content">


            <div class="panel panel-default" style="margin: 20px;">
                <!-- Table -->
                <div class="panel-heading">
                    <h3 class="panel-title">举报投诉详情
                        <a href="javascript:history.go(-1)"><button  class="btn btn-default"><--返回</button></a>
                    </h3>
                </div>

                <div class="panel-body">
                    <form class="form-inline" method="post" action="detail">
                        <div class="form-group">

                            <input type="text" class="form-control" id="reportId"  name="reportId" placeholder="reportId" value="${reportId}">

                            <input type="text" class="form-control" id="uid"  name="uid" placeholder="举报人" value="${uid}">

                            <input type="text" class="form-control" id="defendant"  name="defendant" placeholder="被举报人" value="${defendant}">

                        </div>

                        <button type="submit" class="btn btn-default">查找</button>
                    </form>

                    <c:choose>
                        <c:when test='${resultCode == -1}'>
                        </c:when>
                        <c:when test='${resultCode == -2}'>
                            请输入正确的reportId或举报人id或被举报人id
                        </c:when>
                        <c:when test='${resultCode == -3}'>
                            无对应记录
                        </c:when>
                        <c:when test='${resultCode == -4}'>
                            出错，请稍后再试
                        </c:when>
                        <c:otherwise>

                            <s:if test="${reportList != null}">
                                <c:forEach items="${reportList}" var="report">

                                    <div class="panel panel-default">
                                        <div class="panel-heading">
                                            <h3 class="panel-title">
                                                <span class="label label-danger">编号:${report.id}</span>
                                                <%--<span style="float:right;">--%>
                                                    <%--&lt;%&ndash;<a href="del?from=label/detail&uid=${label.uid}&labelId=${label.id}" onclick="return comform();" class=""> <button type="button" class="btn btn-danger">强制删除</button></a>&ndash;%&gt;--%>
                                                <%--</span>--%>

                                            </h3>

                                        </div>
                                        <div class="panel-body">

                                            <table class="table table-condensed" style="border: none;">
                                                <tbody>


                                                    <tr>
                                                        <td style="border: none; color: #626c60; font-size: 90%;">主举报人: <a href="<%=path%>/user/detail?uid=${report.uid}" target="_blank"> ${report.uid}</a>
                                                        </td>
                                                    </tr>


                                                    <tr>
                                                        <td style="border: none; color: #626c60; font-size: 90%;">被举报人: <a href="<%=path%>/user/detail?uid=${report.defendant}" target="_blank"> ${report.defendant}</a>
                                                        </td>
                                                    </tr>

                                                    <%--<tr><td style="border: none;">被举报人:${report.defendant}</td></tr>--%>

                                                    <tr>
                                                        <td style="border: none; color: #626c60; font-size: 90%;">举报原因:
                                                            <c:choose>
                                                                <c:when test="${report.reason == 1}">
                                                                色情信息
                                                                </c:when>
                                                                <c:when test="${report.reason == 2}">
                                                                    骚扰信息
                                                                </c:when>
                                                                <c:when test="${report.reason == 3}">
                                                                    虚假广告
                                                                </c:when>
                                                                <c:when test="${report.reason == 4}">
                                                                    欺诈
                                                                </c:when>
                                                                <c:when test="${report.reason == 5}">
                                                                    其它
                                                                </c:when>
                                                                <c:otherwise>
                                                                </c:otherwise>
                                                        </c:choose>

                                                        </td>
                                                    </tr>

                                                    <tr><td style="border: none; color: #626c60; font-size: 90%;">原因详情:</td></tr>

                                                    <tr><td style="border: none;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${report.reasonMsg}</td></tr>

                                                    <tr><td style="border: none;"></td></tr>

                                                    <tr><td style="border: none; color: #626c60; font-size: 90%;">举报时间: ${report.reportTime}</td></tr>
                                                    <tr><td style="border: none; color: #626c60; font-size: 90%;">状&nbsp;&nbsp;&nbsp;&nbsp;态:

                                                        <c:choose>
                                                        <c:when test="${report.status == 1}">
                                                            新 建
                                                        </c:when>

                                                        <c:when test="${report.status == 2}">
                                                            处理中
                                                        </c:when>

                                                        <c:when test="${report.status == 3}">
                                                            已处理
                                                        </c:when>

                                                        <c:when test="${report.status == 4}">
                                                            已驳回
                                                        </c:when>

                                                        <c:otherwise>
                                                        </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    </tr>

                                                    <tr><td style="border: none; color: #626c60; font-size: 90%;">通知被举报人:
                                                        <c:choose>
                                                            <c:when test="${report.haveNoticed == 0}">
                                                                未通知
                                                                <a href="notice?reportId=${report.id}&defendant=${report.defendant}&reason=${report.reason}&params=reportId%3D${reportId}%26uid%3D${uid}%26defendant%3D${defendant}" class=""><button type="button" class="btn btn-default">通知</button></a>

                                                            </c:when>

                                                            <c:when test="${report.status == 1}">
                                                                已通知
                                                            </c:when>


                                                            <c:otherwise>
                                                            </c:otherwise>
                                                        </c:choose>

                                                    </td></tr>

                                                    <tr><td style="border: none; color: #d3d3d3; font-size: 90%;">说&nbsp;&nbsp;明: ${report.msg}</td></tr>
                                                    <tr><td style="border: none; color: #d3d3d3; font-size: 90%;">修改时间; ${report.editTime}</td></tr>


                                                    <tr><td style="border: none; color: #d3d3d3; font-size: 90%;"></td></tr>
                                                    <tr><td style="border: none; color: #d3d3d3; font-size: 90%;"></td></tr>

                                                    <c:if test="${report.status == 1 || report.status == 2}">
                                                        <tr><td style="border: none; font-size: 90%;">修改状态：</td></tr>

                                                        <tr>
                                                            <td style="border: none; color: #d3d3d3; font-size: 90%;">


                                                                    <form class="form-inline" method="post" action="update">

                                                                        <div class="form-group">
                                                                            <input type="hidden" name="msg" value="${report.msg}">
                                                                        </div>

                                                                        <div class="form-group">
                                                                            <input type="hidden" name="params" value="reportId=${reportId}&uid=${uid}&defendant=${defendant}">
                                                                        </div>

                                                                        <div class="form-group">
                                                                            <input type="hidden" name="reportId" value="${report.id}">
                                                                        </div>
                                                                        <div class="form-group">
                                                                            <input type="hidden" name="uid" value="${report.uid}">
                                                                        </div>


                                                                        <div class="form-group">
                                                                            <input type="text" class="form-control" id="note"  name="note" placeholder="修改说明" value="">
                                                                        </div>
                                                                        <div class="form-group">

                                                                            <select name="status" class="form-control">

                                                                                <option value="2" >处理中</option>
                                                                                <option value="3">已处理</option>
                                                                                <option value="4">已驳回</option>

                                                                            </select>
                                                                        </div>
                                                                        <button type="submit" class="btn btn-danger">提交</button>
                                                                    </form>


                                                            </td>
                                                        </tr>
                                                    </c:if>
                                                </tbody>
                                            </table>

                                        </div>
                                    </div>

                                </c:forEach>
                            </s:if>

                        </c:otherwise>
                    </c:choose>



                </div>

            </div>





</div>

</body>
</html>
