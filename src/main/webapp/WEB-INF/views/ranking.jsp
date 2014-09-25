<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>QUIZ :: Universo Unifeob 2014</title>

    <link rel="stylesheet" href="<c:url value="/resources/bootstrap/css/bootstrap.min.css"/>">
    <link rel="stylesheet" href="<c:url value="/resources/bootstrap/css/bootstrap-theme.min.css"/>">
	
	<style type="text/css">
		body {
		  padding-top: 70px;
		}
	</style>
  </head>
  <body>
    <div class="navbar navbar-default navbar-fixed-top" role="navigation">
      <div class="container">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target=".navbar-collapse">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand" href="#"><img style="margin-top:-6px" src="<c:url value="/resources/images/unifeob_peq.jpg"/>"> QUIZ</a>
        </div>
        <div class="navbar-collapse collapse">
          <ul class="nav navbar-nav">
          </ul>
          <ul class="nav navbar-nav navbar-right">
            <li><a href="<c:url value="/entrar"/>">Jogar</a></li>
          </ul>
        </div><!--/.nav-collapse -->
      </div>
    </div>

    <div class="container">
      <div class="col-md-3"></div>
      
      <div class="col-md-6">

      <div class="jumbotron">
        <h1 class="text-center">Ranking</h1>
      </div>
      

      <c:forEach var="posicao" items="${ranking}" varStatus="counter">
        
        <c:choose>
        <c:when test="${counter.index == 0}">
          <c:set var="style" value="alert alert-success"/>
        </c:when>
        <c:when test="${counter.index == 1}">
          <c:set var="style" value="alert alert-info"/>
        </c:when>
        <c:when test="${counter.index == 2}">
          <c:set var="style" value="alert alert-warning"/>
        </c:when>
        <c:otherwise>
          <c:set var="style" value="alert alert-danger"/>
        </c:otherwise>
        </c:choose>
        
        <div class="${style}" role="alert">
          ${counter.index + 1} &ordm;&nbsp;&nbsp; ${posicao.jogador.nome} <strong class="pull-right">${posicao.totalPontos} pontos</strong>
        </div>
      </c:forEach>
      </div>

      <div class="col-md-3"></div>
      
    </div>

    <script src="<c:url value="/resources/js/jquery.min.js"/>"></script>
    <script src="<c:url value="/resources/bootstrap/js/bootstrap.min.js"/>"></script>
    
    <script>
	$(document).ready(function() {
	  
	  setTimeout(function() {
        location.href = '<c:url value="/entrar"/>';
	  }, 60000);
	  
	});    
  </script>
  </body>
</html>