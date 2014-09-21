<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>QUIZ :: Universo Unifeob 2014</title>

    <link rel="stylesheet" href="<c:url value="/resources/bootstrap/css/bootstrap.min.css"/>">
    <link rel="stylesheet" href="<c:url value="/resources/bootstrap/css/bootstrap-theme.min.css"/>">
	
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
          <a class="navbar-brand" href="#">QUIZ Unifeob</a>
        </div>
        <div class="navbar-collapse collapse">
          <ul class="nav navbar-nav">
		    <li><a href="#">&nbsp;</a></li>
		    <li><a href="#">&nbsp;</a></li>
		    <li><a href="#">&nbsp;</a></li>
		    <li><a href="#">&nbsp;</a></li>
		    <li><a href="#">&nbsp;</a></li>
		    <li><a href="#">&nbsp;</a></li>
		    <li><a href="#">&nbsp;</a></li>
		    <li><a href="#"><strong>Jogador:</strong> ${jogador.nome}</a></li>
		    <li><a href="#">&nbsp;</a></li>
		    <li><a href="#"><strong>Pontos:</strong> 0</a></li>
          </ul>
          <ul class="nav navbar-nav navbar-right">
            <li class="dropdown">
              <a href="#" class="dropdown-toggle" data-toggle="dropdown">Sair <span class="caret"></span></a>
              <ul class="dropdown-menu" role="menu">
                <li><a href="<c:url value="/entrar"/>">Quero sair do jogo</a></li>
              </ul>
            </li>
          </ul>
        </div><!--/.nav-collapse -->
      </div>
    </div>

    <div class="container">
      <h1>Olá ${jogador.nome}, seja bem vindo!</h1>

      <h3>Aguarde o jogo ir&aacute; iniciar em instantes.</h3>
    </div>

    <script src="<c:url value="/resources/js/jquery.min.js"/>"></script>
    <script src="<c:url value="/resources/bootstrap/js/bootstrap.min.js"/>"></script>
  </body>
</html>