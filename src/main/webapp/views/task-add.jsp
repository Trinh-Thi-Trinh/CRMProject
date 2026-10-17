
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div id="page-wrapper">
    <div class="container-fluid">

        <div class="row bg-title">
            <div class="col-lg-12">
                <h4 class="page-title">
                    <c:choose>
                        <c:when test="${mode == 'edit'}">
                            Sửa công việc
                        </c:when>
                        <c:otherwise>
                            Thêm mới công việc
                        </c:otherwise>
                    </c:choose>
                </h4>
            </div>
        </div>

        <c:if test="${not empty errorMessage}">
            <div class="alert alert-danger">
                <c:out value="${errorMessage}"/>
            </div>
        </c:if>

        <div class="row">
            <div class="col-md-2 col-12"></div>

            <div class="col-md-8 col-xs-12">
                <div class="white-box">

                    <form class="form-horizontal form-material"
                          action="${pageContext.request.contextPath}/task-save"
                          method="post">

                        <c:if test="${mode == 'edit'}">
                            <input type="hidden" name="id"
                                   value="${taskEdit.id}">
                        </c:if>

                        <div class="form-group">
                            <label class="col-md-12">Dự án</label>
                            <div class="col-md-12">
                                <select name="projectId"
                                        class="form-control form-control-line"
                                        required>
                                    <option value="">-- Chọn dự án --</option>

                                    <c:forEach var="project" items="${projects}">
                                        <option value="${project.id}"
                                            <c:if test="${mode == 'edit' && taskEdit.projectId == project.id}">
                                                selected
                                            </c:if>>
                                            <c:out value="${project.projectName}"/>
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-md-12">Tên công việc</label>
                            <div class="col-md-12">
                                <input type="text"
                                       name="taskName"
                                       placeholder="Nhập tên công việc"
                                       class="form-control form-control-line"
                                       value="<c:out value='${taskEdit.taskName}'/>"
                                       required>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-md-12">Người thực hiện</label>
                            <div class="col-md-12">
                                <select name="userId"
                                        class="form-control form-control-line"
                                        required>
                                    <option value="">-- Chọn người thực hiện --</option>

                                    <c:forEach var="user" items="${users}">
                                        <option value="${user.id}"
                                            <c:if test="${mode == 'edit' && taskEdit.userId == user.id}">
                                                selected
                                            </c:if>>
                                            <c:out value="${user.fullname}"/>
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-md-12">Trạng thái</label>
                            <div class="col-md-12">
                                <select name="statusId"
                                        class="form-control form-control-line"
                                        required>
                                    <option value="">-- Chọn trạng thái --</option>

                                    <c:forEach var="status" items="${statuses}">
                                        <option value="${status.id}"
                                            <c:if test="${mode == 'edit' && taskEdit.statusId == status.id}">
                                                selected
                                            </c:if>>
                                            <c:choose>
                                                <c:when test="${status.nameStatus == 'Chua Thuc Hien'}">
                                                    Chưa thực hiện
                                                </c:when>
                                                <c:when test="${status.nameStatus == 'Dang Thuc Hien'}">
                                                    Đang thực hiện
                                                </c:when>
                                                <c:when test="${status.nameStatus == 'Da Hoan Thanh'}">
                                                    Đã hoàn thành
                                                </c:when>
                                                <c:otherwise>
                                                    <c:out value="${status.nameStatus}"/>
                                                </c:otherwise>
                                            </c:choose>
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-md-12">Ngày bắt đầu</label>
                            <div class="col-md-12">
                                <input type="date"
                                       name="startDate"
                                       class="form-control form-control-line"
                                       value="${taskEdit.startDate}"
                                       required>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-md-12">Ngày kết thúc</label>
                            <div class="col-md-12">
                                <input type="date"
                                       name="endDate"
                                       class="form-control form-control-line"
                                       value="${taskEdit.endDate}"
                                       required>
                            </div>
                        </div>

                        <div class="form-group">
                            <div class="col-sm-12">
                                <button type="submit" class="btn btn-success">
                                    Lưu lại
                                </button>

                                <a href="${pageContext.request.contextPath}/task"
                                   class="btn btn-primary">
                                    Quay lại
                                </a>
                            </div>
                        </div>

                    </form>
                </div>
            </div>

            <div class="col-md-2 col-12"></div>
        </div>

    </div>
</div>
