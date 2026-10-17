
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div id="page-wrapper">
    <div class="container-fluid">

        <div class="row bg-title">
            <div class="col-lg-12">
                <h4 class="page-title">
                    <c:choose>
                        <c:when test="${mode == 'edit'}">Sửa dự án</c:when>
                        <c:otherwise>Thêm mới dự án</c:otherwise>
                    </c:choose>
                </h4>
            </div>
        </div>

        <div class="row">
            <div class="col-md-2 col-xs-12"></div>

            <div class="col-md-8 col-xs-12">
                <div class="white-box">

                    <c:if test="${not empty errorMessage}">
                        <div class="alert alert-danger">
                            <c:out value="${errorMessage}"/>
                        </div>
                    </c:if>

                    <form class="form-horizontal form-material"
                          action="${pageContext.request.contextPath}/groupwork-save"
                          method="post">

                        <!-- ID chi can khi sua -->
                        <c:if test="${mode == 'edit'}">
                            <input type="hidden" name="id"
                                   value="${projectEdit.id}">
                        </c:if>

                        <div class="form-group">
                            <label class="col-md-12">Tên dự án</label>
                            <div class="col-md-12">
                                <input type="text"
                                       name="projectName"
                                       class="form-control form-control-line"
                                       placeholder="Nhập tên dự án"
                                       value="<c:out value='${projectEdit.projectName}'/>"
                                       maxlength="255"
                                       required>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-md-12">Ngày bắt đầu</label>
                            <div class="col-md-12">
                                <input type="date"
                                       name="startDate"
                                       class="form-control form-control-line"
                                       value="${projectEdit.startDate}"
                                       required>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-md-12">Ngày kết thúc</label>
                            <div class="col-md-12">
                                <input type="date"
                                       name="endDate"
                                       class="form-control form-control-line"
                                       value="${projectEdit.endDate}"
                                       required>
                            </div>
                        </div>

                        <div class="form-group">
                            <div class="col-sm-12">
                                <button type="submit" class="btn btn-success">
                                    Lưu lại
                                </button>

                                <a href="${pageContext.request.contextPath}/groupwork"
                                   class="btn btn-primary">
                                    Quay lại
                                </a>
                            </div>
                        </div>

                    </form>

                </div>
            </div>

            <div class="col-md-2 col-xs-12"></div>
        </div>

    </div>
</div>
