<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>QUIZ :: Universo Unifeob 2014</title>

		<link rel="stylesheet" href="<c:url value="/resources/bootstrap/css/bootstrap.min.css"/>">
		<link rel="stylesheet" href="<c:url value="/resources/bootstrap/css/bootstrap-theme.min.css"/>">
	
		<script src="<c:url value="/resouces/jquery.min.js"/>"></script>
		<script src="<c:url value="/resouces/bootstrap/js/bootstrap.min.js"/>"></script>

    </head>
    <body style="padding-top: 70px">
	    <c:import url="_menu.jsp"/>
	
	    <div class="container">
        <h1>Jogadores</h1>
        
        <table class="table table-condensed table-striped table-bordered table-hover">
	        <thead>
	          <tr>
	            <th>Id</th>
	            <th>Nome</th>
	            <th>Email</th>
	          </tr>
	        </thead>
	        <tbody>
	          <c:forEach var="jogador" items="${jogadores}">
	          <tr>
	            <td>${jogador.id}</td>
	            <td>${jogador.nome}</td>
	            <td>${jogador.email}</td>
	          </tr>
	          </c:forEach>
	        </tbody>
	        </table>
	    </div>
    </body>
</html>