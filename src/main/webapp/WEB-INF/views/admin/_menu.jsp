<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
           <li><a href="<c:url value="/admin/sessao/ativa"/>">Sess&atilde;o Ativa</a></li>
           <li><a href="<c:url value="/admin/sessoes"/>">Sess&otilde;es</a></li>
           <li><a href="<c:url value="/admin/jogadores"/>">Jogadores</a></li>
         </ul>
       </div>
  </div>
</div>
