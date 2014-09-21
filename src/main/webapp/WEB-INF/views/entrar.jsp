<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>QUIZ :: Universo Unifeob 2014</title>

    <link rel="stylesheet" href="<c:url value="/resources/bootstrap/css/bootstrap.min.css"/>">
    <link rel="stylesheet" href="<c:url value="/resources/bootstrap/css/bootstrap-theme.min.css"/>">
    <link rel="stylesheet" href="<c:url value="/resources/css/application.css"/>">
	
  </head>
  <body style="padding-top: 70px">
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
          	<li><a href="<c:url value="/ranking"/>">Ranking</a></li>
          </ul>
        </div><!--/.nav-collapse -->
      </div>
    </div>
  <div class="wrapper">
	<form action="<c:url value="/entrar"/>" method="post" class="form-signin">
	  <input type="hidden" name="id" id="id">
	  
	  <!-- <h1 class="form-signin-heading">QUIZ UNIFEOB</h1> -->
	  <img src="<c:url value="/resources/images/unifeob.jpg"/>">
	  
	  <br/>
	  
	  <p style="margin-top: 10px">Para entrar no jogo, digite a informa&ccedil;&otilde;es abaixo:</p>
	    
      <input type="text" class="form-control typeahead" id="nome" name="nome" placeholder="Nome" autofocus="autofocus" value="${jogador.nome}" >
      <form:errors path="jogador.nome" cssStyle="color:red"/>
      
      <input type="email" class="form-control" id="email" name="email" placeholder="E-mail"  value="${jogador.email}">

      <button type="submit" class="btn btn-lg btn-primary btn-block">Entrar</button>
    </form>
  </div>
  
  <script src="<c:url value="/resources/js/jquery.min.js"/>"></script>
  <script src="<c:url value="/resources/bootstrap/js/bootstrap.min.js"/>"></script>
  <script src="<c:url value="/resources/js/typeahead.bundle.min.js"/>"></script>
  
  <script type="text/javascript">
  $(document).ready(function() {
	  $('input.typeahead').typeahead(null, {
		displayKey: 'nome',
        source: function (query, process){
          return $.getJSON('<c:url value="/jogadores"/>', {nome: query}, function(data) {
        	 process(data); 
          }); 
        },
        updater: function(item) {
          $('#id').val(item.id);
          return item;
        }
	  });
	  
	  $(document).on('typeahead:opened', function(event, datum) {
	    var width = $(event.target).width();
	    $('.tt-dropdown-menu').width(width);
	  });
	  
	  $('input.typeahead').on('typeahead:selected', function(evt, item) {
	    $('#id').val(item.id);
	    $('#email').val(item.email);
	  });
  });
  </script>
</body>
</html>                                		