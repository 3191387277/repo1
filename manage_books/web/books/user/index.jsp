<%@page import="com.cya.dao.NoticeDao,com.cya.pojo.Notice" %>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ page import="com.cya.pojo.Admin,com.cya.dao.AdminDao" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8"/>
    <title>图书管理-用户系统</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/books/css/bootstrap.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/books/css/bootstrap-theme.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/books/css/bootstrap-admin-theme.css">
    <script src="${pageContext.request.contextPath}/books/js/jquery-3.1.1.min.js"></script>
    <script src="${pageContext.request.contextPath}/books/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/books/js/bootstrap-dropdown.min.js"></script>
    <script src="${pageContext.request.contextPath}/books/js/reader.js"></script>

    <script src="${pageContext.request.contextPath}/books/js/readerUpdateInfo.js"></script>
    <script src="${pageContext.request.contextPath}/books/js/readerUpdatePwd.js"></script>
    <script src="${pageContext.request.contextPath}/books/js/index.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/books/css/index.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/books/css/bootstrap.min.css"/>
    <script type="text/javascript" src="${pageContext.request.contextPath}/books/js/jquery.min.js"></script>

</head>

<body>

<!-- 判断是否已经登录 -->
<%
    Admin admin = new Admin();
    String uid = (String) session.getAttribute("uid");
    if (uid == null || uid.equals("")) {
        //没有登录
        response.sendRedirect("../login.jsp"); //重定向到登录页面
        return;
    } else {
        AdminDao admindao = new AdminDao();
        admin = admindao.get_AidInfo2(uid);
    }

%>
<div id="myCarousel" class="carousel slide" data-ride="carousel" style="float: left">

    <ol class="carousel-indicators">
        <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
        <li data-target="#myCarousel" data-slide-to="1"></li>
        <li data-target="#myCarousel" data-slide-to="2"></li>
    </ol>
    <div class="carousel-inner" role="listbox">
        <div class="item active">
            <img class="first-slide" src="${pageContext.request.contextPath}/books/img/D1.jpg" alt="First slide">
        </div>
        <div class="item">
            <img class="second-slide" src="${pageContext.request.contextPath}/books/img/D2.jpg" alt="Second slide">
        </div>
        <div class="item">
            <img class="third-slide" src="${pageContext.request.contextPath}/books/img/D3.jpg" alt="Third slide">
        </div>
    </div>
</div>
<div class="head">
    <img class="img" src="../img/title-yellow1.png"></img>
    <div class="userName">
        <a href="../user/index.jsp"><% out.write(admin.getName());%></a>
    </div>
    <div class="daohang">
        <ul>
            <li style="margin-left: 100px;">
                <a href="../user/select.jsp">图书查询</a>
            </li>
            <li>
                <a href="../user/borrow.jsp">借阅信息</a>
            </li>
            <li>
                <a href="../user/history.jsp">借阅历史</a>
            </li>
            <li class="dropdown">
                <a href="#" class="" role="button" data-hover="dropdown">我的</a>
                <ul class="dropdown-menu">
                    <li><a href="#updateinfo" data-toggle="modal">个人资料</a></li>
                    <li><a href="#updatepwd" data-toggle="modal">修改密码</a></li>
                    <li><a href="/manage_books/ExitServlet?id=<%=uid %>&&status=uid">退出</a></li>
                </ul>
            </li>
        </ul>
    </div>
</div>
<div style="width: 100%;height: 395px;"></div>
<div class="body">
    <div class="content">
        <div class="left">
            <div class="gongGao">
                <%
                    //获取公告
                    List<Notice> noticeList = new ArrayList<Notice>();
                    NoticeDao noticeDao = new NoticeDao();
                    noticeList = noticeDao.get_ListInfo();
                    if (noticeList.size() <= 0) {
                        Notice notice = new Notice();
                        notice.setnContext("暂无公告，等待管理员发布哦");
                        notice.setnPerson("");
                        notice.setnTime(null);
                        noticeList.add(notice);
                    }
                    System.out.print(noticeList);
                %>
                <div class="title">公 告</div>
                <div class="context import">
                    <marquee width="100%" height="100%" direction="up" scrolldelay="300">
                        <% for (Notice bean : noticeList) { %>
                        <label>发布人：<%=bean.getnPerson() %>
                        </label><br>
                        <label>发布时间：<%=bean.getnTime() %>
                        </label><br>
                        <label><%=bean.getnContext() %>
                        </label><br>
                        <label>-------------------------------------------</label><br>
                        <%} %>
                    </marquee>

                </div>
            </div>
            <div class="gongGao">
                <div class="title">友 情 链 接</div>
                <div class="context" style="height:400px;">
                    <a href="https://www.cnki.net/">《中国知网》</a>
                    <a href="https://zhidao.baidu.com/">《百度知道》</a>
                    <a href="http://www.google.cn/">《谷歌搜索》</a>
                    <a href="https://news.qq.com/">《腾讯新闻》</a>
                </div>
            </div>
            <%--<div class="gongGao" style="height:400px;">
                <div class="title">源 码 下 载</div>
                <div class="context">
                    <div style="font-size:14px; width: 100%;  height: 400px;margin-bottom: 20px;">
                        <div style="padding: 5px;  color: black">
                            <label style="font-size:15px;font-weight: normal;">下载源码请到公众号：C you again</label><br/>
                            <label style="font-size:15px;font-weight: normal;">1、求职者：面试题、面试经验、面试技巧</label><br/>
                            <label style="font-size:15px;font-weight: normal;">2、职场人：技术分享、程序人生</label><br/>
                            <label style="font-size:15px;font-weight: normal;">3、学生党：Java从入门到精通PDF版教程、数据结构与算法、各类系统实战教程</label><br/>
                            <label style="font-size:15px;font-weight: normal;">4、其它：PPT模板、简历模板、计算机使用技术及技巧</label>
                        </div>
                        <img width="160px" style="position: relative;left: 50%;margin-left: -80px;"
                             src="${pageContext.request.contextPath}/books/img/ghz.jpg"/>
                    </div>
                </div>
            </div>--%>
        </div>
        <div class="right">
            <div class="container">

                <div class="row">


                    <div class="col-md-10">
                        <div class="row">
                            <div class="col-md-12">
                                <div class="panel panel-default">
                                    <div class="panel-heading">
                                        <div class="text-muted bootstrap-admin-box-title">图书查询</div>
                                    </div>
                                    <div class="bootstrap-admin-panel-content">
                                        <ul>
                                            <li>根据图书编号、图书名称查询图书信息</li>
                                            <li>可查询图书的编号、名称、分类、作者、价格、在馆数量等</li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-12">
                                <div class="panel panel-default">
                                    <div class="panel-heading">
                                        <div class="text-muted bootstrap-admin-box-title">借阅信息</div>
                                    </div>
                                    <div class="bootstrap-admin-panel-content">
                                        <ul>
                                            <li>可查询除图书的基本信息、借阅日期、截止还书日期、超期天数等</li>
                                        </ul>
                                    </div>
                                </div>
                            </div>

                        </div>

                        <div class="row">
                            <div class="col-md-12">
                                <div class="panel panel-default">
                                    <div class="panel-heading">
                                        <div class="text-muted bootstrap-admin-box-title">借阅历史</div>
                                    </div>
                                    <div class="bootstrap-admin-panel-content">
                                        <ul>
                                            <li>查询自己以往的借阅历史，包括哪些图书等具体信息</li>
                                        </ul>
                                    </div>
                                </div>
                            </div>

                        </div>

                        <div class="row">
                            <div class="col-md-12">
                                <div class="panel panel-default">
                                    <div class="panel-heading">
                                        <div class="text-muted bootstrap-admin-box-title">我的</div>
                                    </div>
                                    <div class="bootstrap-admin-panel-content">
                                        <ul>
                                            <li>查看个人资料</li>
                                            <li>修改账户密码</li>
                                            <li>退出系统</li>
                                        </ul>
                                    </div>
                                </div>
                            </div>

                        </div>

                    </div>
                </div>
            </div>
        </div>
    </div>

</div>

<div class="foot"><label class="lable">李思思的图书管理系统</label></div>


<!-------------------------个人资料模糊框------------------------------------->

<form class="form-horizontal" method="post" action="/manage_books/AdminServlet">   <!--保证样式水平不混乱-->
    <!-- 模态框（Modal） -->
    <div class="modal fade" id="updateinfo" tabindex="-1" role="dialog" aria-labelledby="ModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                        &times;
                    </button>
                    <h4 class="modal-title" id="ModalLabel">
                        个人资料
                    </h4>
                </div>

                <div class="modal-body">

                    <!--正文-->
                    <input type="hidden" name="tip" value="2">
                    <input type="hidden" name="url" value="user/index">
                    <div class="form-group">
                        <label for="firstname" class="col-sm-3 control-label">真实姓名</label>
                        <div class="col-sm-7">
                            <input type="text" class="form-control" id="name" name="name" placeholder="请输入您的真实姓名"
                                   value='<% out.write(admin.getName());%>'>
                            <label class="control-label" for="name" style="display: none"></label>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="firstname" class="col-sm-3 control-label">手机号</label>
                        <div class="col-sm-7">
                            <input type="text" class="form-control" id="phone" name="phone" placeholder="请输入您的手机号"
                                   value='<% out.write(admin.getPhone());%>'>
                            <label class="control-label" for="phone" style="display: none"></label>
                        </div>
                    </div>


                    <div class="form-group">
                        <label for="firstname" class="col-sm-3 control-label">邮箱</label>
                        <div class="col-sm-7">
                            <input type="text" class="form-control" id="email" name="email" placeholder="请输入您的邮箱"
                                   value='<% out.write(admin.getEmail());%>'>
                            <label class="control-label" for="email" style="display: none"></label>
                        </div>
                    </div>

                    <!--正文-->


                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭
                    </button>
                    <button type="submit" class="btn btn-primary">
                        修改
                    </button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal -->
    </div>

</form>
<!-------------------------------------------------------------->

<!-------------------------------------------------------------->

<form class="form-horizontal" method="post" action="/manage_books/AdminServlet">   <!--保证样式水平不混乱-->
    <!-- 模态框（Modal） -->
    <div class="modal fade" id="updatepwd" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
         aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                        &times;
                    </button>
                    <h4 class="modal-title" id="myModalLabel">
                        修改密码
                    </h4>
                </div>
                <div class="modal-body">

                    <!--正文-->
                    <input type="hidden" name="tip" value="1">
                    <input type="hidden" name="url" value="user/index">
                    <div class="form-group">
                        <label for="firstname" class="col-sm-3 control-label">原密码</label>
                        <div class="col-sm-7">
                            <input type="password" class="form-control" name="password" id="oldPwd"
                                   placeholder="请输入原密码">
                            <label class="control-label" for="oldPwd" style="display: none"></label>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="firstname" class="col-sm-3 control-label">新密码</label>
                        <div class="col-sm-7">
                            <input type="password" class="form-control" name="password2" id="newPwd"
                                   placeholder="请输入新密码">
                            <label class="control-label" for="newPwd" style="display: none"></label>
                        </div>
                    </div>

                    <!--正文-->
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭
                    </button>
                    <button type="submit" class="btn btn-primary">
                        修改
                    </button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal -->
    </div>

</form>
<!-------------------------------------------------------------->


</body>


</html>