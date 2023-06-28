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
	<form class="w-50 m-auto" method="post" action="servletTurnos" id="formTurnos">
		
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
            <input class="form-control" type="text" name="fecha" id="fecha" onchange="cargarHorariosDisponibles()" required>
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
		
		<button class="form-control" type="submit" name="btnAsignar" id="btnAsignar">Asignar turno</button>
	</form>
</body>

<%
		if((Boolean)request.getAttribute("guardo") != null){
			boolean creo = (boolean)request.getAttribute("guardo");
			
			if(creo == true){
				%><script>Notiflix.Notify.success("Se creo el turno con éxito!")</script> <% 
			}    
			else{
				%><script>Notiflix.Notify.failure("No se pudo crear el turno")</script> <% 
			}
		}
%>

<script>
	var ddlMedicos = document.getElementById('ddlMedicos')
	var ddlEspecialidades = document.getElementById('ddlEspecialidades')
	var fechaInput = document.getElementById('fecha');
	
 	var fpFechas = flatpickr("#fecha", {
		minDate: "today",
		maxDate: new Date().setMonth(new Date().getMonth() + 4),
		required: true,
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
		var filtrar = true
		
		if (horarios !== null) {
			for (var i = 0; i < horarios.length; i++) {
				var dia = obtenerNombreDia(day)
			  	if (horarios[i].estado && horarios[i].dia === dia) {
			    	filtrar = false;
			  }
			}
		}
	    
		return filtrar;
	}
	
	ddlMedicos.addEventListener('change', function() {
	  	recargarHorarios();
	});
	
	ddlEspecialidades.addEventListener('change', function() {
  		document.getElementById('ddlHorariosDisponibles').innerHTML = "";
		recargarHorarios();
	});
	
	function recargarHorarios(){
		document.getElementById('fecha').value = "";
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
	  	document.getElementById('fecha').value = "";
  		document.getElementById('ddlHorariosDisponibles').innerHTML = "";
	}
	
	function obtenerNombreDia(day) {
	    var dias = ['Domingo', 'Lunes', 'Martes', 'Miercoles', 'Jueves', 'Viernes', 'Sabado'];
	    return dias[day];
	  }
	
	function cargarHorariosDisponibles() {
		var ddlHorarios = document.getElementById('ddlHorariosDisponibles');
		ddlHorarios.innerHTML = '';

		var selectedDia = document.getElementById('fecha').value;
		var selectedIndex = ddlMedicos.options[ddlMedicos.selectedIndex];
		var codMed = document.getElementById('ddlMedicos').value;
		var horarios = JSON.parse(selectedIndex.getAttribute('data-horarios-json'));
		
		if (selectedDia !== "") {
		   	ddlHorariosDisponibles.disabled = false;
			} else {
			ddlHorariosDisponibles.disabled = true;
		}
		
		var requests = [];

	  	horarios.forEach(function(horario) {
		    const horaDesde = horario.horarioDesde.hour;
		    const horaHasta = horario.horarioHasta.hour;
		    const dia = obtenerNombreDia(new Date(selectedDia + "T00:00:00").getDay());

		    if (horario.dia === dia) {
				for (let hora = horaDesde; hora <= horaHasta; hora++) {
			        const optionText = hora.toString().padStart(2, '0') + ':00';
			        const option = document.createElement('option');
			        option.value = optionText;
			        option.text = optionText;
	
			        const request = $.ajax({
			          url: "servletTurnos",
			          method: "POST",
			          data: { fechaAjax: selectedDia, horarioAjax: option.text, codMedAjax: codMed}
			        }).then(function(response) {
			          if (response === "false") {
			            ddlHorarios.appendChild(option);
			            ordenarHorarios();
			          }
			        });

		        	requests.push(request);
				}		
			}
		});
	}
	
	$(document).ready(function() {
		filtrarMedicos(); 
	});
	
	function ordenarHorarios(){
		var ddlHorarios = document.getElementById('ddlHorariosDisponibles');
		var opciones = Array.from(ddlHorarios.options); 

		opciones.sort(function(a, b) {		  
		  var fechaA = new Date('2000-01-01 ' + a.value);
		  var fechaB = new Date('2000-01-01 ' + b.value);

		  return fechaA - fechaB;
		});

		ddlHorarios.innerHTML = ''; 

		opciones.forEach(function(opcion) {
		  ddlHorarios.appendChild(opcion); 
		});
	}
	
	document.getElementById("btnAsignar").addEventListener('click', function() {
		
		  if (fechaInput.value == null || fechaInput.value == "") {
			event.preventDefault();
		    Notiflix.Notify.failure("Complete los campos!");
		  }
		
	});
	
	var medicos = document.querySelectorAll('#ddlMedicos option');
	function filtrarMedicos() {
		var especialidadSeleccionada = document.getElementById('ddlEspecialidades').value;
		var ddlMedicos = document.getElementById('ddlMedicos');
		
	 	if (ddlMedicos.options.length > 0) {
	 		fechaInput.disabled = false;
		    ddlHorariosDisponibles.disabled = true;
	  	} else {
	  		fechaInput.disabled = true;
	  	}

		ddlMedicos.innerHTML = '';
		var medicoEncontrado = false;
		
		for (var i = 0; i < medicos.length; i++) {
			var option = medicos[i];
			var codEspecialidad = option.getAttribute('data-especialidad-id');

			if (codEspecialidad === especialidadSeleccionada) {
				ddlMedicos.appendChild(option.cloneNode(true));
			    medicoEncontrado = true;
			}
		}
		
		if (!medicoEncontrado) {
		    ddlMedicos.innerHTML = '<option value="null">No hay médicos de esta especialidad</option>';
		    fechaInput.disabled = true;
		    ddlHorariosDisponibles.disabled = true;
		}
	}
</script>

</html>