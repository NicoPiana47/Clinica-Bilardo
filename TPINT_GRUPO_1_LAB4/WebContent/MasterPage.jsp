<!DOCTYPE html>
<%@ page import="entidades.Medico" %>
<html>
<head>
<meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/css/bootstrap.min.css" integrity="sha384-/Y6pD6FV/Vv2HJnA6t+vslU6fwYXjCFtcEpHbNJ0lyAFsXTsjBbfaDjzALeQsN6M" crossorigin="anonymous">	
   	<script src="https://kit.fontawesome.com/3c33daaf69.js" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="./src/Style/masterPage.css">
    
     <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.4/jquery.min.js"></script>
      <script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.10.19/js/jquery.dataTables.js"></script>
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.19/css/jquery.dataTables.css"> 
    
    <script src="notiflix-Notiflix-6936fff/dist/notiflix-notify-aio-3.2.6.min.js"></script>
    
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
	<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
   
    <title>master</title>
    
    <% 
	    Medico med = new Medico();
		if(session.getAttribute("sessionMedico") != null){
			med = (Medico)session.getAttribute("sessionMedico");
		} 
	%>
<body>


<nav class="navbar navbar-expand-lg navbar-light" style="background: #23313e; border: solid 0.5px #e4f6ff">
  <div class="container-fluid">
    <a class="navbar-brand">
      <img src="./src/assets/Clinica.svg" class="logo img-fluid " alt="logo" />
    </a>

    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
      aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation" style="background: white;">
      <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse justify-content-end" id="navbarNav">
      <ul class="navbar-nav ms-auto my-2 my-lg-0 navbar-nav-scroll" style="--bs-scroll-height: 100px;">
        <% if (med.getTipo()) { %>
        <li class="nav-item">
          <a class="nav-link text-white" href="servletPacientes">
            <i class="fa-solid fa-users"></i> Administrar Pacientes
          </a>
        </li>
        <li class="nav-item">
          <a class="nav-link text-white" href="servletMedicos">
            <i class="fa-solid fa-hospital"></i> Administrar Médicos
          </a>
        </li>
        <li class="nav-item">
          <a class="nav-link text-white" href="servletTurnos?asig=1">
            <i class="fa-solid fa-calendar"></i> Administrar Asignación de turnos
          </a>
        </li>
        <li class="nav-item">
          <a class="nav-link text-white" href="servletTurnos?rep=1">
            <i class="fa-brands fa-wpforms"></i> Reportes
          </a>
        </li>
        <li class="nav-item">
          <a class="nav-link text-white" href="MiCuenta.jsp">
            <i class="fa-solid fa-user"></i> <%=med.getNombre()%>
          </a>
        </li>
        <li class="nav-item">
          <a class="nav-link text-white" href="Login.jsp" onclick="return confirm('¿Salir?');">
            <i class="fa-solid fa-sign-out"></i> Salir
          </a>
        </li>
        <% } else { %>
        <li class="nav-item">
          <a class="nav-link text-white" href="servletTurnos?ini=1">
            <i class="fa-solid fa-users"></i> Turnos
          </a>
        </li>
        <li class="nav-item">
          <a class="nav-link text-white" href="MiCuenta.jsp">
            <i class="fa-solid fa-user"></i> <%=med.getNombre()%>
          </a>
        </li>
        <li class="nav-item">
          <a class="nav-link text-white" href="Login.jsp" onclick="return confirm('¿Salir?');">
            <i class="fa-solid fa-sign-out"></i> Salir
          </a>
        </li>
        <% } %>
      </ul>
    </div>
  </div>
</nav>
</body>
</html>