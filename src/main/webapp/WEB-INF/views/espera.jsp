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
            <li class="dropdown">
              <a href="#" class="dropdown-toggle" data-toggle="dropdown">Sair <span class="caret"></span></a>
              <ul class="dropdown-menu" role="menu">
                <li><a href="<c:url value="/sair"/>">Quero sair do jogo</a></li>
              </ul>
            </li>
          </ul>
        </div><!--/.nav-collapse -->
      </div>
    </div>

    <div class="container">
      <div class="jumbotron">
        <h1>Bem vindo, ${jogadorLogado.nome}</h1>
        <p>Por favor aguarde, o jogo ir&aacute; iniciar em instantes.</p>
      </div>
    </div>

    <script src="<c:url value="/resources/js/jquery.min.js"/>"></script>
    <script src="<c:url value="/resources/bootstrap/js/bootstrap.min.js"/>"></script>
    <script src="<c:url value="/resources/js/sockjs-0.3.min.js"/>"></script>
    <script src="<c:url value="/resources/js/stomp.js"/>"></script>
    
    <script>
      //Create stomp client over sockJS protocol
      var socket = new SockJS("/unifeob-quiz/ws");
      var stompClient = Stomp.over(socket);
      
      // Callback 
      var checkSession = function(frame) {
    	  var msg = JSON.parse(frame.body);
    	  if (msg == "iniciada") {
    	    location.href = '<c:url value="/jogar"/>';
    	  }
      };

      // Callback function a ser chamada quando o cliente stomp conecta com o servidor
      var connectCallback = function() {
        stompClient.subscribe('/topic/sessao', checkSession);
      }; 

      // Callback function a ser chamda quando o cliente stomp nao conecta com o servidor
      var errorCallback = function(error) {
        alert("Nao foi possivel conectar!\nErro: " + error.headers.message);
      };

      // Connect ao servidor via websocket
      stompClient.connect("guest", "guest", connectCallback, errorCallback);
  </script>
  </body>
</html>
