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
    <title>喊话详情</title>
    <script language="JavaScript">
        function comform(){
            if(window.confirm('确定强制删除该用户的这条喊话？请三思！！！（删除后不可恢复，而且系统会记录您的操作记录）')){
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
                    <h3 class="panel-title">喊话详情
                        <a href="javascript:history.go(-1)"><button  class="btn btn-default"><--返回</button></a>
                    </h3>
                </div>

                <div class="panel-body">
                    <form class="form-inline" method="post" action="detail">
                        <div class="form-group">
                            <input type="text" class="form-control" id="uid"  name="uid" placeholder="uid" value="${uid}">
                            <input type="text" class="form-control" id="askingId"  name="askingId" placeholder="askingId" value="${askingId}">
                        </div>

                        <button type="submit" class="btn btn-default">查找</button>
                    </form>

                    <c:choose>
                        <c:when test='${resultCode == -1}'>
                        </c:when>
                        <c:when test='${resultCode == -2}'>
                            请输入正确的uid或askingId
                        </c:when>
                        <c:when test='${resultCode == -3}'>
                            无对应喊话
                        </c:when>
                        <c:when test='${resultCode == -4}'>
                            出错，请稍后再试
                        </c:when>
                        <c:otherwise>

                            <s:if test="${askingList != null}">
                                <c:forEach items="${askingList}" var="asking">

                                    <div class="panel panel-default">
                                        <div class="panel-heading">
                                            <h3 class="panel-title">
                                                <%--<img src="<%=path%>/img/asking.png"/>--%>
                                                <span class="label label-info">${asking.id}</span>

                                                <span style="float:right;">
                                                    <a href="del?from=asking/detail&uid=${asking.uid}&askingId=${asking.id}" onclick="return comform();" class=""> <button type="button" class="btn btn-danger">强制删除</button></a>

                                                </span>
                                            </h3>

                                        </div>
                                        <div class="panel-body">

                                            <table class="table table-condensed" style="border: none;">
                                                <tbody>

                                                <tr><td style="border: none; font-size: 110%;">${asking.askingDetail}</td></tr>
                                                <tr><td style="border: none;">
                                                    <c:forEach items="${asking.mediaList}" var="media">

                                                        <a href="<%=cdnURL%>/@${media.url}" target="_blank">
                                                            <img src="<%=cdnURL%>/@${media.url}?imageView2/2/w/100/h/100"/>
                                                        </a>
                                                    </c:forEach>
                                                </td></tr>

                                                <tr><td style="border: none; font-size: 90%;"></td></tr>


                                                <tr><td style="border: none; font-size: small; color: #59a8e2"> <img src="<%=path%>/img/location.png"/> ${asking.area} (${asking.longitude}, ${asking.latitude})</td></tr>


                                                <tr><td style="border: none;"> </td></tr>

                                                <tr>
                                                    <td style="border: none; font-size: small; color: #59a8e2">
                                                    (${asking.replyCount})
                                                    </td>
                                                </tr>
                                                <tr><td style="border: none; font-size: 90%; color: #d3d3d3">用户 UID: ${asking.uid}</td></tr>
                                                <tr><td style="border: none; font-size: 90%; color: #d3d3d3">喊话编号: ${asking.id}</td></tr>
                                                <tr><td style="border: none; font-size: 90%; color: #d3d3d3">添加时间: ${asking.addTime}</td></tr>
                                                <tr><td style="border: none; font-size: 90%; color: #d3d3d3">修改时间: ${asking.editTime}</td></tr>
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
