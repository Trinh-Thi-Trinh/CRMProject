
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div id="page-wrapper">
    <div class="container-fluid">

        <div class="row bg-title">
            <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
                <h4 class="page-title">Danh sách dự án</h4>
            </div>
            <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12 text-right">
                <a href="${pageContext.request.contextPath}/groupwork-add"
                   class="btn btn-sm btn-success">
                    <i class="fa fa-plus"></i> Thêm mới
                </a>
            </div>
        </div>

        <!-- Thong bao -->
        <c:if test="${param.added == '1'}">
            <div class="alert alert-success">Thêm dự án thành công.</div>
        </c:if>

        <c:if test="${param.updated == '1'}">
            <div class="alert alert-success">Cập nhật dự án thành công.</div>
        </c:if>

        <c:if test="${param.deleted == '1'}">
            <div class="alert alert-success">Xóa dự án thành công.</div>
        </c:if>

        <c:if test="${param.error == 'used'}">
            <div class="alert alert-warning">
                Không thể xóa dự án vì vẫn còn công việc liên kết.
            </div>
        </c:if>

        <c:if test="${param.error == 'save'}">
            <div class="alert alert-danger">Lưu dự án thất bại.</div>
        </c:if>

        <c:if test="${param.error == 'notfound'}">
            <div class="alert alert-warning">Không tìm thấy dự án.</div>
        </c:if>

        <c:if test="${param.error == 'invalid'}">
            <div class="alert alert-warning">Thông tin dự án không hợp lệ.</div>
        </c:if>

        <div class="row">
            <div class="col-sm-12">
                <div class="white-box">

                    <!-- Tim kiem -->
                    <form action="${pageContext.request.contextPath}/groupwork"
                          method="get" class="form-inline" style="margin-bottom: 20px;">

                        <div class="form-group">
                            <input type="text"
                                   name="keywords"
                                   class="form-control"
                                   placeholder="Nhập tên dự án..."
                                   value="<c:out value='${keywords}'/>">
                        </div>

                        <input type="hidden" name="size" value="${size}">

                        <button type="submit" class="btn btn-info">
                            <i class="fa fa-search"></i> Tìm kiếm
                        </button>

                        <a href="${pageContext.request.contextPath}/groupwork"
                           class="btn btn-default">Làm mới</a>
                    </form>

                    <!-- So ban ghi moi trang -->
                    <form action="${pageContext.request.contextPath}/groupwork"
                          method="get" class="form-inline"
                          style="margin-bottom: 15px;">

                        <input type="hidden" name="keywords"
                               value="<c:out value='${keywords}'/>">

                        <label for="size">Hiển thị:</label>

                        <select name="size" id="size"
                                class="form-control"
                                onchange="this.form.submit()">
                            <option value="5" <c:if test="${size == 5}">selected</c:if>>5</option>
                            <option value="10" <c:if test="${size == 10}">selected</c:if>>10</option>
                            <option value="25" <c:if test="${size == 25}">selected</c:if>>25</option>
                            <option value="50" <c:if test="${size == 50}">selected</c:if>>50</option>
                        </select>

                        <span>bản ghi mỗi trang</span>
                    </form>

                    <!-- Bang du lieu -->
                    <div class="table-responsive">
                        <table class="table table-striped table-hover">
                            <thead>
                                <tr>
                                    <th>STT</th>
                                    <th>Tên dự án</th>
                                    <th>Ngày bắt đầu</th>
                                    <th>Ngày kết thúc</th>
                                    <th>Hành động</th>
                                </tr>
                            </thead>

                            <tbody>
                                <c:choose>
                                    <c:when test="${not empty list}">
                                        <c:forEach var="project" items="${list}" varStatus="status">
                                            <tr>
                                                <td>${(page - 1) * size + status.index + 1}</td>

                                                <td>
                                                    <c:out value="${project.projectName}"/>
                                                </td>

                                                <td>
                                                    <c:choose>
                                                        <c:when test="${not empty project.startDate}">
                                                            <fmt:formatDate value="${project.startDate}"
                                                                pattern="dd/MM/yyyy"/>
                                                        </c:when>
                                                        <c:otherwise>—</c:otherwise>
                                                    </c:choose>
                                                </td>

                                                <td>
                                                    <c:choose>
                                                        <c:when test="${not empty project.endDate}">
                                                            <fmt:formatDate value="${project.endDate}"
                                                                pattern="dd/MM/yyyy"/>
                                                        </c:when>
                                                        <c:otherwise>—</c:otherwise>
                                                    </c:choose>
                                                </td>

                                                <td>
                                                    <a href="${pageContext.request.contextPath}/groupwork-edit?id=${project.id}"
                                                       class="btn btn-sm btn-primary">
                                                        Sửa
                                                    </a>

                                                    <form action="${pageContext.request.contextPath}/groupwork-delete"
                                                          method="post"
                                                          style="display:inline;"
                                                          onsubmit="return confirm('Bạn có chắc muốn xóa dự án này?');">
                                                        <input type="hidden" name="id"
                                                               value="${project.id}">
                                                        <button type="submit"
                                                                class="btn btn-sm btn-danger">
                                                            Xóa
                                                        </button>
                                                    </form>

                                                    <a href="${pageContext.request.contextPath}/groupwork-details?id=${project.id}"
                                                       class="btn btn-sm btn-info">
                                                        Xem
                                                    </a>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </c:when>

                                    <c:otherwise>
                                        <tr>
                                            <td colspan="5" class="text-center">
                                                Không tìm thấy dự án nào.
                                            </td>
                                        </tr>
                                    </c:otherwise>
                                </c:choose>
                            </tbody>
                        </table>
                    </div>

                    <!-- Thong tin phan trang -->
                    <div class="row">
                        <div class="col-sm-6">
                            <p>
                                Hiển thị ${startRecord}–${endRecord}
                                trong tổng số ${totalRecords} dự án
                            </p>
                        </div>

                        <div class="col-sm-6 text-right">
                            <c:if test="${totalPage > 1}">
                                <ul class="pagination">

                                    <c:url var="previousUrl" value="/groupwork">
                                        <c:param name="keywords" value="${keywords}"/>
                                        <c:param name="size" value="${size}"/>
                                        <c:param name="page" value="${page - 1}"/>
                                    </c:url>

                                    <li class="${page <= 1 ? 'disabled' : ''}">
                                        <c:choose>
                                            <c:when test="${page > 1}">
                                                <a href="${previousUrl}">Trước</a>
                                            </c:when>
                                            <c:otherwise>
                                                <span>Trước</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </li>

                                    <c:forEach var="p" begin="1" end="${totalPage}">
                                        <c:url var="numberUrl" value="/groupwork">
                                            <c:param name="keywords" value="${keywords}"/>
                                            <c:param name="size" value="${size}"/>
                                            <c:param name="page" value="${p}"/>
                                        </c:url>

                                        <li class="${p == page ? 'active' : ''}">
                                            <a href="${numberUrl}">${p}</a>
                                        </li>
                                    </c:forEach>

                                    <c:url var="nextUrl" value="/groupwork">
                                        <c:param name="keywords" value="${keywords}"/>
                                        <c:param name="size" value="${size}"/>
                                        <c:param name="page" value="${page + 1}"/>
                                    </c:url>

                                    <li class="${page >= totalPage ? 'disabled' : ''}">
                                        <c:choose>
                                            <c:when test="${page < totalPage}">
                                                <a href="${nextUrl}">Sau</a>
                                            </c:when>
                                            <c:otherwise>
                                                <span>Sau</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </li>

                                </ul>
                            </c:if>
                        </div>
                    </div>

                </div>
            </div>
        </div>

    </div>
</div>
