
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div id="page-wrapper">
    <div class="container-fluid">

        <!-- Tiêu đề trang -->
        <div class="row bg-title">
            <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
                <h4 class="page-title">Danh sách công việc</h4>
            </div>

            <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12 text-right">
                <a href="${pageContext.request.contextPath}/task-add"
                   class="btn btn-sm btn-success">
                    Thêm mới
                </a>
            </div>
        </div>

        <!-- Thông báo kết quả -->
        <c:if test="${param.added == '1'}">
            <div class="alert alert-success">
                Thêm công việc thành công!
            </div>
        </c:if>

        <c:if test="${param.updated == '1'}">
            <div class="alert alert-success">
                Cập nhật công việc thành công!
            </div>
        </c:if>

        <c:if test="${param.deleted == '1'}">
            <div class="alert alert-success">
                Xóa công việc thành công!
            </div>
        </c:if>

        <c:if test="${param.deleted == '0'}">
            <div class="alert alert-warning">
                Không tìm thấy công việc cần xóa.
            </div>
        </c:if>

        <c:if test="${param.error == 'notfound'}">
            <div class="alert alert-danger">
                Không tìm thấy công việc.
            </div>
        </c:if>

        <c:if test="${param.error == 'save'}">
            <div class="alert alert-danger">
                Không thể lưu công việc.
            </div>
        </c:if>

        <c:if test="${param.error == 'invalid'}">
            <div class="alert alert-danger">
                Tham số không hợp lệ. Vui lòng thử lại.
            </div>
        </c:if>

        <!-- Nội dung bảng -->
        <div class="row">
            <div class="col-sm-12">
                <div class="white-box">

                    <!-- Search và chọn số dòng -->
                    <form action="${pageContext.request.contextPath}/task"
                          method="get"
                          class="row"
                          style="margin-bottom: 20px;">

                        <div class="col-md-4 col-sm-4"
                             style="margin-bottom: 10px;">

                            <label for="pageSize">Show </label>

                            <select id="pageSize"
                                    name="pageSize"
                                    class="form-control"
                                    style="display: inline-block; width: auto;"
                                    onchange="this.form.submit()">

                                <option value="10"
                                    ${pageSize == 10 ? 'selected' : ''}>
                                    10
                                </option>

                                <option value="25"
                                    ${pageSize == 25 ? 'selected' : ''}>
                                    25
                                </option>

                                <option value="50"
                                    ${pageSize == 50 ? 'selected' : ''}>
                                    50
                                </option>

                                <option value="100"
                                    ${pageSize == 100 ? 'selected' : ''}>
                                    100
                                </option>
                            </select>

                            <span> entries</span>
                        </div>

                        <div class="col-md-8 col-sm-8 text-right"
                             style="margin-bottom: 10px;">

                            <label for="keyword">Search: </label>

                            <input type="text"
                                   id="keyword"
                                   name="keyword"
                                   value="<c:out value='${keyword}'/>"
                                   class="form-control"
                                   placeholder="Nhập từ khóa tìm kiếm..."
                                   style="display: inline-block; width: 45%;">

                            <button type="submit"
                                    class="btn btn-primary">
                                Tìm kiếm
                            </button>

                            <a href="${pageContext.request.contextPath}/task"
                               class="btn btn-default">
                                Xóa tìm kiếm
                            </a>
                        </div>

                    </form>

                    <!-- Bảng danh sách công việc -->
                    <div class="table-responsive">
                        <table class="table table-striped"
                               id="example">

                            <thead>
                                <tr>
                                    <th>STT</th>
                                    <th>Tên công việc</th>
                                    <th>Dự án</th>
                                    <th>Người thực hiện</th>
                                    <th>Ngày bắt đầu</th>
                                    <th>Ngày kết thúc</th>
                                    <th>Trạng thái</th>
                                    <th>Hành động</th>
                                </tr>
                            </thead>

                            <tbody>
                                <c:forEach var="task"
                                           items="${taskList}"
                                           varStatus="loop">

                                    <tr>
                                        <!-- STT liên tục qua các trang -->
                                        <td>${startEntry + loop.index}</td>

                                        <td>
                                            <c:out value="${task.taskName}"/>
                                        </td>

                                        <td>
                                            <c:out value="${task.projectName}"/>
                                        </td>

                                        <td>
                                            <c:out value="${task.fullname}"/>
                                        </td>

                                        <td>
                                            <c:if test="${not empty task.startDate}">
                                                <fmt:formatDate
                                                    value="${task.startDate}"
                                                    pattern="dd/MM/yyyy"/>
                                            </c:if>
                                        </td>

                                        <td>
                                            <c:if test="${not empty task.endDate}">
                                                <fmt:formatDate
                                                    value="${task.endDate}"
                                                    pattern="dd/MM/yyyy"/>
                                            </c:if>
                                        </td>

                                        <td>
                                            <c:choose>
                                                <c:when test="${task.statusName == 'Chua Thuc Hien'}">
                                                    Chưa thực hiện
                                                </c:when>

                                                <c:when test="${task.statusName == 'Dang Thuc Hien'}">
                                                    Đang thực hiện
                                                </c:when>

                                                <c:when test="${task.statusName == 'Da Hoan Thanh'}">
                                                    Đã hoàn thành
                                                </c:when>

                                                <c:otherwise>
                                                    <c:out value="${task.statusName}"/>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>

                                        <td style="white-space: nowrap;">
                                            <!-- Nút Sửa -->
                                            <a class="btn btn-sm btn-primary"
                                               href="${pageContext.request.contextPath}/task-edit?id=${task.id}">
                                                Sửa
                                            </a>

                                            <!-- Nút Xóa -->
                                            <form action="${pageContext.request.contextPath}/task-delete"
                                                  method="post"
                                                  style="display: inline;"
                                                  onsubmit="return confirm('Bạn có chắc chắn muốn xóa công việc này?');">

                                                <input type="hidden"
                                                       name="id"
                                                       value="${task.id}">

                                                <button type="submit"
                                                        class="btn btn-sm btn-danger">
                                                    Xóa
                                                </button>
                                            </form>
                                        </td>
                                    </tr>

                                </c:forEach>

                                <c:if test="${empty taskList}">
                                    <tr>
                                        <td colspan="8" class="text-center">
                                            Không tìm thấy công việc nào.
                                        </td>
                                    </tr>
                                </c:if>
                            </tbody>

                        </table>
                    </div>

                    <!-- Thông tin số bản ghi và phân trang -->
                    <div class="row" style="margin-top: 15px;">

                        <div class="col-md-6 col-sm-6">
                            <p>
                                Showing ${startEntry} to ${endEntry}
                                of ${totalEntries} entries
                            </p>
                        </div>

                        <div class="col-md-6 col-sm-6 text-right">
                            <ul class="pagination" style="margin: 0;">

                                <!-- Previous -->
                                <c:choose>
                                    <c:when test="${page > 1}">
                                        <li>
                                            <c:url var="previousUrl"
                                                   value="/task">
                                                <c:param name="keyword"
                                                         value="${keyword}"/>
                                                <c:param name="pageSize"
                                                         value="${pageSize}"/>
                                                <c:param name="page"
                                                         value="${page - 1}"/>
                                            </c:url>

                                            <a href="${previousUrl}">
                                                Previous
                                            </a>
                                        </li>
                                    </c:when>

                                    <c:otherwise>
                                        <li class="disabled">
                                            <a href="#">Previous</a>
                                        </li>
                                    </c:otherwise>
                                </c:choose>

                                <!-- Số trang -->
                                <c:forEach var="p"
                                           begin="1"
                                           end="${totalPages}">

                                    <c:url var="numberUrl"
                                           value="/task">
                                        <c:param name="keyword"
                                                 value="${keyword}"/>
                                        <c:param name="pageSize"
                                                 value="${pageSize}"/>
                                        <c:param name="page"
                                                 value="${p}"/>
                                    </c:url>

                                    <li class="${p == page ? 'active' : ''}">
                                        <a href="${numberUrl}">
                                            ${p}
                                        </a>
                                    </li>

                                </c:forEach>

                                <!-- Next -->
                                <c:choose>
                                    <c:when test="${page < totalPages}">
                                        <li>
                                            <c:url var="nextUrl"
                                                   value="/task">
                                                <c:param name="keyword"
                                                         value="${keyword}"/>
                                                <c:param name="pageSize"
                                                         value="${pageSize}"/>
                                                <c:param name="page"
                                                         value="${page + 1}"/>
                                            </c:url>

                                            <a href="${nextUrl}">
                                                Next
                                            </a>
                                        </li>
                                    </c:when>

                                    <c:otherwise>
                                        <li class="disabled">
                                            <a href="#">Next</a>
                                        </li>
                                    </c:otherwise>
                                </c:choose>

                            </ul>
                        </div>

                    </div>
                    <!-- Kết thúc phân trang -->

                </div>
            </div>
        </div>

    </div>
</div>