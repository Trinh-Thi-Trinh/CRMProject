<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
					<div class="user-bg">
						<img width="100%" alt="user" src="plugins/images/large/img1.jpg">
						<div class="overlay-box">
							<div class="user-content">
								<a href="javascript:void(0)"><img
									src="plugins/images/users/genu.jpg" class="thumb-lg img-circle"
									alt="img"></a>
								<h4 class="text-white">
									<c:out value="${user.fullname}" />
								</h4>
								<h5 class="text-white">
									<c:out value="${user.email}" />
								</h5>
							</div>
						</div>
					</div>

				</div>
			</div>
			<div class="col-md-8 col-xs-12">
				<!-- BEGIN THỐNG KÊ -->
				<div class="row">
					<!--col -->
					<div class="col-lg-4 col-md-4 col-sm-12 col-xs-12">
						<div class="white-box">
							<div class="col-in row">
								<div class="col-xs-12">
									<h3 class="counter text-right m-t-15 text-danger">20%</h3>
								</div>
								<div class="col-xs-12">
									<i data-icon="E" class="linea-icon linea-basic"></i>
									<h5 class="text-muted vb text-center">CHƯA BẮT ĐẦU</h5>
								</div>
								<div class="col-md-12 col-sm-12 col-xs-12">
									<div class="progress">
										<div class="progress-bar progress-bar-danger"
											role="progressbar" aria-valuenow="40" aria-valuemin="0"
											aria-valuemax="100" style="width: 20%"></div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<!-- /.col -->
					<!--col -->
					<div class="col-lg-4 col-md-4 col-sm-12 col-xs-12">
						<div class="white-box">
							<div class="col-in row">
								<div class="col-xs-12">
									<h3 class="counter text-right m-t-15 text-megna">50%</h3>
								</div>
								<div class="col-xs-12">
									<i class="linea-icon linea-basic" data-icon="&#xe01b;"></i>
									<h5 class="text-muted vb text-center">ĐANG THỰC HIỆN</h5>
								</div>
								<div class="col-md-12 col-sm-12 col-xs-12">
									<div class="progress">
										<div class="progress-bar progress-bar-megna"
											role="progressbar" aria-valuenow="40" aria-valuemin="0"
											aria-valuemax="100" style="width: 50%"></div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<!-- /.col -->
					<!--col -->
					<div class="col-lg-4 col-md-4 col-sm-12 col-xs-12">
						<div class="white-box">
							<div class="col-in row">
								<div class="col-xs-12">
									<h3 class="counter text-right m-t-15 text-primary">30%</h3>
								</div>
								<div class="col-xs-12">
									<i class="linea-icon linea-basic" data-icon="&#xe00b;"></i>
									<h5 class="text-muted vb text-center">HOÀN THÀNH</h5>
								</div>
								<div class="col-md-12 col-sm-12 col-xs-12">
									<div class="progress">
										<div class="progress-bar progress-bar-primary"
											role="progressbar" aria-valuenow="40" aria-valuemin="0"
											aria-valuemax="100" style="width: 30%"></div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<!-- /.col -->
				</div>
				<!-- END THỐNG KÊ -->

			</div>
		</div>
		<br />
		<!-- /.row -->
		<!-- BEGIN DANH SÁCH CÔNG VIỆC -->
		<h4>DANH SÁCH CÔNG VIỆC</h4>

		<p>
			Tổng số công việc: <strong>${totalTasks}</strong>
		</p>

		<div class="white-box">
			<div class="table-responsive">
				<table class="table table-striped">
					<thead>
						<tr>
							<th>STT</th>
							<th>Tên công việc</th>
							<th>Dự án</th>
							<th>Ngày bắt đầu</th>
							<th>Ngày kết thúc</th>
							<th>Trạng thái</th>
							<th>Hành động</th>
						</tr>
					</thead>

					<tbody>
						<c:forEach var="task" items="${tasks}" varStatus="st">
							<tr>
								<td>${st.count}</td>
								<td><c:out value="${task.taskName}" /></td>
								<td><c:out value="${task.projectName}" /></td>

								<td><c:choose>
										<c:when test="${not empty task.startDate}">
											<fmt:formatDate value="${task.startDate}"
												pattern="dd/MM/yyyy" />
										</c:when>
										<c:otherwise>Chưa có</c:otherwise>
									</c:choose></td>

								<td><c:choose>
										<c:when test="${not empty task.endDate}">
											<fmt:formatDate value="${task.endDate}" pattern="dd/MM/yyyy" />
										</c:when>
										<c:otherwise>Chưa có</c:otherwise>
									</c:choose></td>

								<td><c:out value="${task.statusName}" /></td>

								<td><div class="text-center">
										<a class="btn btn-info btn-sm"
											href="${pageContext.request.contextPath}/profile-edit">
											Cập nhật thông tin cá nhân </a>
									</div>
									</td>
							</tr>
						</c:forEach>

						<c:if test="${empty tasks}">
							<tr>
								<td colspan="7" class="text-center">Bạn chưa có công việc
									nào.</td>
							</tr>
						</c:if>
					</tbody>
				</table>
			</div>
		</div>
		<!-- END DANH SÁCH CÔNG VIỆC -->
	</div>
	<!-- /.container-fluid -->