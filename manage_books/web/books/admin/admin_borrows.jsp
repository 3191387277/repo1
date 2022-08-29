<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ page
        import="com.cya.pojo.History,com.cya.dao.AdminDao,com.cya.dao.TypeDao,com.cya.dao.BookDao,com.cya.pojo.Admin" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8"/>
    <title>图书管理-管理员系统</title>
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
    String aid = (String) session.getAttribute("aid");
    if (aid == null || aid.equals("")) {
        //没有登录
        response.sendRedirect("../login.jsp"); //重定向到登录页面
        return;
    } else {
        AdminDao admindao = new AdminDao();
        admin = admindao.get_AidInfo2(aid);
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
    <img class="img" src="${pageContext.request.contextPath}/books/img/title-yellow1.png"></img>
    <div class="userName">
        <a href="${pageContext.request.contextPath}/books/admin/index.jsp"><% out.write(admin.getName());%></a>
    </div>
    <div class="daohang">
        <ul>
            <li style="margin-left: 100px;">
                <a href="${pageContext.request.contextPath}/books/admin/admin_books.jsp">图书管理</a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/books/admin/admin_booksType.jsp">图书分类管理</a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/books/admin/admin_borrows.jsp">图书借阅信息</a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/books/admin/admin_history.jsp">图书归还信息</a>
            </li>

            <li>
                <a href="${pageContext.request.contextPath}/books/admin/admin_notice.jsp">公告管理</a>
            </li>

            <li>
                <a href="${pageContext.request.contextPath}/books/admin/admin_users.jsp">读者管理</a>
            </li>
            <li class="dropdown">
                <a href="#" class="" role="button" data-hover="dropdown">我的</a>
                <ul class="dropdown-menu">
                    <li><a href="#updateinfo" data-toggle="modal">个人资料</a></li>
                    <li><a href="#updatepwd" data-toggle="modal">修改密码</a></li>
                    <li><a href="${pageContext.request.contextPath}/ExitServlet?id=<%=aid %>&&status=aid">退出</a></li>
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
                <div class="title">公 告</div>
                <div class="context">你是管理员，请<a style="display:inline-block;"
                                               href="${pageContext.request.contextPath}/books/admin/admin_notice.jsp">发布公告</a>
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
                <!-- left, vertical navbar & content -->
                <div class="row">

                    <!-- content -->
                    <div class="col-md-10">


                        <div class="row">
                            <div class="col-lg-12">
                                <div class="panel panel-default bootstrap-admin-no-table-panel">
                                    <div class="panel-heading">
                                        <div class="text-muted bootstrap-admin-box-title">图书借阅信息</div>
                                    </div>

                                </div>
                            </div>
                        </div>


                        <div class="row">
                            <div class="col-lg-12">
                                <table id="data_list" class="table table-hover table-bordered" cellspacing="0"
                                       width="100%">
                                    <thead>
                                    <tr>
                                        <th>图书号</th>
                                        <th>图书名称</th>
                                        <th>读者账号</th>
                                        <th>读者名称</th>
                                        <th>借阅日期</th>
                                        <th>截止还书日期</th>
                                        <th>操作</th>

                                    </tr>
                                    </thead>


                                    <!---在此插入信息-->
                                    <%
                                        ArrayList<History> bookdata = new ArrayList<History>();
                                        bookdata = (ArrayList<History>) request.getAttribute("data");
                                        if (bookdata == null) {
                                            BookDao bookdao = new BookDao();
                                            bookdata = (ArrayList<History>) bookdao.get_HistoryListInfo2(1);
                                        }
                                        for (History bean : bookdata) {
                                    %>
                                    <tbody>
                                    <td><%= bean.getCard() %>
                                    </td>
                                    <td><%= bean.getBookname() %>
                                    </td>
                                    <td><%= bean.getAdminname() %>
                                    </td>
                                    <td><%= bean.getUsername() %>
                                    </td>
                                    <td><%= bean.getBegintime() %>
                                    </td>
                                    <td><%= bean.getEndtime() %>
                                    </td>
                                    <td>
                                        <button type="button" class="btn btn-warning btn-xs" data-toggle="modal"
                                                data-target="#updateModal"
                                                id="btn_update" onclick="haibook(<%= bean.getHid() %>)">还书
                                        </button>
                                    </td>
                                    </tbody>
                                    <%} %>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
                <script type="text/javascript">
                    function haibook(hid) {
                        con = confirm("是否还书?");
                        if (con == true) {
                            location.href = "/manage_books/borrowServlet?tip=2&show=2&hid=" + hid;
                        }
                    }
                </script>

            </div>

        </div>
    </div>

</div>

<div class="foot"><label class="lable">李思思的图书管理系统</label></div>


<!-------------------------个人资料模糊框------------------------------------->

<form class="form-horizontal" method="post" action="/manage_books/AdminServlet">  <!--保证样式水平不混乱-->
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
                    <input type="hidden" name="url" value="admin/admin_borrows">
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
                    <input type="hidden" name="url" value="admin/admin_borrows">
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