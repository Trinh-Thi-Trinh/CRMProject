<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  
        <!-- Navigation -->
        <nav class="navbar navbar-default navbar-static-top m-b-0">
            <div class="navbar-header"> 
                <a class="navbar-toggle hidden-sm hidden-md hidden-lg " href="${pageContext.request.contextPath}/assets/javascript:void(0)" data-toggle="collapse" data-target=".navbar-collapse">
                    <i class="fa fa-bars"></i>
                </a>
                <div class="top-left-part">
                    <a class="logo" href="${pageContext.request.contextPath}/assets/index.html">
                        <b>
                            <img src="${pageContext.request.contextPath}/assets/plugins/images/pixeladmin-logo.png" alt="home" />
                        </b>
                        <span class="hidden-xs">
                            <img src="${pageContext.request.contextPath}/assets/plugins/images/pixeladmin-text.png" alt="home" />
                        </span>
                    </a>
                </div>
                <ul class="nav navbar-top-links navbar-left m-l-20 hidden-xs">
                    <li>
                        <form role="search" class="app-search hidden-xs">
                            <input type="text" placeholder="Search..." class="form-control"> 
                            <a href="">
                                <i class="fa fa-search"></i>
                            </a>
                        </form>
                    </li>
                </ul>
                <ul class="nav navbar-top-links navbar-right pull-right">
                    <li>
                        <div class="dropdown">
                            <a class="profile-pic dropdown-toggle" data-toggle="dropdown" href="#"> 
                                <img src="${pageContext.request.contextPath}/assets/plugins/images/users/varun.jpg" alt="user-img" width="36" class="img-circle" />
                                <b class="hidden-xs">Cybersoft</b> 
                            </a>
                            <ul class="dropdown-menu">
                                <li><a href="${pageContext.request.contextPath}/profile">Thông tin cá nhân</a></li>
                                <li><a href="${pageContext.request.contextPath}/profile-edit">Cập nhật thông tin cá nhân</a></li>
                                <li class="divider"></li>
                                <li><a href="${pageContext.request.contextPath}/logout">Đăng xuất</a></li>
                            </ul>
                        </div>
                    </li>
                </ul>
            </div>
            </nav>
            <!-- /.navbar-header -->