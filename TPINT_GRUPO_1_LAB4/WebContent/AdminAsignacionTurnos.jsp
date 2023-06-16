<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>AdminAsignacionTurnos</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-0evHe/X+R7YkIZDRvuzKMRqM+OrBnVFBL6DOitfPri4tjfHxaWutUpFmBp4vmVor" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-pprn3073KE6tl6bjs2QrFaJGz5/SUsLqktiwsUTF55Jfv3qYSDhgCecCxMW52nD2" crossorigin="anonymous"></script>
<link rel="stylesheet" type="text/css"
	href="https://cdn.datatables.net/1.10.19/css/jquery.dataTables.css">
<script type="text/javascript" charset="utf8"
	src="https://cdn.datatables.net/1.10.19/js/jquery.dataTables.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="entidades.Paciente" %>
<%@ page import="entidades.Especialidad" %>
<%@ page import="entidades.Medico" %>
</head>

<body>
	<%@ include file="/MasterPage.jsp" %>
	<h1 class="text-center">Asignación de Turnos</h1> 
	<form class="w-50 m-auto">
		
		<div class="row text-center m-4" >		
			<label>Especialidad:</label> <br>
			<select class="form-control" name="ddlEspecialidades" id="ddlEspecialidades" onchange="filtrarMedicos()"> 
			<% 
	        if (request.getAttribute("listaEspecialidades") instanceof List) {
	            List<Especialidad> listaEspecialidades = (List<Especialidad>) request.getAttribute("listaEspecialidades");
	            for (Especialidad especialidad : listaEspecialidades) { 
	        %>
	            <option value="<%= especialidad.getCodEspecialidad() %>"><%= especialidad.getDescripcion() %></option>				
	        <% 
	            } 
	        }
	        %>
			</select>
		</div>
		
		<div class="row text-center m-4" >	
			<label>Médico:</label> <br>
			<select class="form-control" name="ddlMedicos" id="ddlMedicos" required> 
			<% 
	        if (request.getAttribute("listaMedicos") instanceof List) {
	            List<Medico> listaMedicos = (List<Medico>) request.getAttribute("listaMedicos");
	            for (Medico medico : listaMedicos) { 
	            	%>
	            	    <option value="<%= medico.getCodMed() %>"
	            	            data-especialidad-id="<%= medico.getEspecialidad().getCodEspecialidad() %>"
	            	            data-horarios-json='<%= medico.getHorariosJson() %>'>
	            	      	<%= medico.getNombre() + " " + medico.getApellido() %>
	            	    </option>
            	    <% 
	            } 
	        }
	        %>
			</select>
		</div>
		
		<div class="row text-center m-4">
            <label>Fecha:</label><br>
            <input class="form-control" type="text" name="fecha" id="fecha" required>
        </div>
        <div class="row text-center m-4">
            <label>Horarios disponibles:</label><br>
            <select class="form-control" name="ddlHorariosDisponibles" id="ddlHorariosDisponibles" required></select>
        </div>
		
		<div class="row text-center m-4">
			<label>Pacientes:</label> <br>
			<select class="form-control" name="ddlPacientes"> 
			<% 
	        if (request.getAttribute("listaPacientes") instanceof List) {
	            List<Paciente> listaPacientes = (List<Paciente>) request.getAttribute("listaPacientes");
	            for (Paciente paciente : listaPacientes) { 
	        %>
	            <option value="<%= paciente.getCodPac() %>"><%= paciente.getNombre() + " " + paciente.getApellido() %></option>				
	        <% 
	            } 
	        }
	        %>
			</select>
		</div>
		
		<button class="form-control" type="submit" name="btnAsignar">Asignar turno</button>
	</form>
</body>

<script>
	var ddlMedicos = document.getElementById('ddlMedicos')
 	var fpFechas = flatpickr("#fecha", {
		minDate: "today",
		maxDate: new Date().setMonth(new Date().getMonth() + 4),
	  	 disable: [
	   		function(date) {
	   	     	 return filtrarFechas(date);
	   	    }
	  	 ] 
	 });
 
	function filtrarFechas(date) {
		var day = date.getDay();
		var options = ddlMedicos.options[ddlMedicos.selectedIndex]
		var horarios = JSON.parse(options.getAttribute('data-horarios-json'))

		
		for (var i = 0; i < horarios.length; i++) {
			var dia = obtenerNombreDia(day)
		  	if (horarios[i].estado && horarios[i].dia === dia) {
		    	return false;
		  }
		}
	    
		return true;
	}
	ddlMedicos.addEventListener('change', function() {
		var flatpickrInstance = document.getElementById('fecha')._flatpickr;
		  var minDate = flatpickrInstance.config.minDate;
		  var maxDate = flatpickrInstance.config.maxDate;
		  var disabledDates = [];
		  
		  for (var date = new Date(minDate); date <= maxDate; date.setDate(date.getDate() + 1)) {
			  if (filtrarFechas(date)) {
				  disabledDates.push(new Date(date));
			    }
		  }
		  flatpickrInstance.set('disable', disabledDates);
		});
	
	function obtenerNombreDia(day) {
	    var dias = ['Domingo', 'Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado'];
	    return dias[day];
	  }
	
	
	
	function obtenerHorariosDisponibles(fecha) {
	   
	    var horarios = ["10:00 - 11:00"];
	
	    return horarios;
	}
	
	function asignarTurno() {
	   
	}
	$(document).ready(function() {
		filtrarMedicos(); 
	});
	
	var medicos = document.querySelectorAll('#ddlMedicos option');
	function filtrarMedicos() {
		var especialidadSeleccionada = document.getElementById('ddlEspecialidades').value;
		var ddlMedicos = document.getElementById('ddlMedicos');
		
		ddlMedicos.innerHTML = '';
		for (var i = 0; i < medicos.length; i++) {
			var option = medicos[i];
			var codEspecialidad = option.getAttribute('data-especialidad-id');

			if (codEspecialidad === especialidadSeleccionada) {
				ddlMedicos.appendChild(option.cloneNode(true));
			}
		}
	}
</script>

</html>