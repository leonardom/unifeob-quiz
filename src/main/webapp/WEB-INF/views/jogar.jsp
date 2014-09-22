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
		    <li><a href="#">&nbsp;</a></li>
		    <li><a href="#">&nbsp;</a></li>
		    <li><a href="#">&nbsp;</a></li>
		    <li><a href="#">&nbsp;</a></li>
		    <li><a href="#">&nbsp;</a></li>
		    <li><a href="#">&nbsp;</a></li>
		    <li><a href="#">&nbsp;</a></li>
		    <li><a href="#"><strong>Jogador:</strong> ${jogadorLogado.nome}</a></li>
		    <li><a href="#">&nbsp;</a></li>
		    <li><a href="#"><strong>Pontos:</strong> 0</a></li>
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
    
    <input type="hidden" id="session.id' value="${session.id}"/>
    <input type="hidden" id="jogador' value="${jogadorLogado.id}"/>

    <div class="container">
      <h2>Perguntas</h2>
	  
	  <ul id="perguntas" class="list-unstyled">
      <c:forEach var="pergunta" items="${sessao.perguntas}">
        <li>
          <div class="jumbotron">
          <form id="frm_${pergunta.id}">
          ${pergunta.descricao}
          <div id="opcoes_pergunta_${pergunta.id}">
		    <ul id="opcoes_${pergunta.id}" class="list-unstyled">
              <c:forEach items="${pergunta.opcoesResposta}" var="opcao">
                <li><input type="radio" name="pergunta_${pergunta.id}_opcao" value="${opcao.id}"/> ${opcao.descricao}</li>
              </c:forEach>
              <li><input type="button" value="Responser" class="btn btn-success envia" id="${pergunta.id}"/></li>
            </ul>
          </div>
          </form>
          <div id="debug_${pergunta.id}"></div>
	      </div>
        </li>
      </c:forEach>
      </ul>
    </div>

    <script src="<c:url value="/resources/js/jquery.min.js"/>"></script>
    <script src="<c:url value="/resources/bootstrap/js/bootstrap.min.js"/>"></script>
    <script type="text/javascript">
    $(document).ready(function() {
      $('.envia').click(function() {
          var perguntaId = $(this).attr('id');

          var opcao = $('#frm_' + perguntaId + ' input[type="radio"]:checked').val();

          $('#opcoes_pergunta_' + perguntaId).fadeOut("fast");
          
          $('#debug_' + perguntaId).html("Opcao selecionado:" + opcao);
          
          var url = '<c:url value="/responder"/>/' + perguntaId + "/" + opcao; 
          
          $.getJSON(url, function(data) {
        	 console.log(data); 
          });

      });
    });
    </script>
  </body>
</html>