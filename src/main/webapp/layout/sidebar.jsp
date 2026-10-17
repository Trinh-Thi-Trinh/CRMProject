<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- Left navbar-header end -->
<div class="navbar-default sidebar" role="navigation">
	<div class="sidebar-nav navbar-collapse slimscrollsidebar">
		<ul class="nav" id="side-menu">
			<li style="padding: 10px 0 0;"><a
				href="${pageContext.request.contextPath}/profile"
				class="waves-effect"> <i class="fa fa-clock-o fa-fw"
					aria-hidden="true"></i> <span class="hide-menu">Dashboard</span>
			</a></li>
			<li><a href="${pageContext.request.contextPath}/user-table"
				class="waves-effect"><i class="fa fa-user fa-fw"
					aria-hidden="true"></i><span class="hide-menu">Thành viên</span></a></li>
			<li><a href="${pageContext.request.contextPath}/role-table"
				class="waves-effect"><i class="fa fa-modx fa-fw"
					aria-hidden="true"></i><span class="hide-menu">Quyền</span></a></li>
			<li><a href="${pageContext.request.contextPath}/groupwork"
				class="waves-effect"><i class="fa fa-table fa-fw"
					aria-hidden="true"></i><span class="hide-menu">Dự án</span></a></li>
			<li><a href="${pageContext.request.contextPath}/task"
				class="waves-effect"><i class="fa fa-table fa-fw"
					aria-hidden="true"></i><span class="hide-menu">Công việc</span></a></li>
			<li><a href="${pageContext.request.contextPath}/blank"
				class="waves-effect"><i class="fa fa-columns fa-fw"
					aria-hidden="true"></i><span class="hide-menu">Blank Page</span></a></li>
			<li><a href="${pageContext.request.contextPath}/404"
				class="waves-effect"><i class="fa fa-info-circle fa-fw"
					aria-hidden="true"></i><span class="hide-menu">Error 404</span></a></li>
		</ul>
	</div>
</div>