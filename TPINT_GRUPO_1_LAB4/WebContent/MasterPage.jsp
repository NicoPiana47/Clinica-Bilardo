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
	    <img src="./src/assets/Clinica.svg" class="logo img-fluid " alt="logo"  />
	</a>
	
	<nav class="navbar navbar-expand-lg" style="font-weight: bold; font-size: 18px;">
	
  	<div class="collapse navbar-collapse" id="navbarScroll">
  	
 	<ul class="navbar-nav me-auto my-2 my-lg-0 navbar-nav-scroll" style="--bs-scroll-height: 100px;"></ul>
    <%if ( med.getTipo() ){%>
	    <form class="d-flex">
	        <ul class="navbar-nav me-auto my-2 my-lg-0 navbar-nav-scroll" style="--bs-scroll-height: 100px;">
	            <li class="nav-item">
	              <a class="nav-link text-white" href="servletPacientes">
	              	<i class="fa-solid fa-users"></i> Administrar Pacientes
          			</a>
	            </li>
	            <li class="nav-item">
	              <a class="nav-link text-white" href="">
	              	<i class="fa-solid fa-hospital"></i> Administrar Médicos
	              </a>
	            </li>
	            <li class="nav-item">
	              <a class="nav-link text-white" href="">
	              	<i class="fa-solid fa-calendar"></i> Administrar Asignación de turnos
              		</a>
	            </li>
	            <li class="nav-item">
	              <a class="nav-link text-white" href="servletTurnos">
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
	          </ul>	          
	    </form>
    <% } else { %>
    	<form class="d-flex">
	        <ul class="navbar-nav me-auto my-2 my-lg-0 navbar-nav-scroll" style="--bs-scroll-height: 100px;">
	            <li class="nav-item">
	              <a class="nav-link text-white" href="">
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
	          </ul>
	    </form>
     <% } %>
  </div>
</div>
</nav>


</body>
</html>