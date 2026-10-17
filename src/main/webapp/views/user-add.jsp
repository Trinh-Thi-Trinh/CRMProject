<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 <div id="wrapper">
        
        <!-- Left navbar-header end -->
        <!-- Page Content -->
        <div id="page-wrapper">
            <div class="container-fluid">
                <div class="row bg-title">
                    <div class="col-lg-3 col-md-4 col-sm-4 col-xs-12">
                        <h4 class="page-title">
					<c:choose>
						<c:when test="${isEdit}">Sua thanh vien</c:when>
						<c:otherwise>Them moi thanh vien</c:otherwise>
					</c:choose>
				</h4>
                    </div>
                </div>
                <!-- /.row -->
                <!-- .row -->
                <div class="row">
                    <div class="col-md-2 col-12"></div>
                    <div class="col-md-8 col-xs-12">
                        <div class="white-box">
                        <c:if test="${param.created == '1' }">
                        <div class= "alert alert-success " > Them Thanh Vien Thanh Cong</div>
                        </c:if>
                         <c:if test="${not empty error }">
                        <div class= "alert alert-danger " > ${error}</div>
                        </c:if>
					<c:choose>
						<c:when test="${isEdit}">
							<c:url var="actionForm" value="user-edit"></c:url>
						</c:when>
						<c:otherwise>
							<c:url var="actionForm" value="user-add"></c:url>
						</c:otherwise>
					</c:choose>
                            <form class="form-horizontal form-material" action = "${actionForm}" method= "post">
                                <c:if test="${isEdit}">
							<input name="id" type="hidden" value="${userEdit.id }">
						</c:if>
          
                                <div class="form-group">
                                    <label class="col-md-12">Full Name</label>
                                    <div class="col-md-12">
                                        <input type="text" name = "fullname" placeholder="Johnathan Doe"
                                            class="form-control form-control-line" 
                                            value="${isEdit ? userEdit.fullname : param.fullname}">
                                             </div>
                                </div>
                                <div class="form-group">
                                    <label for="example-email" class="col-md-12">Email</label>
                                    <div class="col-md-12">
                                        <input type="email" name= "email" placeholder="johnathan@admin.com"
                                            class="form-control form-control-line" 
                                            value="${isEdit ? userEdit.email : param.email}" 
                                            id="example-email"> 
                                            </div>
                                </div>
                                <c:if test="${not isEdit}">
							<div class="form-group">
								<label class="col-md-12">Password</label>
								<div class="col-md-12">
									<input type="password" name="password"
										class="form-control form-control-line">
								</div>
							</div>
						</c:if>
                                <div class="form-group">
                                    <label class="col-md-12">Phone No</label>
                                    <div class="col-md-12">
                                        <input type="text" name ="phone" placeholder="123 456 7890"
                                            class="form-control form-control-line"  
                                            value="${isEdit ? userEdit.phone : param.phone}"> </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-12">Select Country</label>
                                    <div class="col-sm-12">
                                        <select class="form-control form-control-line" name = "country"  >
                                            <option  
                                            <c:if test="${(isEdit ? userEdit.country : param.country) == 'London'}">selected</c:if>
                                            value = "London">London</option>
                                            <option 
                                            <c:if test="${(isEdit ? userEdit.country : param.country) == 'India'}">selected</c:if>
                                            value = "India">India</option>
                                            <option 
                                            <c:if test="${(isEdit ? userEdit.country : param.country) == 'Usa'}">selected</c:if> 
                                            value = "Usa">Usa</option>
                                            <option 
                                            <c:if test="${(isEdit ? userEdit.country : param.country)== 'Canada'}">selected</c:if>
                                            value = "Canada">Canada</option>
                                            <option 
                                            <c:if test="${(isEdit ? userEdit.country : param.country)== 'Thailand'}">selected</c:if>
                                            value = "Thailand">Thailand</option>
                                        </select>
                                    </div>
                                </div>
                                 <div class="form-group">
                                    <label class="col-md-12">Role </label>
                                    <div class="col-md-12">
                                    <select name = "roleId">
                                    <c:forEach items= "${roles}" var = "role">
                                    <option 
                                    <c:if test="${(isEdit ? userEdit.roleId : param.roleId) == role.id }">selected
                                    </c:if>
                                     value = "${role.id}">${role.nameRole}</option>
                                    </c:forEach>
                                    </select>
                                  </div>      
                                </div>
                                <div class="form-group">
                                    <div class="col-sm-12">
                                        <button type="submit" class="btn btn-success"><c:choose>
										<c:when test="${isEdit}">Cap nhat</c:when>
										<c:otherwise>Them moi</c:otherwise>
										</c:choose>
										</button>
                                        <a href="${pageContext.request.contextPath}/user-table" class="btn btn-primary">Quay lại</a>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                    <div class="col-md-2 col-12"></div>
                </div>
                <!-- /.row -->
            </div>
           
        </div>
        <!-- /#page-wrapper -->
    </div>