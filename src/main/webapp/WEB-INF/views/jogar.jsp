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
		    <li><a href="#"><strong>Jogador:</strong> ${jogadorLogado.nome}</a></li>
		    <li><a href="#">&nbsp;</a></li>
		    <li><a href="#"><strong>Pontos:</strong> <span id="pontos">${pontuacao.totalPontos}</span></a></li>
		    <li><a href="#">&nbsp;</a></li>
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
      <h2>Perguntas</h2>
	  
	  <ul id="perguntas" class="list-unstyled">
      <c:forEach var="pergunta" items="${sessao.perguntas}">
        <c:set var="resposta" value="${sessao.getResposta(pergunta)}"/>
            
        <li>
          <div class="jumbotron">
          <form id="frm_${pergunta.id}">
          <strong>${pergunta.descricao}</strong>
          <c:if test="${resposta == null || (!resposta.correta && resposta.jogador.id != jogadorLogado.id)}">
          <div id="opcoes_pergunta_${pergunta.id}">
		    <ul id="opcoes_${pergunta.id}" class="list-unstyled">
              <c:forEach items="${pergunta.opcoesResposta}" var="opcao">
                <li><input type="radio" name="pergunta_${pergunta.id}_opcao" value="${opcao.id}"/> ${opcao.descricao}</li>
              </c:forEach>
              <li><input type="button" value="Responser" class="btn btn-success envia" id="${pergunta.id}"/></li>
            </ul>
          </div>
          </c:if>
          </form>
          
          <div id="feedback_${pergunta.id}">
          	<c:choose>
            <c:when test="${resposta != null && resposta.correta && resposta.jogador.id != jogadorLogado.id}">
              <span style="color:orange">
                Respondida pelo oponente
              </span>
            </c:when> 
            <c:when test="${resposta != null && resposta.jogador.id == jogadorLogado.id && resposta.correta}">
              <span style="color:blue">
                Parab&eacute;ns, você acertou! Resposta: ${resposta.opcao.descricao}
              </span>
            </c:when> 
            <c:when test="${resposta != null && resposta.jogador.id == jogadorLogado.id && !resposta.correta}">
              <span style="color:red">
                Que pena, você errou!
              </span>
            </c:when> 
          	</c:choose>
          </div>
	      </div>
        </li>
      </c:forEach>
      </ul>
    </div>

    <script src="<c:url value="/resources/js/jquery.min.js"/>"></script>
    <script src="<c:url value="/resources/bootstrap/js/bootstrap.min.js"/>"></script>
    <script src="<c:url value="/resources/js/sockjs-0.3.min.js"/>"></script>
    <script src="<c:url value="/resources/js/stomp.js"/>"></script>

    <script type="text/javascript">

    //Create stomp client over sockJS protocol
    //var socket = new SockJS("/unifeob-quiz/ws");
    var socket = new SockJS("<c:url value='/ws'/>");
    var stompClient = Stomp.over(socket);
    
    // Callback 
    var checkNotification = function(frame) {
      //por alguma razao que ainda nao sei explicar tive que chamar o parse duas vezes\
      //para ter um objeto Javascript
  	  var msg = JSON.parse(JSON.parse(frame.body));
  	  if (msg.status == "perguntaRespondida") {
  		var perguntaId = msg.pergunta;
  		var jogadorId = msg.jogador;
  		
  		if (jogadorId != ${jogadorLogado.id}) {
  		  $('#feedback_' + perguntaId).html("<span style='color:orange'>Respondida pelo oponente</span>");
  	    
  		  $('#opcoes_pergunta_' + perguntaId).fadeOut(200, function() {
            $('#feedback_' + perguntaId).fadeIn(200);
  	      });
  		}
  	  }
  	  else if (msg.status == "finalizado") {
  		location.href = '<c:url value="/placar"/>/' + ${sessao.id};    
  	  }
    };

    // Callback function a ser chamada quando o cliente stomp conecta com o servidor
    var connectCallback = function() {
      stompClient.subscribe('/topic/game', checkNotification);
    }; 

    // Callback function a ser chamda quando o cliente stomp nao conecta com o servidor
    var errorCallback = function(error) {
      alert("Nao foi possivel conectar!\nErro: " + error);
    };

    // Connect ao servidor via websocket
    stompClient.connect("guest", "guest", connectCallback, errorCallback);

    $(document).ready(function() {
      $('.envia').click(function() {
          var perguntaId = $(this).attr('id');

          var opcao = $('#frm_' + perguntaId + ' input[type="radio"]:checked').val();

          var url = '<c:url value="/responder"/>/' + perguntaId + "/" + opcao; 
          
          $.getJSON(url, function(data) {
        	  if (data.status == "correta") {
        		  var pontos = Number($('#pontos').html());
        		  pontos += data.pontos;
        		  $('#pontos').html(pontos);
                  
        		  $('#feedback_' + perguntaId).html("<span style='color:blue'>Parabéns, você acertou! Resposta: " + data.opcao + "</span>");
        	  } else if (data.status == "incorreta") {
        		  $('#feedback_' + perguntaId).html("<span style='color:red'>Que pena, você errou!</span>");
        	  } else if (data.status == "respondida") {
        		  $('#feedback_' + perguntaId).html("<span style='color:orange'>Já respondida</span>");
        	  } else if (data.status == "respondidaPeloOponente") {
        		  $('#feedback_' + perguntaId).html("<span style='color:orange'>Já respondida pelo oponente</span>");
        	  }
        	  
        	  $('#opcoes_pergunta_' + perguntaId).fadeOut(200, function() {
                $('#feedback_' + perguntaId).fadeIn(200);
        	  });
              
          });

      });
    });
    </script>
  </body>
</html>