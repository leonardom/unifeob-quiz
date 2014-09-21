<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>QUIZ :: Universo Unifeob 2014</title>
	<link rel="stylesheet" href="<c:url value="/resources/bootstrap/css/bootstrap.css"/>">
	<link rel="stylesheet" href="<c:url value="/resources/bootstrap/css/bootstrap-theme.css"/>">
	<link rel="stylesheet" href="<c:url value="/resources/css/application.css"/>">
</head>
<body>
  <div class="wrapper">
	<form action="<c:url value="/entrar"/>" method="post" class="form-signin">
	  <input type="hidden" name="id" id="id">
	  
	  <h1 class="form-signin-heading">QUIZ UNIFEOB</h1>

	  <p>Para entrar no jogo, digite a informa&ccedil;&otilde;es abaixo:</p>
	    
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