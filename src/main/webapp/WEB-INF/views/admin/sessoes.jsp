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
        <h1>Sess&otilde;es</h1>
        
        <h3>Nova Sess&atilde;o</h1>
        <form action="<c:url value="/admin/sessoes/nova"/>" method="POST">
        	<label>Quantidade de perguntas:</label>
        	<input type="text" name="quatidadePerguntas" value="10" size="3"/>
        	<input type="submit" value="Criar"/>
        </form>
		<br/>        
        <table class="table table-condensed table-striped table-bordered table-hover">
	        <thead>
	          <tr>
	            <th>Id</th>
	            <th>Inicio</th>
	            <th>Fim</th>
	            <th>Status</th>
	            <th>Jogadores</th>
	            <th>&nbsp;</th>
	          </tr>
	        </thead>
	        <tbody>
	          <c:forEach var="sessao" items="${sessoes}">
	          <tr>
	            <td>${sessao.id}</td>
	            <td><fmt:formatDate value="${sessao.inicio.getTime()}" pattern="dd/MM/yyyy HH:mm:ss"/></td>
	            <td><fmt:formatDate value="${sessao.fim.getTime()}" pattern="dd/MM/yyyy HH:mm:ss"/></td>
	            <td>${sessao.finalizada ? 'Finalizada' : 'Ativa' }</td>
	            <td>${sessao.jogadores.size()}</td>
	            <td class="text-center"><a href="<c:url value="/admin/sessao/${sessao.id}"	/>"><span class="glyphicon glyphicon-eye-open"></span></a></td>
	          </tr>
	          </c:forEach>
	        </tbody>
	        </table>
	    </div>
    </body>
</html>