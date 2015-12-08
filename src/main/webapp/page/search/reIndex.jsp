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
    <title>重建搜索</title>

</head>

<body>

<div class="wrapper">

    <%--<jsp:include page="../common/head.jsp" flush="true" />--%>
    <%@ include file="../common/head.jsp" %>

    <div class="main-content">


        <div class="panel panel-default" style="margin: 20px;">
            <!-- Table -->
            <div class="panel-heading">
                <h3 class="panel-title">重建搜索</h3>
            </div>

            <div class="panel-body">
                <form class="form-inline" method="post" action="reIndex">


                    <div class="form-group">
                        <textarea class="form-control"  rows="3" name="ids"  placeholder="ids, 一行一条" value="${ids}"></textarea>
                    </div>


                    <button type="submit" class="btn btn-default">重建索引</button>
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
