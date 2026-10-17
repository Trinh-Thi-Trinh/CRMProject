<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c"
    uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt"
    uri="http://java.sun.com/jsp/jstl/fmt" %>
 <!-- Page Content -->
        <div id="page-wrapper">
            <div class="container-fluid">
                <div class="row bg-title">
                    <div class="col-lg-3 col-md-4 col-sm-4 col-xs-12">
                        <h4 class="page-title">Chi tiết thành viên</h4>
                    </div>
                </div>
                <!-- /.row -->
                <!-- .row -->
                <div class="row">
                    <div class="col-md-4 col-xs-12">
                        <div class="white-box">
                            <div class="user-bg"> <img width="100%" alt="user" src="plugins/images/large/img1.jpg">
                                <div class="overlay-box">
                                    <div class="user-content">
                                        <a href="javascript:void(0)"><img src="plugins/images/users/genu.jpg"
                                                class="thumb-lg img-circle" alt="img"></a>
                                        <h4 class="text-white">${user.fullname}</h4>
										<h5 class="text-white">${user.email}</h5>
                                    </div>
                                </div>
                            </div>
                            
                        </div>
                    </div>
                    <div class="col-md-8 col-xs-12">
                       <!-- BEGIN THỐNG KÊ -->
<div class="row">

    <!-- CHƯA THỰC HIỆN -->
    <div class="col-lg-4 col-md-4 col-sm-12 col-xs-12">
        <div class="white-box">
            <div class="col-in row">
                <div class="col-xs-12">
                    <h3 class="counter text-right m-t-15 text-danger">
                        ${chuaThucHienPercent}%
                    </h3>
                </div>

                <div class="col-xs-12">
                    <h5 class="text-muted vb text-center">
                        CHƯA THỰC HIỆN
                    </h5>
                    <p class="text-center">
                        ${chuaThucHien} công việc
                    </p>
                </div>

                <div class="col-md-12 col-sm-12 col-xs-12">
                    <div class="progress">
                        <div class="progress-bar progress-bar-danger"
                             role="progressbar"
                             aria-valuenow="${chuaThucHienPercent}"
                             aria-valuemin="0"
                             aria-valuemax="100"
                             style="width: ${chuaThucHienPercent}%">
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- ĐANG THỰC HIỆN -->
    <div class="col-lg-4 col-md-4 col-sm-12 col-xs-12">
        <div class="white-box">
            <div class="col-in row">
                <div class="col-xs-12">
                    <h3 class="counter text-right m-t-15 text-megna">
                        ${dangThucHienPercent}%
                    </h3>
                </div>

                <div class="col-xs-12">
                    <h5 class="text-muted vb text-center">
                        ĐANG THỰC HIỆN
                    </h5>
                    <p class="text-center">
                        ${dangThucHien} công việc
                    </p>
                </div>

                <div class="col-md-12 col-sm-12 col-xs-12">
                    <div class="progress">
                        <div class="progress-bar progress-bar-megna"
                             role="progressbar"
                             aria-valuenow="${dangThucHienPercent}"
                             aria-valuemin="0"
                             aria-valuemax="100"
                             style="width: ${dangThucHienPercent}%">
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- ĐÃ HOÀN THÀNH -->
    <div class="col-lg-4 col-md-4 col-sm-12 col-xs-12">
        <div class="white-box">
            <div class="col-in row">
                <div class="col-xs-12">
                    <h3 class="counter text-right m-t-15 text-primary">
                        ${daHoanThanhPercent}%
                    </h3>
                </div>

                <div class="col-xs-12">
                    <h5 class="text-muted vb text-center">
                        ĐÃ HOÀN THÀNH
                    </h5>
                    <p class="text-center">
                        ${daHoanThanh} công việc
                    </p>
                </div>

                <div class="col-md-12 col-sm-12 col-xs-12">
                    <div class="progress">
                        <div class="progress-bar progress-bar-primary"
                             role="progressbar"
                             aria-valuenow="${daHoanThanhPercent}"
                             aria-valuemin="0"
                             aria-valuemax="100"
                             style="width: ${daHoanThanhPercent}%">
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

</div>

	<!-- END THỐNG KÊ -->

                    </div>
                </div><br />
                <!-- /.row -->
                <!-- BEGIN DANH SÁCH CÔNG VIỆC -->
                <!-- BEGIN DANH SÁCH CÔNG VIỆC -->
<h4>DANH SÁCH CÔNG VIỆC</h4>

<p>
    Tổng số công việc: <strong>${totalTasks}</strong>
</p>

<div class="row">

    <!-- CHƯA THỰC HIỆN -->
    <div class="col-md-4">
        <div class="white-box">
            <h3 class="box-title">Chưa thực hiện</h3>

            <div class="message-center">
                <c:set var="foundPending" value="false" />

                <c:forEach var="task" items="${tasks}">
                    <c:if test="${task.statusId == 2}">
                        <c:set var="foundPending" value="true" />

                        <a href="javascript:void(0)">
                            <div class="mail-contnet">
                                <h5>${task.taskName}</h5>

                                <span class="mail-desc">
                                    Dự án: ${task.projectName}
                                </span>

                                <span class="time">
                                    Bắt đầu:
                                    <c:choose>
                                        <c:when test="${not empty task.startDate}">
                                            <fmt:formatDate
                                                value="${task.startDate}"
                                                pattern="dd/MM/yyyy" />
                                        </c:when>
                                        <c:otherwise>Chưa có</c:otherwise>
                                    </c:choose>
                                </span>

                                <span class="time">
                                    Kết thúc:
                                    <c:choose>
                                        <c:when test="${not empty task.endDate}">
                                            <fmt:formatDate
                                                value="${task.endDate}"
                                                pattern="dd/MM/yyyy" />
                                        </c:when>
                                        <c:otherwise>Chưa có</c:otherwise>
                                    </c:choose>
                                </span>
                            </div>
                        </a>
                    </c:if>
                </c:forEach>

                <c:if test="${not foundPending}">
                    <p>Không có công việc chưa thực hiện.</p>
                </c:if>
            </div>
        </div>
    </div>

    <!-- ĐANG THỰC HIỆN -->
    <div class="col-md-4">
        <div class="white-box">
            <h3 class="box-title">Đang thực hiện</h3>

            <div class="message-center">
                <c:set var="foundInProgress" value="false" />

                <c:forEach var="task" items="${tasks}">
                    <c:if test="${task.statusId == 1}">
                        <c:set var="foundInProgress" value="true" />

                        <a href="javascript:void(0)">
                            <div class="mail-contnet">
                                <h5>${task.taskName}</h5>

                                <span class="mail-desc">
                                    Dự án: ${task.projectName}
                                </span>

                                <span class="time">
                                    Bắt đầu:
                                    <c:choose>
                                        <c:when test="${not empty task.startDate}">
                                            <fmt:formatDate
                                                value="${task.startDate}"
                                                pattern="dd/MM/yyyy" />
                                        </c:when>
                                        <c:otherwise>Chưa có</c:otherwise>
                                    </c:choose>
                                </span>

                                <span class="time">
                                    Kết thúc:
                                    <c:choose>
                                        <c:when test="${not empty task.endDate}">
                                            <fmt:formatDate
                                                value="${task.endDate}"
                                                pattern="dd/MM/yyyy" />
                                        </c:when>
                                        <c:otherwise>Chưa có</c:otherwise>
                                    </c:choose>
                                </span>
                            </div>
                        </a>
                    </c:if>
                </c:forEach>

                <c:if test="${not foundInProgress}">
                    <p>Không có công việc đang thực hiện.</p>
                </c:if>
            </div>
        </div>
    </div>

    <!-- ĐÃ HOÀN THÀNH -->
    <div class="col-md-4">
        <div class="white-box">
            <h3 class="box-title">Đã hoàn thành</h3>

            <div class="message-center">
                <c:set var="foundCompleted" value="false" />

                <c:forEach var="task" items="${tasks}">
                    <c:if test="${task.statusId == 3}">
                        <c:set var="foundCompleted" value="true" />

                        <a href="javascript:void(0)">
                            <div class="mail-contnet">
                                <h5>${task.taskName}</h5>

                                <span class="mail-desc">
                                    Dự án: ${task.projectName}
                                </span>

                                <span class="time">
                                    Bắt đầu:
                                    <c:choose>
                                        <c:when test="${not empty task.startDate}">
                                            <fmt:formatDate
                                                value="${task.startDate}"
                                                pattern="dd/MM/yyyy" />
                                        </c:when>
                                        <c:otherwise>Chưa có</c:otherwise>
                                    </c:choose>
                                </span>

                                <span class="time">
                                    Kết thúc:
                                    <c:choose>
                                        <c:when test="${not empty task.endDate}">
                                            <fmt:formatDate
                                                value="${task.endDate}"
                                                pattern="dd/MM/yyyy" />
                                        </c:when>
                                        <c:otherwise>Chưa có</c:otherwise>
                                    </c:choose>
                                </span>
                            </div>
                        </a>
                    </c:if>
                </c:forEach>

                <c:if test="${not foundCompleted}">
                    <p>Không có công việc đã hoàn thành.</p>
                </c:if>
            </div>
        </div>
    </div>

</div>

                <!-- END DANH SÁCH CÔNG VIỆC -->
            </div>