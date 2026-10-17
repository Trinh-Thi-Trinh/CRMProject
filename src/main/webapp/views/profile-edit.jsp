
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!-- Page Content -->
<div id="page-wrapper">
    <div class="container-fluid">

        <div class="row bg-title">
            <div class="col-lg-3 col-md-4 col-sm-4 col-xs-12">
                <h4 class="page-title">Cập nhật thông tin cá nhân</h4>
            </div>
        </div>

        <div class="row">
            <div class="col-md-2 col-12"></div>

            <div class="col-md-8 col-xs-12">
                <div class="white-box">

                    <c:if test="${not empty error}">
                        <div class="alert alert-danger">
                            <c:out value="${error}" />
                        </div>
                    </c:if>

                    <form class="form-horizontal form-material"
                          method="post"
                          action="${pageContext.request.contextPath}/profile-edit">

                        <div class="form-group">
                            <label class="col-md-12">Họ và tên</label>
                            <div class="col-md-12">
                                <input type="text"
                                       name="fullname"
                                       value="<c:out value='${userEdit.fullname}'/>"
                                       class="form-control form-control-line"
                                       required>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-md-12">Email</label>
                            <div class="col-md-12">
                                <input type="email"
                                       name="email"
                                       value="<c:out value='${userEdit.email}'/>"
                                       class="form-control form-control-line"
                                       required>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-md-12">Số điện thoại</label>
                            <div class="col-md-12">
                                <input type="text"
                                       name="phone"
                                       value="<c:out value='${userEdit.phone}'/>"
                                       class="form-control form-control-line"
                                       required>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-md-12">Quốc gia</label>
                            <div class="col-md-12">
                                <input type="text"
                                       name="country"
                                       value="<c:out value='${userEdit.country}'/>"
                                       class="form-control form-control-line">
                            </div>
                        </div>

                        <div class="form-group">
                            <div class="col-sm-12">
                                <button type="submit" class="btn btn-success">
                                    Lưu thay đổi
                                </button>

                                <a href="${pageContext.request.contextPath}/profile"
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
<!-- /.Page Content -->
