<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>AdminMedicos</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-0evHe/X+R7YkIZDRvuzKMRqM+OrBnVFBL6DOitfPri4tjfHxaWutUpFmBp4vmVor" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-pprn3073KE6tl6bjs2QrFaJGz5/SUsLqktiwsUTF55Jfv3qYSDhgCecCxMW52nD2" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>
<link rel="stylesheet" type="text/css" href="./src/Style/estilos.css">
<%@ page import="java.time.LocalTime" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.HashSet" %>
<%@ page import="java.util.Set" %>
<%@ page import="entidades.Medico" %>
<%@ page import="entidades.Provincia" %>
<%@ page import="entidades.Localidad" %>
<%@ page import="entidades.Especialidad" %>
<%@ page import="entidades.MedicosXDias" %>
</head>

<body>
	<%@ include file="/MasterPage.jsp" %>
	<h1 class="text-center">Administración de médicos</h1>
	
	<div class="row m-4">
		<div class="col-4 m-auto">
			<button class="form-control" onclick="openModal('modalMedico')">Crear Medico</button>
		</div>
	</div>
	
	<form method="post" action="servletMedicos">
		<div class="row m-4">
			<div class="col-4">
				<input class="form-control" name="txtFiltro" id="txtFiltro" placeholder="Ingrese para filtrar"> 
			</div>
			<div class="col-4"> 
			    <select class="form-control" name="ddlFiltros" >
			        <% 
				    if (request.getAttribute("listaFiltros") instanceof Map) {
				        Map<String, String> listaFiltros = (Map<String, String>) request.getAttribute("listaFiltros");
				        for (Map.Entry<String, String> entry : listaFiltros.entrySet()) { 
				            String campo = entry.getKey();
				            String descripcion = entry.getValue();
					%>
	           			<option value="<%= campo %>"><%= descripcion %></option>
					<% 
				        } 
				    }
					%>
			    </select>
			</div>
			<div class="col-2"> 
				<button  class="form-control" name="btnFiltrar" id="btnFiltrar">Filtrar</button>
			</div>
			<div class="col-2"> 
				<button  class="form-control" name="btnLimpiarFiltros">Limpiar Filtro</button>
			</div>
		</div>
	</form>

    <div class="input-group col-6 m-auto">
  		<input type="search" class="form-control rounded" placeholder="Buscar en la grilla" aria-label="Search" id="search-input" aria-describedby="search-addon" />
	</div>             
                
	<div class="container-fluid mt-4" style="width:95%; margin-bottom:20px">
		<div class="card text-center" style="box-shadow: rgba(0, 0, 0, 0.24) 0px 3px 100px;">
			<div class="card-header" style="width: 100%;"><h5>Médicos</h5></div>
			<table class="table table-hover text-center" id="table_id_medicos" style="width: 100%; font-size: 11px;">
				<thead>
					<tr class="center-header">
						<th> </th> 
						<th>Código</th> 
						<th>DNI</th>   
						<th>Nombre</th> 
						<th>Apellido</th>
						<th>Sexo</th> 
						<th>Nacionalidad</th> 
						<th>Fecha de nacimiento</th> 
						<th>Dirección</th>
						<th>Provincia</th>
						<th>Localidad</th>
						<th>Correo</th>
						<th>Teléfono</th> 
						<th>Especialidad</th>
						<th>Usuario</th>
						<th>Contraseña</th>
						<th>Admin</th>
						<th>Estado</th>
					</tr>
				</thead>
		        <tbody>
		       		<% 
				    if (request.getAttribute("listaMedicos") instanceof List) {
				        List<Medico> listaMedicos = (List<Medico>) request.getAttribute("listaMedicos");
				        for (Medico medico : listaMedicos) { 
				    	
					%>
					<tr onclick="openModal('modalMedico', this)">
					
						<% SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy"); %>
					
						<td scope="row">
							<input type="hidden" id="horarios" value='<%= medico.getHorariosJson() %>'>
							<form method="post" action="servletMedicos">						
								<button type="submit" name="btnEliminar" class="btn btn-outline-danger btn-sm" onclick="event.stopPropagation(); return confirm('¿Esta seguro de que quiere eliminar el médico?')">
									<input type="hidden" name="CodMed" value="<%= medico.getCodMed() %>">
									<i class="fa-solid fa-trash"></i>
								</button>
							</form>
	                	</td>
	                	<td><%=medico.getCodMed()%></td>  
	                	<td><%=medico.getDNI()%></td>   
						<td><%=medico.getNombre()%></td> 
						<td><%=medico.getApellido()%></td>
						<td><%=medico.getSexo()%></td> 
						<td><%=medico.getNacionalidad()%></td> 
						<td><%=formatter.format(medico.getFechaNacimiento()) %></td>
						<td><%=medico.getDireccion()%></td>
						<td><%=medico.getProvincia()%></td>
						<td><%=medico.getLocalidad()%></td>
						<td><%=medico.getCorreo()%></td>
						<td><%=medico.getTelefono()%></td> 
						<td><%=medico.getEspecialidad()%></td>
						<td><%=medico.getUsername()%></td>
						<td><%=medico.getContraseña()%></td>
						<td>
							<label class="checkbox-label">
					            <input type="checkbox" <%= medico.getTipo() ? "checked" : "" %> disabled>
					            <span class="checkmark"></span>
					        </label>
					    </td>
						<td>
					        <label class="checkbox-label">
					            <input type="checkbox" <%= medico.getEstado() ? "checked" : "" %> disabled>
					            <span class="checkmark"></span>
					        </label>
					    </td>
		         	</tr>
		         	<% 
			        	} 
				    }
					%>
		    	</tbody>                                             
			</table>
		</div>
	</div>
      
    <form action="servletMedicos" method="POST">
		<div id="modalMedico" class="modal">
	   		<div class="modal-content">
	        	<span class="close" onclick="closeModal('modalMedico', false)" >&times;</span>
	        	<div class="d-flex align-items-center justify-content-center">
	        		<div class="col-12">
						<div class="row m-2">
							<input type="hidden" name="codMed" id="codMed" >
				        	<div class="col-4">
						     	<label class="form-label">DNI</label>   	
				                <input class="form-control" type="number"  min="0" name="txtDNI" id="txtDNI" required>
				            </div>
				            
				            <div class="col-4">
					     		<label class="form-label">Nombre</label> 
				                <input class="form-control" name="txtNombre" oninput="validarLetras(this)" id="txtNombre"  required>
				            </div>
				            
				            <div class="col-4">
					     		<label class="form-label">Apellido</label>
				                <input class="form-control" name="txtApellido" oninput="validarLetras(this)"id="txtApellido"  required>
				            </div>
						</div>
				        
				        <div class="row m-2">
				        	<div class="col-4">
				        	<label class="form-label">Sexo</label>
				        		<select class="form-control" name="ddlSexo" id="ddlSexo">
				        			<option>Masculino</option>
				        			<option>Femenino</option>
				        			<option>Otro</option>
				        		</select> 
				        	</div>
				        	
				        	<div class="col-4">
				        		<label class="form-label">Nacionalidad</label> 
				        		<input class="form-control" name="txtNacionalidad" id="txtNacionalidad" oninput="validarLetras(this)" required> 
				        	</div>
				        	<div class="col-4"> 
				        		<label class="form-label">Fecha de nacimiento</label>
					        	<input class="form-control" type="date" name="txtFechaNacimiento" id="txtFechaNacimiento" required>
				        	</div>
				        </div>
				        
				        <div class="row m-2">
				        	<div class="col-4">
					        	<label class="form-label">Dirección</label>
								<input class="form-control" name="txtDireccion" id="txtDireccion" required>
				        	</div>
				        	
				        	<div class="col-4">
				        		<label class="form-label">Provincia</label> 
				        		<select class="form-control" name="ddlProvincia" id="ddlProvincia" onchange="filtrarLocalidades()">
					        		<% 
							        if (request.getAttribute("listaProvincias") instanceof List) {
							            List<Provincia> listaProvincias = (List<Provincia>) request.getAttribute("listaProvincias");
							            for (Provincia provincia : listaProvincias) { 
							        %>
							            <option value="<%= provincia.getCodProvincia() %>"><%= provincia.getDescripcion() %></option>				
							        <% 
							            } 
							        }
							        %>
				        		</select> 
				        	</div>
				        		<div class="col-4"> 
					        		<label class="form-label">Localidad</label>
						        	<select class="form-control" name="ddlLocalidad" id="ddlLocalidad">
								        <% 
								        if (request.getAttribute("listaLocalidades") instanceof List) {
								            List<Localidad> listaLocalidades = (List<Localidad>) request.getAttribute("listaLocalidades");
								            for (Localidad localidad : listaLocalidades) { 
								        %>
								            <option value="<%= localidad.getCodLocalidad() %>"
								            		data-provincia-id="<%= localidad.getProvincia().getCodProvincia() %>">
							            		<%= localidad.getDescripcion() %>
							            	</option>				
								        <% 
								            } 
								        }
								        %>
								    </select> 	
				        		</div>		        	
			        	</div>	        
				        <div class="row m-2">
				        	<div class="col-4">
				        		<label class="form-label">Correo</label>
				        		<input class="form-control" type="email" name="txtCorreo" id="txtCorreo" required>
				        	</div>
				        	
				        	<div class="col-4">
				        		<label class="form-label">Telefono</label> 
				        		<input class="form-control" type="number"  min="0" name="txtTelefono" id="txtTelefono" required> 
				        	</div>
				        	<div class="col-4"> 
				        		<label class="form-label">Especialidad</label>
					        	<select class="form-control" name="ddlEspecialidad" id="ddlEspecialidad">
						        	<% 
								        if (request.getAttribute("listaEspecialidades") instanceof List) {
								            List<Especialidad> listaEspecialidades = (List<Especialidad>) request.getAttribute("listaEspecialidades");
								            for (Especialidad especialidad : listaEspecialidades) { 
								        %>
								            <option value="<%= especialidad.getCodEspecialidad() %>">
								            	<%= especialidad.getDescripcion()%>
							            	</option>				
								        <% 
								            } 
								        } 
									%>
					        	</select> 	
				        	</div>
				        </div>
				        
				        <div class="row m-2">
				        	<div class="col-4">
				        		<label class="form-label">Ver</label> 			        		
				        		<button type="button" id="btnVerHorario" class="form-control" onclick="openModal('modalHorarios')">Horarios</button>
				        	</div>
				        	
				        	<div class="col-4">
				        		<label class="form-label">Usuario</label> 
				        		<input class="form-control" name="txtUsuario" id="txtUsuario" required> 
				        	</div>
				        	<div class="col-4"> 
				        		<label class="form-label">Contraseña</label>
						        <div class="input-group">
	       							 <input class="form-control" type="text" name="txtContraseña" id="txtContraseña" required> 
	    						</div>	 	
				        	</div>
				        </div>
				        
				        <div class="row m-2">
				        	<div class="col-6">
				        		<label class="form-label">Normal</label>
					        	<input class="form-check-input" style="margin-left:20px" type="radio" name="rdTipo" value="0" checked>
				        	</div>
				        	<div class="col-6">
				        		<label class="form-label">Admin</label>
				        		<input class="form-check-input" style="margin-left:20px" type="radio" name="rdTipo" value="1">
				        	</div>
				        </div>
				        
				        <div class="row m-2">
				        	<div class="col-6 editM">
				        		<label class="form-label">Activo</label>
					        	<input class="form-check-input" style="margin-left:20px" type="radio" name="rdEstado" value="1" checked>
				        	</div>
				        	<div class="col-6 editM">
				        		<label class="form-label">Inactivo</label>
				        		<input class="form-check-input" style="margin-left:20px" type="radio" name="rdEstado" value="0">
				        	</div>
				        </div>
				        
				        <div class="row m-2 createM" >
				        	<div class="col-12">
					        	<button class="form-control" name="btnCrearMedico" type="submit" style="margin-top:10px">Crear Médico</button>
				        	</div>
				        </div>
				        
				        <div class="row m-2 editM" >
				        	<div class="col-12">
					        	<button class="form-control" name="btnEditarMedico" type="submit" style="margin-top:10px">Editar Médico</button>
				        	</div>
				        </div>
					</div>
				</div>
			</div>
		</div>
	
		<div id="modalHorarios" class="modal">
	   		<div class="modal-content">
	        	<span class="close" onclick="closeModal('modalHorarios', true)" >&times;</span>
	        	<div class="d-flex align-items-center justify-content-center">
	        		<div class="container-fluid" style="width:95%; margin-bottom:20px">
						<div class="card text-center" style="box-shadow: rgba(0, 0, 0, 0.24) 0px 3px 100px;">
							<div class="card-header "><h5>Horario</h5></div>
							<table class="table table-hover" id="table_horarios" style="font-size: 11px;">
								<thead>
									<tr>
										<th>Dia</th>   
										<th>Horario Desde</th> 
										<th>Horario Hasta</th>
										<th>Estado</th>
									</tr>
								</thead>
						        <tbody id="tablaHorariosBody"> </tbody>                                             
							</table>
						 	<input type="hidden" name="datosHorarios" id="datosHorarios">
						</div>
					</div>
					
					<div id="divHorario" class="col-6" style="display: block;">
						<div class="row m-2">
				        	<div class="col-4">
						     	<label class="form-label">Dia</label>   	
				                <select class="form-control" name="ddlDia" id="ddlDia" >
  									<option value="" selected hidden></option>
				        			<option>Domingo</option>
				        			<option>Lunes</option>
				        			<option>Martes</option>
				        			<option>Miercoles</option>
				        			<option>Jueves</option>
				        			<option>Viernes</option>
				        			<option>Sabado</option>
				        		</select> 
				            </div>
				            
				            <div class="col-4 hour-selector">
					     		<label class="form-label">Horario Desde</label> 
					     		<select class="form-control" name="ddlHorarioDesde" id="ddlHorarioDesde" >
  									<option value="" selected hidden></option>
				        		</select> 
					     	</div>
				            
				            <div class="col-4 hour-selector">
					     		<label class="form-label">Horario Hasta</label>
					     		<select class="form-control" name="ddlHorarioHasta" id="ddlHorarioHasta" >
  									<option value="" selected hidden></option>
				        		</select> 
				            </div>
						</div>
						
						<div class="row m-2" >
				        	<div class="col-6 editH" style="display: none;">
				        		<label class="form-label">Activo</label>
					        	<input class="form-check-input" style="margin-left:20px" type="radio" name="rdEstadoHorario" value="1" checked>
				        	</div>
				        	<div class="col-6 editH" style="display: none;">
				        		<label class="form-label">Inactivo</label>
				        		<input class="form-check-input" style="margin-left:20px" type="radio" name="rdEstadoHorario" value="0">
				        	</div>
				        </div>
				        
						<div class="row m-2 createH">
					        <div class="col-12">
				        		<button type="button" class="form-control btn-success" >Agregar</button>
					        </div>
				        </div>
				        
				        <div class="row m-2 editH" style="display: none;">
					        <div class="col-12">
				        		<button type="button" class="form-control btn-primary">Modificar</button>
							</div>
				        </div>
					</div>
				</div>
			</div>
		</div>
	</form>
	
	<%
		if((Boolean)request.getAttribute("elimino") != null){
			boolean elimino = (boolean)request.getAttribute("elimino");
			if(elimino==true){
				%><script>Notiflix.Notify.success("Se eliminó el médico con éxito!")</script> <% 
			}    
			else{
				%><script>Notiflix.Notify.success("No se pudo eliminar al médico")</script> <% 
			}
		}                                             	
	%>
	
	<%
		if((Integer)request.getAttribute("CrearMedico") != null){
			int creo = (int)request.getAttribute("CrearMedico");
			
			if(creo == 1){
				%><script>Notiflix.Notify.success("Se creo el médico con éxito!")</script> <% 
			}    
			if(creo == 2){
				%><script>Notiflix.Notify.failure("DNI repetido")</script> <% 
			}
			if(creo == 3){
				%><script>Notiflix.Notify.failure("Correo repetido")</script> <% 
			}
			if(creo == 4){
				%><script>Notiflix.Notify.failure("Usuario repetido")</script> <% 
			}
			if(creo == 0){
				%><script>Notiflix.Notify.failure("No se pudo crear al médico")</script> <% 
			}
		}                                      	
	%>
	
	<%
		if((Integer)request.getAttribute("edito") != null){
			int edito = (int)request.getAttribute("edito");
			
			if(edito == 1){
				%><script>Notiflix.Notify.success("Se editó el médico con éxito!")</script> <% 
			}    
			if(edito == 2){
				%><script>Notiflix.Notify.failure("DNI repetido")</script> <% 
			}
			if(edito == 3){
				%><script>Notiflix.Notify.failure("Correo repetido")</script> <% 
			}
			if(edito == 4){
				%><script>Notiflix.Notify.failure("Usuario repetido")</script> <% 
			}
			if(edito == 0){
				%><script>Notiflix.Notify.failure("No se pudo editar al médico")</script> <% 
			}
		}                                             	
	%>
	
<script>
	var fpFechaNac = flatpickr("#txtFechaNacimiento", {
		maxDate: new Date().setMonth(new Date().getMonth() - 1),
		required: true,
	    dateFormat: "d/m/Y"
	});
		
	//CARGAR TABLA AL PRESIONAR BOTON
	var btnVerHorario = document.getElementById('btnVerHorario');
	btnVerHorario.addEventListener('click', function() {	
		cargarTabla();
	});

	// CARGAR TABLA HORARIOS
	function cargarTabla() {
		var horarios = document.getElementById('datosHorarios').value;
		console.log(horarios)
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
			nuevaFila.onclick = function() {
				  selectHorario(this);
			};
		    
		    var celdaDia = document.createElement("td");
		    var celdaHorarioDesde = document.createElement("td");
		    var celdaHorarioHasta = document.createElement("td");
		    var celdaEstado = document.createElement("td");
		    var checkbox = document.createElement("input");
		    checkbox.disabled = true;
		    checkbox.type = "checkbox";
		    checkbox.checked = horario.estado;
		    celdaEstado.appendChild(checkbox);
	
		    celdaDia.textContent = horario.dia;
	        celdaHorarioDesde.textContent = formatearHora(horario.horarioDesde);
			celdaHorarioHasta.textContent = formatearHora(horario.horarioHasta);

		    nuevaFila.appendChild(celdaDia);
		    nuevaFila.appendChild(celdaHorarioDesde);
		    nuevaFila.appendChild(celdaHorarioHasta);
		    nuevaFila.appendChild(celdaEstado);
	
		    tablaBody.appendChild(nuevaFila);
	  	});
	}
	
	// FORMATEAR LA HORA AL CARGAR LA TABLA
	function formatearHora(horario) {
	    var options = {
	      hour: "2-digit",
	      minute: "2-digit"
	    };
	
	    if (typeof horario === 'object') {
	      var hora = new Date();
	      hora.setHours(horario.hour);
	      hora.setMinutes(horario.minute);
	
	      return hora.toLocaleTimeString(undefined, options);
	    } else {
	      return horario;
	    }
  	}
	
	// AGREGAR HORARIO
	var botonAgregar = document.querySelector('.createH button');
	var ddlDia = document.querySelector('select[name="ddlDia"]');

	// onChange DDLDIA
	ddlDia.addEventListener('change', function() {
	    var dia = ddlDia.value;
        var tablaBody = document.getElementById("tablaHorariosBody");
        var filas = tablaBody.getElementsByTagName("tr");
        
        for (var i = 0; i < filas.length; i++) {
            var filaDia = filas[i].getElementsByTagName("td")[0].textContent;
            
            if (filaDia === dia) {
                botonAgregar.textContent = "Día existente";
                return;
            }
        }
	    
	    botonAgregar.textContent = "Agregar";
	});
	
	// ONCLICK AGREGAR
	botonAgregar.addEventListener('click', function() {	
		var dia = document.querySelector('select[name="ddlDia"]').value;
		var horarioDesde = document.querySelector('select[name="ddlHorarioDesde"]').value;
		var horarioHasta = document.querySelector('select[name="ddlHorarioHasta"]').value;
		
		if(dia && horarioDesde && horarioHasta){		
		    var tablaBody = document.getElementById("tablaHorariosBody");
		    var filas = tablaBody.getElementsByTagName("tr");
		    
	        for (var i = 0; i < filas.length; i++) {
	            var filaDia = filas[i].getElementsByTagName("td")[0].textContent;
	            if (filaDia === dia) {
	                return;
	            }
	        }
			
			var nuevaFila = document.createElement("tr");
			nuevaFila.onclick = function() {
				  selectHorario(this);
			};
			
		    var celdaDia = document.createElement("td");
		    var celdaHorarioDesde = document.createElement("td");
		    var celdaHorarioHasta = document.createElement("td");
		    var celdaEstado = document.createElement("td");
		    var checkbox = document.createElement("input");
		    checkbox.type = "checkbox";
		    checkbox.disabled = true;
		    checkbox.checked = true;
		   	celdaEstado.appendChild(checkbox);
		
		    celdaDia.textContent = dia;
		    celdaHorarioDesde.textContent = horarioDesde;
		    celdaHorarioHasta.textContent = horarioHasta;	
		    
		    nuevaFila.appendChild(celdaDia);
		    nuevaFila.appendChild(celdaHorarioDesde);
		    nuevaFila.appendChild(celdaHorarioHasta);
		    nuevaFila.appendChild(celdaEstado);
		    
		    tablaBody.appendChild(nuevaFila);
		    
		    actualizarValores();
		    cleanFormHorarios();
		}
	});
	
	// MODIFICAR HORARIO
	var botonModificar = document.querySelector('.editH button');
	botonModificar.addEventListener('click', function() {
		var selectedRow = document.querySelector('.selected-row');  
		var dia = document.querySelector('select[name="ddlDia"]').value;
		var horarioDesde = document.querySelector('select[name="ddlHorarioDesde"]').value;
		var horarioHasta = document.querySelector('select[name="ddlHorarioHasta"]').value;
		var estadoSeleccionado = document.querySelector('input[name="rdEstadoHorario"]:checked').value;
		var camposCompletos = dia && horarioDesde && horarioHasta;

		if (selectedRow && camposCompletos) {
			var celdaDia = selectedRow.querySelector("td:nth-child(1)");
		    var celdaHorarioDesde = selectedRow.querySelector("td:nth-child(2)");
		    var celdaHorarioHasta = selectedRow.querySelector("td:nth-child(3)");
		    var celdaEstado = selectedRow.querySelector("td:nth-child(4)");
			celdaEstado.textContent = "";
		    
		    var checkbox = document.createElement("input");
			checkbox.type = "checkbox";
			checkbox.disabled = true;
			checkbox.checked = estadoSeleccionado === "1" ? true : false;
			
		    celdaDia.textContent = dia;
		    celdaHorarioDesde.textContent = horarioDesde;
		    celdaHorarioHasta.textContent = horarioHasta;
			celdaEstado.appendChild(checkbox);

		    actualizarValores();
		}
	});
	
	// ACTUALIZAR VALORES DE HORARIOS A JSON DESPUES DE AGREGAR
	function actualizarValores() {
		var filas = document.querySelectorAll("#tablaHorariosBody tr");
		var horarios = [];
		
		filas.forEach(function(fila) {
			var celda = fila.querySelectorAll("td");
			var dia = celda[0].textContent;
			var horarioDesde = celda[1].textContent;
			var horarioHasta = celda[2].textContent;
			var checkbox = celda[3].querySelector("input[type='checkbox']");
			var estado = checkbox.checked;
			
			horarios.push({
				dia: dia,
				horarioDesde: horarioDesde,
				horarioHasta: horarioHasta,
				estado: estado
			});
		});
		
		// Actualizar los valores en un campo oculto
		var datosHorarios = document.getElementById("datosHorarios");
		datosHorarios.value = JSON.stringify(horarios);
	}

	// VALIDAR QUE SEAN LETRAS
	function validarLetras(input) {
	  	var regex = /[^a-zA-Z]/g;
	  	input.value = input.value.replace(regex, '');
	}
	
	// ABRIR MODAL
	function openModal(modal, row) {
		document.getElementById(modal).style.display = "block";
		var cName = modal === 'modalMedico' ? 'M' : 'H';
		var isEdit = row !== undefined;
		
	 	if (isEdit) {
	        hideElements(true, cName);
	        chargeEditMedico(row);
		} 
    	else {
    		hideElements(false, cName);
    	}
	}
	
	// CARGAR EDICION DE MEDICO POR FILA
	function chargeEditMedico(row) {
		var cells = row.cells;
		
		document.getElementById('codMed').value = cells[0].querySelector('input[name="CodMed"]').value;
   		document.getElementById('txtDNI').value = cells[2].innerText;
   		document.getElementById('txtNombre').value = cells[3].innerText;
   		document.getElementById('txtApellido').value = cells[4].innerText;
   	 	document.getElementById('ddlSexo').value = cells[5].innerText;
   		document.getElementById('txtNacionalidad').value = cells[6].innerText;
   		document.getElementById('txtFechaNacimiento').value = cells[7].innerText;
   		document.getElementById('txtDireccion').value = cells[8].innerText;
   		document.getElementById('ddlProvincia').selectedIndex =  getSelectedIndexByText(ddlProvincia, cells[9].innerText);
   		filtrarLocalidades();
   		document.getElementById('ddlLocalidad').selectedIndex = getSelectedIndexByText(ddlLocalidad, cells[10].innerText);
   		document.getElementById('txtCorreo').value = cells[11].innerText;
   		document.getElementById('txtTelefono').value = cells[12].innerText;
   		document.getElementById('ddlEspecialidad').selectedIndex =  getSelectedIndexByText(ddlEspecialidad, cells[13].innerText);
   	 	var horarios = cells[0].querySelector('#horarios').value;
   		document.getElementById('datosHorarios').value = horarios;
   		document.getElementById('txtUsuario').value = cells[14].innerText;
   		document.getElementById('txtContraseña').value = cells[15].innerText;
   		
   		var isChecked = cells[16].querySelector('input[type="checkbox"]').checked;
	  	var radioButtons = document.querySelectorAll('input[name="rdTipo"]');
	  	isChecked ? radioButtons[1].checked = true : radioButtons[0].checked = true
	  			
   		isChecked = cells[17].querySelector('input[type="checkbox"]').checked;
	  	radioButtons = document.querySelectorAll('input[name="rdEstado"]');
	  	isChecked ? radioButtons[0].checked = true : radioButtons[1].checked = true
    }
	
	function chargeEditHorario(row) {
		var cells = row.cells;
		
		document.querySelector('select[name="ddlDia"]').value = cells[0].innerText;
		document.querySelector('select[name="ddlHorarioDesde"]').value = cells[1].innerText;
		document.querySelector('select[name="ddlHorarioHasta"]').value = cells[2].innerText;
	  			
   		isChecked = cells[3].querySelector('input[type="checkbox"]').checked;
	  	radioButtons = document.querySelectorAll('input[name="rdEstadoHorario"]');
	  	isChecked ? radioButtons[0].checked = true : radioButtons[1].checked = true
    }
	
	// OBTENER SELECCION DE DDL
	function getSelectedIndexByText(selectElement, text) {
	    for (var i = 0; i < selectElement.options.length; i++) {
	        if (selectElement.options[i].text === text) {
	            return i;
	        }
	    }
	    return -1; 
	}
	
	// OCULTAR ELEMENTOS
	function hideElements(isEdit, cName) {
		var createElements = document.querySelectorAll(".create" + cName);
		var editElements = document.querySelectorAll(".edit" + cName);
		
		createElements.forEach(function(element) {
		  element.style.display = isEdit ? "none" : "block";
		});
		
		editElements.forEach(function(element) {
		  element.style.display = isEdit ? "block" : "none";
		});
	}

	// SELECCION DE HORARIO
	function selectHorario(row) {
  		var notSelected = row.classList.contains('selected-row');
  		cleanSelectedRows();
      
    	if (notSelected) {
			ddlDia.disabled = false;
    		cleanFormHorarios();
    		hideElements(false, 'H');
		} 
    	else {
    		ddlDia.disabled = true;
    		row.classList.add('selected-row');
    		chargeEditHorario(row);
        	hideElements(true, 'H');
    	}
    }
	
	// BORRADO DE SELECCIONADA EN TABLA HORARIOS
	function cleanSelectedRows(){
		var selectedRows = document.getElementsByClassName('selected-row');
	      
      	for (var i = 0; i < selectedRows.length; i++) {
        	selectedRows[i].classList.remove('selected-row');
      	}
	}
	
	// LIMPIEZA DEFAULT A FORM DE HORARIOS AL AGREGAR O CERRAR
	function cleanFormHorarios(){
		botonAgregar.textContent = "Agregar";
		ddlDia.disabled = false;
		document.getElementById('ddlDia').selectedIndex = 0;
		document.getElementById('ddlHorarioDesde').selectedIndex = 0;
		document.getElementById('ddlHorarioHasta').selectedIndex = 0;
	}
	
	// CERRAR MODAL
	function closeModal(modal, isHorarios) {
		document.getElementById(modal).style.display = "none";
    	
    	if(isHorarios){
    		cleanSelectedRows();
    		cleanFormHorarios();
    	}
    	else{
    		document.getElementsByName('txtDNI')[0].value = "";
    		document.getElementsByName('txtNombre')[0].value = "";
    		document.getElementsByName('txtApellido')[0].value = "";
    		document.getElementsByName('ddlSexo')[0].selectedIndex = 0;
    		document.getElementsByName('txtNacionalidad')[0].value = "";
    		document.getElementsByName('txtFechaNacimiento')[0].value = "";
    		document.getElementsByName('txtDireccion')[0].value = "";
    		document.getElementsByName('ddlProvincia')[0].selectedIndex = 0;
    		filtrarLocalidades();
    		document.getElementsByName('ddlLocalidad')[0].selectedIndex = 0;
    		document.getElementsByName('txtCorreo')[0].value = "";
    		document.getElementsByName('txtTelefono')[0].value = "";
    		document.getElementsByName('ddlEspecialidad')[0].selectedIndex = 0;
    		document.getElementsByName('txtUsuario')[0].value = "";
    		document.getElementsByName('txtContraseña')[0].value = "";
    		document.getElementById("datosHorarios").value = "";
    	}
    }
      
	// TABLA MEDICOS
  	$(document).ready(function() {     		
	    var table = $('#table_id_medicos').DataTable({
	        language: {
	            processing: "Tratamiento en curso...",
	            infoEmpty: "No existen datos.",
	            infoPostFix: "",
	            loadingRecords: "Cargando...",
	            zeroRecords: "No se encontraron datos con tu búsqueda",
	            emptyTable: "No hay datos disponibles en la tabla.",
	            paginate: {
	                first: "Primero",
	                previous: "Anterior",
	                next: "Siguiente",
	                last: "Último"
	            },
	            aria: {
	                sortAscending: ": activar para ordenar la columna en orden ascendente",
	                sortDescending: ": activar para ordenar la columna en orden descendente"
	            }
	        },
	        scrollY: "auto",
	        scrollX: true,
	        lengthMenu: [[5, 25, -1], [10, 25, "Todos"]],
	        "bLengthChange": false,
	        "bInfo": false,
	        dom: 'lrtip', 
	        initComplete: function(settings, json) {
	            $('.dataTables_filter').hide();
	        }
	    });

	    $('#search-input').on('input', function() {
	        var searchValue = $(this).val();

	        table.search(searchValue).draw();
	    });	 	
        filtrarLocalidades();
	});
  	
  	// DESHABILITACION DE BOTON FILTRAR
	document.addEventListener('DOMContentLoaded', function() {
        var txtFiltro = document.getElementById('txtFiltro');
        var btnFiltrar = document.getElementById('btnFiltrar');

        function toggleFiltrarButton() {
            if (txtFiltro.value.trim() === '') {
                btnFiltrar.disabled = true;
            } else {
                btnFiltrar.disabled = false;
            }
        }

        txtFiltro.addEventListener('input', toggleFiltrarButton);
        toggleFiltrarButton();
    });
	
	// FILTRADO DE LOCALIDADES
  	var localidades = document.querySelectorAll('#ddlLocalidad option');
	function filtrarLocalidades() {
		var provinciaSeleccionada = document.getElementById('ddlProvincia').value;
		var ddlLocalidad = document.getElementById('ddlLocalidad');
		
		ddlLocalidad.innerHTML = '';
		for (var i = 0; i < localidades.length; i++) {
			var option = localidades[i];
			var codProvincia = option.getAttribute('data-provincia-id');
			
			if (codProvincia === provinciaSeleccionada) {
		  		ddlLocalidad.appendChild(option.cloneNode(true));
			}
		}
	}

	// CREACION DE HORAS DDL HORARIOS
    var selectDesde = document.getElementById("ddlHorarioDesde");
    var selectHasta = document.getElementById("ddlHorarioHasta");
    
    for (var i = 8; i <= 22; i++) {
        var hour = i.toString().padStart(2, "0") + ":00";
        
        var optionDesde = document.createElement("option");
        optionDesde.text = hour;
        optionDesde.value = hour;
        selectDesde.add(optionDesde);
        
        var optionHasta = document.createElement("option");
        optionHasta.text = hour;
        optionHasta.value = hour;
        selectHasta.add(optionHasta);
    }
    
</script>
    
</body>
</html>
