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
    <title>用户详情</title>

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
            <div class="panel-heading">
                <h3 class="panel-title">用户详情

                    <a href="javascript:history.go(-1)"><button  class="btn btn-default"> << 返回</button></a>

                    <span style="float:right;">
                        <%--<button href="#" class="btn btn-danger">禁用该账号</button>--%>

                        <c:if test="${userOnline.userType == 3}">
                            <c:choose>
                                <c:when test="${userInfo.userType == 1}">
                                    <a href="update?&uid=${userInfo.uid}&userType=2" onclick="return comform('确定设置该用户为管理员？');" class=""><button type="button" class="btn btn-danger">设置为管理员</button></a>
                                </c:when>
                                <c:when test="${userInfo.userType == 2}">
                                    <a href="update?&uid=${userInfo.uid}&userType=1" onclick="return comform('确定取消该用户管理员资格？');" class=""><button type="button" class="btn btn-danger">取消管理员资格</button></a>
                                </c:when>
                                <c:otherwise>
                                </c:otherwise>
                            </c:choose>
                        </c:if>


                        <c:choose>
                            <c:when test="${userInfo.status == 1}">
                                <a href="update?&uid=${userInfo.uid}&status=3" onclick="return comform('确定禁用该账号吗？请三思！！！（禁用后相应用户将无法正常使用）');" class=""><button type="button" class="btn btn-danger">禁用该账号</button></a>
                            </c:when>
                            <c:when test="${userInfo.status == 2}">
                                <a href="update?&uid=${userInfo.uid}&status=1" onclick="return comform('确定恢复该账号吗？');" class=""><button type="button" class="btn btn-danger">恢复该账号</button></a>
                            </c:when>
                            <c:when test="${userInfo.status == 3}">
                                <a href="update?&uid=${userInfo.uid}&status=1" onclick="return comform('确定恢复该账号吗？');" class=""><button type="button" class="btn btn-danger">恢复该账号</button></a>
                            </c:when>
                            <c:otherwise>
                            </c:otherwise>
                        </c:choose>

                    </span>

                </h3>
            </div>
            <div class="panel-body">
                <form class="form-inline" method="post" action="detail">
                    <div class="form-group">
                        <input type="text" class="form-control" id="uid"  name="uid" placeholder="uid" value="${userInfo.uid}">
                    </div>
                    <button type="submit" class="btn btn-default">查找</button>
                </form>
                <c:choose>
                    <c:when test='${resultCode == -1}'>
                    </c:when>
                    <c:when test='${resultCode == -2}'>
                        请输入正确的uid
                    </c:when>
                    <c:when test='${resultCode == -3}'>
                        无此用户
                    </c:when>
                    <c:otherwise>

                            <div class="panel panel-default" style="margin-bottom: 10px;">
                                <!-- Table -->
                                <div class="panel-heading">
                                    <h3 class="panel-title"><span class="label label-primary">账号信息</span>


                                    <c:choose>
                                        <c:when test="${userInfo.userType == 2}">
                                            <span class="label label-info">管理员</span>
                                        </c:when>
                                        <c:otherwise>
                                        </c:otherwise>
                                    </c:choose>

                                    </h3>

                                </div>
                                <table class="table table-bordered table-condensed">
                                    <tbody>
                                    <tr>
                                        <td>UID:</td>
                                        <td>${userInfo.uid}</td>
                                        <td>区 号:</td>
                                        <td>${userInfo.areaCode}</td>

                                    </tr>
                                    <tr>
                                        <td>淘人id:</td>
                                        <td>${userInfo.trId}</td>

                                        <td>手 机:</td>
                                        <td>${userInfo.phone}</td>
                                    </tr>


                                    <tr>
                                        <td>状 态:</td>
                                        <%--<td>${userInfo.status}</td>--%>
                                        <c:choose>
                                            <c:when test="${userInfo.status == 1}">
                                                <td>正 常</td>
                                            </c:when>
                                            <c:when test="${userInfo.status == 2}">
                                                <td>已经注销</td>
                                            </c:when>
                                            <c:when test="${userInfo.status == 3}">
                                                <td>已被禁用</td>
                                            </c:when>
                                            <c:otherwise>
                                                <td></td>
                                            </c:otherwise>
                                        </c:choose>

                                        <td>是否隐身:</td>
                                        <%--<td>${userInfo.privacyFind}</td>--%>
                                        <c:choose>
                                            <c:when test="${userInfo.privacyFind == 2}">
                                                <td>是</td>
                                            </c:when>
                                            <c:otherwise>
                                                <td></td>
                                            </c:otherwise>
                                        </c:choose>

                                    </tr>

                                    <tr>
                                        <td>环信状态:</td>
                                        <%--<td>${userInfo.easemobStatus}</td>--%>
                                        <c:choose>
                                            <c:when test="${userInfo.easemobStatus == 1}">
                                                <td>已创建</td>
                                            </c:when>
                                            <c:otherwise>
                                                <td>未创建</td>
                                            </c:otherwise>
                                        </c:choose>

                                        <td>陌生人消息:</td>
                                        <%--<td>${userInfo.privacyStrangerTalk}</td>--%>
                                        <c:choose>
                                            <c:when test="${userInfo.privacyStrangerTalk == 2}">
                                                <td>不接收</td>
                                            </c:when>
                                            <c:otherwise>
                                                <td>正常接收</td>
                                            </c:otherwise>
                                        </c:choose>
                                    </tr>

                                    <tr>
                                        <td>注册设备:</td>
                                        <td colspan ="3">${userInfo.deviceType}</td>
                                    </tr>

                                    <tr>
                                        <td>创建时间:</td>
                                        <td colspan ="3">${userInfo.createTime}</td>
                                    </tr>

                                    </tbody>
                                </table>
                            </div>
                            <div class="panel panel-default" style="margin-bottom: 10px;">
                                <!-- Table -->
                                <div class="panel-heading">
                                    <h3 class="panel-title"><span class="label label-primary">基本资料</span></h3>
                                </div>
                                <table class="table table-bordered table-condensed">
                                    <tr>
                                        <img>
                                        <td>昵 称:</td>
                                        <td>${userInfo.nickname}
                                            <span style="float:right;">
                                                <form class="form-inline" method="post" action="update?uid=${userInfo.uid}">
                                                    <div class="form-group">
                                                        <input type="text" class="form-control" id="nicknameNew"  name="nicknameNew" placeholder="修改昵称" value="">
                                                    </div>
                                                    <button type="submit" class="btn btn-default" onclick="return comform('确认修改用户昵称？');">修改</button>
                                                </form>
                                            </span>
                                        </td>
                                            <%--<td colspan ="3" rowspan="6">--%>
                                            <%--<img src="<%=cdnURL%>/@${userInfo.avatar}?imageView2/2/w/203/h/203"/>--%>
                                            <%--</td>--%>

                                        <td colspan ="3" rowspan="6">
                                            <img src="<%=cdnURL%>/@${userInfo.avatar}?imageView2/2/w/203/h/203"/>
                                        </td>


                                    </tr>


                                    <tr>
                                        <td>性 别:</td>
                                        <%--<td>${userInfo.gender}</td>--%>
                                        <c:choose>
                                            <c:when test="${userInfo.gender == 1}">
                                                <td>男
                                                    <span style="float:right;">

                                                        <a href="update?&uid=${userInfo.uid}&gender=2" onclick="return comform('确认修改用户性别？');" class=""><button type="button" class="btn btn-default">修改</button></a>
                                                    </span>
                                                </td>


                                            </c:when>
                                            <c:when test="${userInfo.gender == 2}">
                                                <td>女
                                                     <span style="float:right;">

                                                        <a href="update?&uid=${userInfo.uid}&gender=1" onclick="return comform('确认修改用户性别？');" class=""><button type="button" class="btn btn-default">修改</button></a>
                                                    </span>
                                                </td>
                                            </c:when>
                                            <c:otherwise>
                                                <td>未确认，可能是中性
                                                    <span style="float:right;">

                                                        <a href="update?&uid=${userInfo.uid}&gender=1" onclick="return comform('确认修改用户性别？');" class=""><button type="button" class="btn btn-default">修改</button></a>
                                                    </span>
                                                </td>
                                            </c:otherwise>
                                        </c:choose>

                                    </tr>

                                    <tr>
                                        <td>生 日:</td>
                                        <%--<td>${userInfo.birthday}</td>--%>
                                        <td><fmt:formatDate  value="${userInfo.birthday}" type="both" pattern="yyyy-MM-dd" /></td>
                                    </tr>

                                    <tr>
                                        <td>邮 箱:</td>
                                        <td>${userInfo.email}</td>
                                    </tr>

                                    <tr>
                                        <td>Q Q:</td>
                                        <td>${userInfo.qq}</td>
                                    </tr>

                                    <tr>
                                        <td>微 信:</td>
                                        <td>${userInfo.weChat}</td>
                                    </tr>
                                    <tr>
                                        <td>星座:</td>
                                        <td>${userInfo.astrology}</td>
                                        <td>情感:</td>
                                        <td>${userInfo.relationship}</td>
                                    </tr>
                                    <tr>
                                        <td>家 乡:</td>
                                        <td>${userInfo.hometown}</td>
                                        <td>区 域:</td>
                                        <td>${userInfo.region}</td>
                                    </tr>
                                    <tr>
                                        <td>学 校:</td>
                                        <td colspan="3">${userInfo.school}</td>
                                    </tr>
                                    <tr>
                                        <td>主 页:</td>
                                        <td colspan="3">${userInfo.homepage}</td>
                                    </tr>

                                    <tr>

                                        <td>工 作:</td>
                                        <td>${userInfo.job}</td>
                                        <td>兴趣爱好:</td>
                                        <td>${userInfo.hobby}</td>
                                    </tr>

                                    <tr>
                                        <td>个性签名:</td>
                                        <td colspan="3">${userInfo.signature}</td>
                                    </tr>

                                    <tr>
                                        <td>信息更新时间:</td>
                                        <td colspan="3">${userInfo.infoUpdateTime}</td>
                                    </tr>

                                    </tbody>
                                </table>
                            </div>


                            <div class="panel panel-default" style="margin-bottom: 10px;">
                                <!-- Table -->
                                <div class="panel-heading">
                                    <h3 class="panel-title"><span class="label label-primary">最后活沃</span></h3>
                                </div>
                                <table class="table table-bordered table-condensed">
                                    <tbody>

                                    <tr>
                                        <td>经 度:</td>
                                        <td>${userInfo.longitude}</td>
                                    </tr>
                                    <tr>
                                        <td>纬 度:</td>
                                        <td>${userInfo.latitude}</td>
                                    </tr>

                                    <tr>

                                        <td>活跃时间:</td>
                                            <%--<td>${userInfo.activeTime}</td>--%>
                                        <td><fmt:formatDate  value="${userInfo.activeTime}" type="both" pattern="yyyy-MM-dd hh:mm:ss" /></td>

                                    </tr>
                                    </tbody>
                                </table>
                            </div>






                    </c:otherwise>
                </c:choose>



            </div>
        </div>



        <s:if test="${labelList != null}">
            <div class="panel panel-default" style="margin: 20px;">
                <!-- Table -->
                <div class="panel-heading">
                    <h3 class="panel-title"><span class="label label-primary">用户标签</span></h3>
                </div>


                <c:forEach items="${labelList}" var="label">

                    <div class="panel panel-default" style="margin: 10px;">
                        <div class="panel-heading">
                            <h3 class="panel-title"><img src="<%=path%>/img/label.png"/>
                                <span class="label label-info">${label.labelName}</span>
                                <span style="float:right;">
                                    <a href="<%=path%>/label/del?from=user/detail&uid=${label.uid}&labelId=${label.id}" onclick="return comform('确定删除该用户的这条标签？请三思！！！（删除后不可恢复，而且系统会记录您的操作记录）');" class="">
                                        <button type="button" class="btn btn-danger">强制删除</button>
                                    </a>
                                </span>
                            </h3>
                        </div>
                        <div class="panel-body">

                            <table class="table table-condensed" style="border: none;">
                                <tbody>

                                    <tr><td style="border: none; font-size: 110%;">${label.labelDetail}</td></tr>
                                    <tr><td style="border: none;">
                                        <c:forEach items="${label.mediaList}" var="media">

                                            <%--<a href="<%=cdnURL%>/@${media.url}" target="_blank">--%>
                                            <%--<img src="<%=cdnURL%>/@${media.url}?imageView2/2/w/50/h/50"/>--%>
                                            <%--</a>--%>

                                            <a href="<%=cdnURL%>/@${media.url}" target="_blank">
                                                <img src="<%=cdnURL%>/@${media.url}?imageView2/2/w/100/h/100"/>
                                            </a>
                                        </c:forEach>
                                    </td></tr>

                                    <tr><td style="border: none; font-size: 90%;"></td></tr>

                                    <c:choose>
                                        <c:when test="${label.positionType == 1}">
                                            <tr><td style="border: none; font-size: small; color: #59a8e2"> <img src="<%=path%>/img/location.png"/> ${label.area} (${label.longitude}, ${label.latitude})</td></tr>

                                        </c:when>
                                        <c:otherwise>
                                        </c:otherwise>
                                    </c:choose>

                                    <tr><td style="border: none;"> </td></tr>

                                    <tr><td style="border: none; font-size: small; color: #59a8e2">
                                        <img src="<%=path%>/img/zan.png"/>
                                        <c:forEach items="${label.zanUserList}" var="zanUser">

                                            <%--<a href="<%=cdnURL%>/@${media.url}" target="_blank">--%>
                                            <%--<img src="<%=cdnURL%>/@${media.url}?imageView2/2/w/50/h/50"/>--%>
                                            <%--</a>--%>

                                            <a href="detail?uid=${zanUser.uid}" target="_blank">
                                                <img class="img-circle" src="<%=cdnURL%>/@${zanUser.avatar}?imageView2/2/w/30/h/30"/>
                                            </a>

                                        </c:forEach>
                                           (${label.zan})
                                    </td></tr>
                                    <tr><td style="border: none; font-size: 90%; color: #d3d3d3">用户 UID: ${label.uid}</td></tr>
                                    <tr><td style="border: none; font-size: 90%; color: #d3d3d3">标签编号: ${label.id}</td></tr>
                                    <tr><td style="border: none; font-size: 90%; color: #d3d3d3">添加时间: ${label.addTime}</td></tr>
                                    <tr><td style="border: none; font-size: 90%; color: #d3d3d3">修改时间: ${label.editTime}</td></tr>
                                </tbody>
                            </table>

                        </div>
                    </div>


                </c:forEach>


            </div>
        </s:if>




</div>

</body>
</html>
