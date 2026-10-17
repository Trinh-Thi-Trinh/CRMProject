
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!-- Page Content -->
<div id="page-wrapper">
    <div class="container-fluid">

        <!-- Tiêu đề -->
        <div class="row bg-title">
            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                <h4 class="page-title">
                    <c:choose>
                        <c:when test="${mode == 'edit'}">
                            Sửa quyền
                        </c:when>
                        <c:otherwise>
                            Thêm quyền
                        </c:otherwise>
                    </c:choose>
                </h4>
            </div>
        </div>

        <!-- Chỉ có MỘT form thêm/sửa quyền -->
        <div class="row">
            <div class="col-md-2 col-12"></div>

            <div class="col-md-8 col-xs-12">
                <div class="white-box">

                    <form class="form-horizontal form-material"
                          action="${pageContext.request.contextPath}/role-save"
                          method="post">

                        <!-- Giữ ID cũ khi sửa -->
                        <c:if test="${mode == 'edit'}">
                            <input type="hidden"
                                   name="id"
                                   value="${roleEdit.id}">
                        </c:if>

                        <!-- Tên quyền -->
                        <div class="form-group">
                            <label class="col-md-12" for="nameRole">
                                Tên quyền
                            </label>
                            <div class="col-md-12">
                                <input type="text"
                                       id="nameRole"
                                       name="nameRole"
                                       placeholder="Nhập tên quyền"
                                       class="form-control form-control-line"
                                       value="<c:out value='${roleEdit.nameRole}'/>"
                                       required>
                            </div>
                        </div>

                        <!-- Mô tả -->
                        <div class="form-group">
                            <label class="col-md-12" for="description">
                                Mô tả
                            </label>
                            <div class="col-md-12">
                                <input type="text"
                                       id="description"
                                       name="description"
                                       placeholder="Nhập mô tả"
                                       class="form-control form-control-line"
                                       value="<c:out value='${roleEdit.description}'/>">
                            </div>
                        </div>

                        <!-- Nút xác nhận -->
                        <div class="form-group">
                            <div class="col-sm-12">
                                <button type="submit" class="btn btn-success">
                                    <c:choose>
                                        <c:when test="${mode == 'edit'}">
                                            Update
                                        </c:when>
                                        <c:otherwise>
                                            Add Role
                                        </c:otherwise>
                                    </c:choose>
                                </button>

                                <a href="${pageContext.request.contextPath}/role-table"
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
