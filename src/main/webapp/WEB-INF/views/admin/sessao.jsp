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
    <!-- 
	    <div class="navbar navbar-default navbar-fixed-top" role="navigation">
	      <div class="container">
	        <div class="navbar-header">
	          <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target=".navbar-collapse">
	            <span class="sr-only">Toggle navigation</span>
	            <span class="icon-bar"></span>
	            <span class="icon-bar"></span>
	            <span class="icon-bar"></span>
	          </button>
    	      <a class="navbar-brand" href="#">
    	        <img style="margin-top:-6px" src="<c:url value="/resources/images/unifeob_peq.jpg"/>"> QUIZ - Administra&ccedil;&atilde;o
    	      </a>
	        </div>
	        <div class="navbar-collapse collapse">
              <ul class="nav navbar-nav">
                <li><a href="<c:url value="/sessao/ativa"/>">Sess&atilde;o Ativa</a></li>
                <li><a href="<c:url value="/sessoes"/>">Sess&otilde;es</a></li>
              </ul>
            </div>
	      </div>
	    </div>
	 -->
	 
	    <div class="container">
	        <h1>Sess&atilde;o ${sessao.finalizada ? 'Finalizada' : 'Ativa' }</h1>
	        <p><strong>Id:</strong>  ${sessao.id}</p>
	        <p><strong>Inicia em</strong> <fmt:formatDate value="${sessao.inicio.getTime()}" pattern="dd/MM/yyyy HH:mm:ss"/></p>
	        
	        <c:if test="${not empty sessao.fim}">
		        <p><strong>Finalizada em</strong> <fmt:formatDate value="${sessao.fim.getTime()}" pattern="dd/MM/yyyy HH:mm:ss"/></p>
		    	
		    	<c:if test="${not empty sessao.ganhador}">    
		        	<p>Ganhador ${sessao.ganhador.nome} com ${sessao.ganhador.totalPontos} pontos</p>
		        </c:if>
	        </c:if>
	        <c:if test="${empty sessao.fim}">
	        	<c:url value="/sessao/finalizar/${sessao.id}" var="finalizarSessaoUrl"/>
		        <p><a href="${finalizarSessaoUrl}">Finalizar</a></p>
	        </c:if>
			        
	        <h3>Jogadores</h3>
	        <ul>
	        	<c:forEach var="jogador" items="${sessao.jogadores}">
	        		<li>${jogador.nome}</li>
	        	</c:forEach>
	        </ul>
	        <h3>Perguntas</h3>
	        <ul>
	        	<c:forEach var="pergunta" items="${sessao.perguntas}">
	        		<li>${pergunta.descricao}</li>
	        	</c:forEach>
	        </ul>
	     </div>
    </body>
</html>