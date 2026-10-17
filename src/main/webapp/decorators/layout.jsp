<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="sitemesh"
    uri="http://www.opensymphony.com/sitemesh/decorator" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" type="image/png" sizes="16x16" href="../plugins/images/favicon.png">
    <title>Pixel Admin</title>
    <!-- Bootstrap Core CSS -->
    <link href="${pageContext.request.contextPath}/assets/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Menu CSS -->
    <link href="${pageContext.request.contextPath}/assets/plugins/bower_components/sidebar-nav/dist/sidebar-nav.min.css" rel="stylesheet">
    <!-- toast CSS -->
    <link href="${pageContext.request.contextPath}/assets/plugins/bower_components/toast-master/css/jquery.toast.css" rel="stylesheet">
    <!-- morris CSS -->
    <link href="${pageContext.request.contextPath}/assets/plugins/bower_components/morrisjs/morris.css" rel="stylesheet">
    <!-- animation CSS -->
    <link href="${pageContext.request.contextPath}/assets/css/animate.css" rel="stylesheet">
    <!-- Custom CSS -->
    <link href="${pageContext.request.contextPath}/assets/css/style.css" rel="stylesheet">
    <!-- color CSS -->
    <link href="${pageContext.request.contextPath}/assets/css/colors/blue-dark.css" id="theme" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/custom.css">
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
<![endif]-->

</head>

<body>
    <!-- Preloader -->
    <div class="preloader">
        <div class="cssload-speeding-wheel"></div>
    </div> 
    <div id="wrapper">
  <!--HEADER  -->
  <%@include file="../layout/header.jsp" %>
            <!-- /.navbar-top-links -->
            <!-- /.navbar-static-side -->
 <!-- SITEBAR -->
 <%@ include file="../layout/sidebar.jsp" %>
        <!-- Left navbar-header -->

        <!-- Left navbar-header end -->
 <!-- Page Content -->
        
        <sitemesh:body />
        
    <!-- Footer -->    
 <%@ include file="../layout/footer.jsp" %>
       
    </div>
    <!-- /#page-wrapper -->
    </div>
    <!-- /#wrapper -->
    <!-- jQuery -->
    <script src="${pageContext.request.contextPath}/assets/plugins/bower_components/jquery/dist/jquery.min.js"></script>
    <!-- Bootstrap Core JavaScript -->
    <script src="${pageContext.request.contextPath}/assets/bootstrap/dist/js/bootstrap.min.js"></script>
    <!-- Menu Plugin JavaScript -->
    <script src="${pageContext.request.contextPath}/assets/plugins/bower_components/sidebar-nav/dist/sidebar-nav.min.js"></script>
    <!--slimscroll JavaScript -->
    <script src="${pageContext.request.contextPath}/assets/js/jquery.slimscroll.js"></script>
    <!--Wave Effects -->
    <script src="${pageContext.request.contextPath}/assets/js/waves.js"></script>
    <!--Counter js -->
    <script src="${pageContext.request.contextPath}/assets/plugins/bower_components/waypoints/lib/jquery.waypoints.js"></script>
    <script src="${pageContext.request.contextPath}/assets/plugins/bower_components/counterup/jquery.counterup.min.js"></script>
    <!--Morris JavaScript -->
    <script src="${pageContext.request.contextPath}/assets/plugins/bower_components/raphael/raphael-min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/plugins/bower_components/morrisjs/morris.js"></script>
    <!-- Custom Theme JavaScript -->
    <script src="${pageContext.request.contextPath}/assets/js/custom.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/dashboard1.js"></script>
    <script src="${pageContext.request.contextPath}/assets/plugins/bower_components/toast-master/js/jquery.toast.js"></script>
</body>

</html>