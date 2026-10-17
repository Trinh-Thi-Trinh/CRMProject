
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div id="page-wrapper">
    <div class="container-fluid">

        <!-- Tieu de -->
        <div class="row bg-title">
            <div class="col-md-8 col-sm-8 col-xs-12">
                <h4 class="page-title">Chi tiết dự án</h4>
            </div>

            <div class="col-md-4 col-sm-4 col-xs-12 text-right">
                <a href="${pageContext.request.contextPath}/groupwork"
                   class="btn btn-primary">
                    Quay lại danh sách
                </a>

                <a href="${pageContext.request.contextPath}/groupwork-edit?id=${projectDetail.id}"
                   class="btn btn-success">
                    Sửa dự án
                </a>
            </div>
        </div>

        <!-- Thong tin du an -->
        <div class="row">
            <div class="col-xs-12">
                <div class="white-box">
                    <h3 class="box-title">Thông tin dự án</h3>

                    <c:choose>
                        <c:when test="${not empty projectDetail}">
                            <table class="table table-bordered">
                                <tbody>
                                    <tr>
                                        <th style="width: 200px;">Mã dự án</th>
                                        <td>${projectDetail.id}</td>
                                    </tr>

                                    <tr>
                                        <th>Tên dự án</th>
                                        <td>
                                            <c:out value="${projectDetail.projectName}"/>
                                        </td>
                                    </tr>

                                    <tr>
                                        <th>Ngày bắt đầu</th>
                                        <td>
                                            <c:choose>
                                                <c:when test="${not empty projectDetail.startDate}">
                                                    <fmt:formatDate
                                                        value="${projectDetail.startDate}"
                                                        pattern="dd/MM/yyyy"/>
                                                </c:when>
                                                <c:otherwise>Chưa có</c:otherwise>
                                            </c:choose>
                                        </td>
                                    </tr>

                                    <tr>
                                        <th>Ngày kết thúc</th>
                                        <td>
                                            <c:choose>
                                                <c:when test="${not empty projectDetail.endDate}">
                                                    <fmt:formatDate
                                                        value="${projectDetail.endDate}"
                                                        pattern="dd/MM/yyyy"/>
                                                </c:when>
                                                <c:otherwise>Chưa có</c:otherwise>
                                            </c:choose>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </c:when>

                        <c:otherwise>
                            <div class="alert alert-warning">
                                Không tìm thấy thông tin dự án.
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>

        <!-- Danh sach task theo trang thai -->
        <div class="row">
            <div class="col-xs-12">
                <h3>Danh sách công việc của dự án</h3>
            </div>

            <!-- Chua thuc hien -->
            <div class="col-md-4 col-sm-12">
                <div class="white-box">
                    <h3 class="box-title">Chưa thực hiện</h3>

                    <c:set var="foundNotStarted" value="false"/>

                    <c:forEach var="task" items="${taskList}">
                        <c:if test="${task.statusName == 'Chua Thuc Hien'}">
                            <c:set var="foundNotStarted" value="true"/>

                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <h4>
                                        <c:out value="${task.taskName}"/>
                                    </h4>

                                    <p>
                                        <strong>Bắt đầu:</strong>
                                        <c:choose>
                                            <c:when test="${not empty task.startDate}">
                                                <fmt:formatDate
                                                    value="${task.startDate}"
                                                    pattern="dd/MM/yyyy"/>
                                            </c:when>
                                            <c:otherwise>Chưa có</c:otherwise>
                                        </c:choose>
                                    </p>

                                    <p>
                                        <strong>Kết thúc:</strong>
                                        <c:choose>
                                            <c:when test="${not empty task.endDate}">
                                                <fmt:formatDate
                                                    value="${task.endDate}"
                                                    pattern="dd/MM/yyyy"/>
                                            </c:when>
                                            <c:otherwise>Chưa có</c:otherwise>
                                        </c:choose>
                                    </p>
                                </div>
                            </div>
                        </c:if>
                    </c:forEach>

                    <c:if test="${not foundNotStarted}">
                        <p>Không có công việc nào.</p>
                    </c:if>
                </div>
            </div>

            <!-- Dang thuc hien -->
            <div class="col-md-4 col-sm-12">
                <div class="white-box">
                    <h3 class="box-title">Đang thực hiện</h3>

                    <c:set var="foundInProgress" value="false"/>

                    <c:forEach var="task" items="${taskList}">
                        <c:if test="${task.statusName == 'Dang Thuc Hien'}">
                            <c:set var="foundInProgress" value="true"/>

                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <h4>
                                        <c:out value="${task.taskName}"/>
                                    </h4>

                                    <p>
                                        <strong>Bắt đầu:</strong>
                                        <c:choose>
                                            <c:when test="${not empty task.startDate}">
                                                <fmt:formatDate
                                                    value="${task.startDate}"
                                                    pattern="dd/MM/yyyy"/>
                                            </c:when>
                                            <c:otherwise>Chưa có</c:otherwise>
                                        </c:choose>
                                    </p>

                                    <p>
                                        <strong>Kết thúc:</strong>
                                        <c:choose>
                                            <c:when test="${not empty task.endDate}">
                                                <fmt:formatDate
                                                    value="${task.endDate}"
                                                    pattern="dd/MM/yyyy"/>
                                            </c:when>
                                            <c:otherwise>Chưa có</c:otherwise>
                                        </c:choose>
                                    </p>
                                </div>
                            </div>
                        </c:if>
                    </c:forEach>

                    <c:if test="${not foundInProgress}">
                        <p>Không có công việc nào.</p>
                    </c:if>
                </div>
            </div>

            <!-- Da hoan thanh -->
            <div class="col-md-4 col-sm-12">
                <div class="white-box">
                    <h3 class="box-title">Đã hoàn thành</h3>

                    <c:set var="foundCompleted" value="false"/>

                    <c:forEach var="task" items="${taskList}">
                        <c:if test="${task.statusName == 'Da Hoan Thanh'}">
                            <c:set var="foundCompleted" value="true"/>

                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <h4>
                                        <c:out value="${task.taskName}"/>
                                    </h4>

                                    <p>
                                        <strong>Bắt đầu:</strong>
                                        <c:choose>
                                            <c:when test="${not empty task.startDate}">
                                                <fmt:formatDate
                                                    value="${task.startDate}"
                                                    pattern="dd/MM/yyyy"/>
                                            </c:when>
                                            <c:otherwise>Chưa có</c:otherwise>
                                        </c:choose>
                                    </p>

                                    <p>
                                        <strong>Kết thúc:</strong>
                                        <c:choose>
                                            <c:when test="${not empty task.endDate}">
                                                <fmt:formatDate
                                                    value="${task.endDate}"
                                                    pattern="dd/MM/yyyy"/>
                                            </c:when>
                                            <c:otherwise>Chưa có</c:otherwise>
                                        </c:choose>
                                    </p>
                                </div>
                            </div>
                        </c:if>
                    </c:forEach>

                    <c:if test="${not foundCompleted}">
                        <p>Không có công việc nào.</p>
                    </c:if>
                </div>
            </div>
        </div>

    </div>
</div>
