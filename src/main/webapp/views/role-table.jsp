
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!-- Page Content -->
<div id="page-wrapper">
    <div class="container-fluid">

        <!-- Tiêu đề trang -->
        <div class="row bg-title">
            <div class="col-lg-3 col-md-4 col-sm-4 col-xs-12">
                <h4 class="page-title">Danh sách quyền</h4>
            </div>

            <div class="col-lg-9 col-sm-8 col-md-8 col-xs-12 text-right">
                <a href="${pageContext.request.contextPath}/role-add"
                   class="btn btn-sm btn-success">
                    Thêm mới
                </a>
            </div>
        </div>

        <!-- Bảng danh sách quyền -->
        <div class="row">
            <div class="col-sm-12">
                <div class="white-box">

                    <!-- Chọn số dòng và tìm kiếm -->
                    <form action="${pageContext.request.contextPath}/role-table"
                          method="get"
                          class="row"
                          style="margin-bottom: 20px;">

                        <div class="col-sm-6 col-xs-12"
                             style="margin-bottom: 10px;">

                            <label for="size">Hiển thị</label>

                            <select name="size"
                                    id="size"
                                    class="form-control"
                                    style="display: inline-block; width: auto;"
                                    onchange="this.form.submit()">

                                <option value="5"
                                    ${size == 5 ? 'selected' : ''}>5</option>

                                <option value="10"
                                    ${size == 10 ? 'selected' : ''}>10</option>

                                <option value="25"
                                    ${size == 25 ? 'selected' : ''}>25</option>

                                <option value="50"
                                    ${size == 50 ? 'selected' : ''}>50</option>
                            </select>

                            <span>mục</span>
                        </div>

                        <div class="col-sm-6 col-xs-12 text-right">
                            <label for="keywords">Search:</label>

                            <input type="text"
                                   name="keywords"
                                   id="keywords"
                                   value="<c:out value='${keywords}'/>"
                                   class="form-control"
                                   placeholder="Tên quyền hoặc mô tả"
                                   style="display: inline-block; width: auto; max-width: 220px;">

                            <button type="submit"
                                    class="btn btn-primary">
                                Tìm kiếm
                            </button>
                        </div>
                    </form>

                    <!-- Bảng dữ liệu -->
                    <div class="table-responsive">
                        <table class="table table-striped table-bordered">
                            <thead>
                                <tr>
                                    <th>STT</th>
                                    <th>Tên Quyền</th>
                                    <th>Mô Tả</th>
                                    <th>Hành Động</th>
                                </tr>
                            </thead>

                            <tbody>
                                <c:forEach items="${list}"
                                           var="role"
                                           varStatus="status">

                                    <tr>
                                        <td>
                                            ${(page - 1) * size + status.count}
                                        </td>

                                        <td>
                                            <c:out value="${role.nameRole}"/>
                                        </td>

                                        <td>
                                            <c:out value="${role.description}"/>
                                        </td>

                                        <td>
                                            <!-- Nút sửa -->
                                            <a href="${pageContext.request.contextPath}/role-edit?id=${role.id}"
                                               class="btn btn-sm btn-primary">
                                                Sửa
                                            </a>

                                            <!-- Form xóa -->
                                            <form action="${pageContext.request.contextPath}/role-delete"
                                                  method="post"
                                                  style="display: inline;"
                                                  onsubmit="return confirm('Bạn có chắc chắn muốn xóa quyền này không?');">

                                                <input type="hidden"
                                                       name="id"
                                                       value="${role.id}">

                                                <button type="submit"
                                                        class="btn btn-sm btn-danger">
                                                    Xóa
                                                </button>
                                            </form>
                                        </td>
                                    </tr>
                                </c:forEach>

                                <!-- Không có kết quả -->
                                <c:if test="${empty list}">
                                    <tr>
                                        <td colspan="4" class="text-center">
                                            Không tìm thấy quyền phù hợp.
                                        </td>
                                    </tr>
                                </c:if>
                            </tbody>
                        </table>
                    </div>

                    <!-- Thông tin số dòng -->
                    <div class="row" style="margin-top: 15px;">
                        <div class="col-sm-6 col-xs-12">
                            <p>
                                Hiển thị ${startRecord} đến ${endRecord}
                                của ${totalRecords} mục
                            </p>
                        </div>

                        <!-- Phân trang -->
                        <div class="col-sm-6 col-xs-12 text-right">
                            <ul class="pagination" style="margin: 0;">

                                <!-- Previous -->
                                <li class="${page <= 1 ? 'disabled' : ''}">
                                    <c:choose>
                                        <c:when test="${page > 1}">
                                            <c:url var="previousUrl"
                                                   value="/role-table">
                                                <c:param name="page"
                                                         value="${page - 1}"/>
                                                <c:param name="size"
                                                         value="${size}"/>
                                                <c:param name="keywords"
                                                         value="${keywords}"/>
                                            </c:url>

                                            <a href="${previousUrl}">
                                                Previous
                                            </a>
                                        </c:when>

                                        <c:otherwise>
                                            <span>Previous</span>
                                        </c:otherwise>
                                    </c:choose>
                                </li>

                                <!-- Các số trang -->
                                <c:forEach begin="1"
                                           end="${totalPage}"
                                           var="pageNumber">

                                    <li class="${pageNumber == page ? 'active' : ''}">
                                        <c:url var="numberUrl"
                                               value="/role-table">
                                            <c:param name="page"
                                                     value="${pageNumber}"/>
                                            <c:param name="size"
                                                     value="${size}"/>
                                            <c:param name="keywords"
                                                     value="${keywords}"/>
                                        </c:url>

                                        <a href="${numberUrl}">
                                            ${pageNumber}
                                        </a>
                                    </li>
                                </c:forEach>

                                <!-- Next -->
                                <li class="${page >= totalPage ? 'disabled' : ''}">
                                    <c:choose>
                                        <c:when test="${page < totalPage}">
                                            <c:url var="nextUrl"
                                                   value="/role-table">
                                                <c:param name="page"
                                                         value="${page + 1}"/>
                                                <c:param name="size"
                                                         value="${size}"/>
                                                <c:param name="keywords"
                                                         value="${keywords}"/>
                                            </c:url>

                                            <a href="${nextUrl}">
                                                Next
                                            </a>
                                        </c:when>

                                        <c:otherwise>
                                            <span>Next</span>
                                        </c:otherwise>
                                    </c:choose>
                                </li>

                            </ul>
                        </div>
                    </div>

                </div>
            </div>
        </div>

    </div>
</div>

<!-- Thông báo sau khi thêm, sửa hoặc xóa -->
<script>
    window.addEventListener("DOMContentLoaded", function() {
        const params = new URLSearchParams(window.location.search);

        if (params.get("added") === "1") {
            alert("Thêm quyền thành công!");
        }

        if (params.get("updated") === "1") {
            alert("Cập nhật quyền thành công!");
        }

        if (params.get("deleted") === "1") {
            alert("Xóa quyền thành công!");
        }

        if (params.get("error") === "used") {
            alert("Không thể xóa quyền này vì có thể đang được sử dụng bởi thành viên.");
        }
    });
</script>
