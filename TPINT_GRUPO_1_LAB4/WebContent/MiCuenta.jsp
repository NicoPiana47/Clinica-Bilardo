<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="entidades.Medico" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>MiCuenta</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-0evHe/X+R7YkIZDRvuzKMRqM+OrBnVFBL6DOitfPri4tjfHxaWutUpFmBp4vmVor" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-pprn3073KE6tl6bjs2QrFaJGz5/SUsLqktiwsUTF55Jfv3qYSDhgCecCxMW52nD2" crossorigin="anonymous"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="./src/Style/estilos.css">
</head>
<style>
	#form-micuenta{
		display: flex;
		justify-content: center;
		align-items: center;
	}
</style>

<body>
	<%@ include file="/MasterPage.jsp" %>
   	<form class="w-100 m-auto" id="form-micuenta">
	  	<div class="col-12 col-md-6">
	    	<div class="row m-2">
	      		<div class="col-12 col-sm-4">
			        <label class="form-label">DNI</label>
			        <input class="form-control" type="number" min="0" name="txtDNI" value="<%= med.getDNI() %>" disabled>
	    		</div>
	
				<div class="col-12 col-sm-4">
					 <label class="form-label">Nombre</label>
					 <input class="form-control" name="txtNombreCR" value="<%= med.getNombre() %>" disabled>
				</div>
	
				<div class="col-12 col-sm-4">
					<label class="form-label">Apellido</label>
					<input class="form-control" name="txtApellido" value="<%= med.getApellido() %>" disabled>
				</div>
	    	</div>
	
			<div class="row m-2">
				<div class="col-12 col-sm-4">
					<label class="form-label">Sexo</label>
					<select class="form-control" name="txtSexo" disabled>
						<option<% if (med.getSexo().equals("Masculino")) { %> selected <% } %>>Masculino</option>
						<option<% if (med.getSexo().equals("Femenino")) { %> selected <% } %>>Femenino</option>
						<option<% if (med.getSexo().equals("Otro")) { %> selected <% } %>>Otro</option>
					</select>
				</div>
	
				<div class="col-12 col-sm-4">
					<label class="form-label">Nacionalidad</label>
					<input class="form-control" name="txtNacionalidad" value="<%= med.getNacionalidad() %>" disabled>
				</div>
				
				<div class="col-12 col-sm-4">
					<label class="form-label">Fecha de nacimiento</label>
					<input class="form-control" type="date" name="txtFechaNacimiento" value="<%= med.getFechaNacimiento() %>" disabled>
				</div>
			</div>
	
			<div class="row m-2">
				<div class="col-12 col-sm-4">
					<label class="form-label">Dirección</label>
					<input class="form-control" name="txtDireccion" value="<%= med.getDireccion() %>" disabled>
				</div>
	
				<div class="col-12 col-sm-4">
					<label class="form-label">Provincia</label>
					<select class="form-control" name="ddlProvincia" disabled>
						<option value="<%= med.getProvincia().getCodProvincia() %>"><%= med.getProvincia().getDescripcion() %></option>
					</select>
				</div>
	
	     		<div class="col-12 col-sm-4">
					<label class="form-label">Localidad</label>
	     			<select class="form-control" name="ddlLocalidad" disabled>
	         			<option value="<%= med.getLocalidad().getCodLocalidad() %>"><%= med.getLocalidad().getDescripcion() %></option>
	        		</select>
	      		</div>
			</div>
	
			<div class="row m-2">
				<div class="col-12 col-sm-4">
					<label class="form-label">Correo</label>
					<input class="form-control" type="email" name="txtCorreo" value="<%= med.getCorreo() %>" disabled>
				</div>
	
				<div class="col-12 col-sm-4">
					<label class="form-label">Telefono</label>
					<input class="form-control" type="number" min="0" name="txtTelefono" value="<%= med.getTelefono() %>" disabled>
				</div>
	
		     	<div class="col-12 col-sm-4">
					<label class="form-label">Especialidad</label>
					<select class="form-control" name="ddlEspecialidades" disabled>
						<option value="<%= med.getEspecialidad().getCodEspecialidad()%>"><%= med.getEspecialidad().getDescripcion() %> </option>
					</select>
				</div>	
			</div>

			<div class="row m-2">
				<div class="col-12">
					<div class="row">
						<div class="col-12 col-sm-6">
							<label class="form-label">Usuario</label>
							<input class="form-control" name="txtUsuario" value="<%= med.getUsername() %>" disabled>
						</div>
					
						<div class="col-12 col-sm-6">
							<label class="form-label">Contraseña</label>
							<div class="input-group">
								<input class="form-control" type="password" name="txtContraseña" value="<%= med.getContraseña() %>" disabled>
								<button class="btn btn-outline-secondary" type="button" id="togglePassword">
									<i class="bi bi-eye"></i>
								</button>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</form>

	<div class="row">
		<div class="col-4 m-auto">
	    	<button class="form-control" id="btnVerHorario" onclick="openModal('modalHorarios')">Horarios</button>
       	</div>
	</div>
   
	<div id="modalHorarios" class="modal">
		<div class="modal-content">
			<span class="close" onclick="closeModal('modalHorarios')">&times;</span>
			<div class="d-flex align-items-center justify-content-center">
				<div class="container-fluid" style="width:95%; margin-bottom:20px">
					<div class="card text-center" style="box-shadow: rgba(0, 0, 0, 0.24) 0px 3px 100px;">
						<div class="card-header"><h5>Horario</h5></div>
						<table class="table table-hover" id="table_horarios" style="font-size: 11px;">
							<thead>
								<tr class="center-header">
									<th>Día</th>
									<th>Horario Desde</th>
									<th>Horario Hasta</th>
									<th>Horas</th>
									<th>Estado</th>
								</tr>
							</thead>
					        <tbody id="tablaHorariosBody"> </tbody>                                             
						</table>
						<input type="hidden" name="datosHorarios" id="datosHorarios" value='<%= med.getHorariosJson() %>'>
					</div>
				</div>
			</div>
		</div>
	</div>

<script type="text/javascript">
	function openModal(modal) {
		document.getElementById(modal).style.display = "block";
	}
	
	function closeModal(modal) {
		document.getElementById(modal).style.display = "none";
	}
	
	const passwordInput = document.querySelector("input[name='txtContraseña']");
    const togglePasswordButton = document.getElementById("togglePassword");

    togglePasswordButton.addEventListener("click", function() {
        if (passwordInput.type === "password") {
            passwordInput.type = "text";
            togglePasswordButton.innerHTML = '<i class="bi bi-eye-slash"></i>';
        } else {
            passwordInput.type = "password";
            togglePasswordButton.innerHTML = '<i class="bi bi-eye"></i>';
        }
    });
    
	//CARGAR TABLA AL PRESIONAR BOTON
	var btnVerHorario = document.getElementById('btnVerHorario');
	btnVerHorario.addEventListener('click', function() {	
		cargarTabla();
	});

	// CARGAR TABLA HORARIOS
	function cargarTabla() {
		var horarios = document.getElementById('datosHorarios').value;
	  	var tablaBody = document.getElementById("tablaHorariosBody");
	  	
	  // Limpiar tabla
	  	tablaBody.innerHTML = "";
	  
	  // Convertir el JSON de horarios a objeto
	  	var horariosObj = JSON.parse(horarios);
	  
	  	// Ordena los horarios
		horariosObj.sort(function(a, b) {
	        var diasSemana = ["Domingo", "Lunes", "Martes", "Miercoles", "Jueves", "Viernes", "Sabado"];
	        var diaA = diasSemana.indexOf(a.dia);
	        var diaB = diasSemana.indexOf(b.dia);
	        return diaA - diaB;
		});
	  
	  // Recorrer los horarios y agregar filas a la tabla
	  	horariosObj.forEach(function(horario) {
		    var nuevaFila = document.createElement("tr");
		    
		    var celdaDia = document.createElement("td");
		    var celdaHorarioDesde = document.createElement("td");
		    var celdaHorarioHasta = document.createElement("td");
		    var celdaCantidadHoras = document.createElement("td");
		    var celdaEstado = document.createElement("td");
		    var checkbox = document.createElement("input");
		    checkbox.disabled = true;
		    checkbox.type = "checkbox";
		    checkbox.checked = horario.estado;
		    celdaEstado.appendChild(checkbox);

		    var horarioDesde = horario.horarioDesde;
		    var horarioHasta = horario.horarioHasta;
	
		    celdaDia.textContent = horario.dia;
	        celdaHorarioDesde.textContent = formatearHora(horarioDesde);
			celdaHorarioHasta.textContent = formatearHora(horarioHasta);
			celdaCantidadHoras.textContent = horarioHasta.hour - horarioDesde.hour;

		    nuevaFila.appendChild(celdaDia);
		    nuevaFila.appendChild(celdaHorarioDesde);
		    nuevaFila.appendChild(celdaHorarioHasta);
		    nuevaFila.appendChild(celdaCantidadHoras);
		    nuevaFila.appendChild(celdaEstado);
	
		    tablaBody.appendChild(nuevaFila);
	  	});
	}
	
	function formatearHora(horario) {
		var options = {
			hour: "2-digit",
			minute: "2-digit"
		};
		
		var hora = new Date();
		hora.setHours(horario.hour);
		hora.setMinutes(horario.minute);
		
		return hora.toLocaleTimeString(undefined, options); 
  	}
	
</script>

</body>
</html>