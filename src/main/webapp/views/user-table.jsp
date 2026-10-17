<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<body>
    <!-- Preloader -->
    
    <div id="wrapper">
        
        <!-- Left navbar-header end -->
        <!-- Page Content -->
        <div id="page-wrapper">
            <div class="container-fluid">
                <div class="row bg-title">
                    <div class="col-lg-3 col-md-4 col-sm-4 col-xs-12">
                        <h4 class="page-title">Danh sách thành viên</h4>
                    </div>
                    <div class="col-lg-9 col-sm-8 col-md-8 col-xs-12 text-right">
                        <a href="${pageContext.request.contextPath}/user-add" class="btn btn-sm btn-success">Thêm mới</a>
                    </div>
                    <!-- /.col-lg-12 -->
                </div>
                 <!-- KET QUA CUA THAO TAC DELETE -->
		  <c:if test="${param.delete =='1'}">
		  	<div class="alert alert-success">Xoa thanh vien thanh cong!</div>
		  </c:if> 
		  <c:if test="${param.err =='1'}">
		  	<div class="alert alert-danger">Xoa thanh vien that bai!</div>
		  </c:if>
                <!-- /row -->
                <div class="row">
                    <div class="col-sm-12">
                        <div class="white-box">
                        
                        <form action="user-table" method="GET" class="form-inline"
						style="margin-bottom: 16px;">
						<input type="text" name="keywords"
							value="<c:out value='${param.keywords}' />" class="form-control"
							placeholder="Tìm tên hoặc email">

						<button type="submit" class="btn btn-primary">Tìm kiếm</button>

					</form>
                            <div class="table-responsive">
                                <table class="table" id="example">
                                    <thead>
                                        <tr>
                                            <th>STT</th>
                                            <th>Full Name</th>
                                            <th>Phone</th>
                                            <th>Email</th>
                                            <th>Role</th>
                                            <th>#</th>
                                        </tr>
                                    </thead>
                                    <c:forEach items="${users}"  var="user"><tr>
                                            <td>${user.id }</td>
                                            <td>${user.fullname }</td>
                                            <td>${user.phone }</td>
                                            <td>${user.email }</td>
                                            <td>${user.roleName}</td>
                                            <td>
                                                <a href="${pageContext.request.contextPath}/user-edit?id=${user.id}" class="btn btn-sm btn-primary">Sửa</a>
                                                <form style="display: inline;" action="user-delete" method="post" 
											onsubmit="return confirm('Bạn chắc chắn muốn xóa thành viên này?')">
												<input type="hidden" name="id" value="${user.id}">
												<button type="submit" class="btn btn-sm btn-danger">Xóa</button> 
											</form>
                                               <a href="${pageContext.request.contextPath}/user-details?id=${user.id}"
   									class="btn btn-sm btn-info"> Xem </a>
                                            </td>
                                        </tr>
                                        </c:forEach>
                                    <tbody>
                                        
                                        
                                    </tbody>
                                </table>
                                <!-- pagination -->
						<div class="text-center">
							<c:if test="${page > 1}">
								<c:url var="previousUrl" value="/user-table">
									<c:param name="page" value="${page -1}"></c:param>
									<c:param name="keywords" value="${param.keywords}"></c:param>
								</c:url>
								<a class="btn btn-default" href="${previousUrl}"> Trước </a>
							</c:if>
							<c:forEach begin="1" end="${totalPage}" var="pageNumber">
								<a href="user-table?page=${pageNumber}&keywords=${param.keywords}"
									class="btn ${pageNumber == page ? 'btn-primary': 'btn-default'} ">
									${pageNumber} </a>
							</c:forEach>
							<c:if test="${page < totalPage}">
								<c:url var="nextUrl" value="/user-table">
									<c:param name="page" value="${page + 1}"></c:param>
									<c:param name="keywords" value="${param.keywords}"></c:param>
								</c:url>
								<a class="btn btn-default" href="${nextUrl}"> Sau </a>
							</c:if>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- /.row -->
            </div>
           
        </div>
        <!-- /#page-wrapper -->
    </div>
    
</body>
    