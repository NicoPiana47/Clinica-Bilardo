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
<link rel="stylesheet" type="text/css" href="./src/Style/estilos.css">
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="entidades.Medico" %>
<%@ page import="entidades.Provincia" %>
<%@ page import="entidades.Localidad" %>
<%@ page import="entidades.Especialidad" %>
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
						<th>Fecha de atención</th>  
						<th>Usuario</th>
						<th>Contraseña</th>
						<th>Tipo</th>
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
							<form method="post" action="servletMedicos">						
								<button type="submit"  name ="btnEliminar" class="btn btn-outline-danger btn-sm" onclick="event.stopPropagation(); return confirm('¿Esta seguro de que quiere eliminar el médico?')">
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
						<td>Ver registro</td>  
						<td><%=medico.getUsername()%></td>
						<td><%=medico.getContraseña()%></td>
						<td>
							<label class="checkbox-label">
					            <input type="checkbox" <%= medico.getTipo() ? "checked" : "" %> disabled>
					            <span class="checkmark"></span>
					        </label></td>
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
				        		<button type="button" class="form-control" onclick="openModal('modalHorarios')">Horarios</button>
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
						        <tbody id="tablaHorariosBody">

						    	</tbody>                                             
							</table>
						</div>
					</div>
					
					<div id="divHorario" class="col-6" style="display: block;">
						<div class="row m-2">
				        	<div class="col-4">
						     	<label class="form-label">Dia</label>   	
				                <select class="form-control" name="ddlDia" required>
				        			<option>Domingo</option>
				        			<option>Lunes</option>
				        			<option>Martes</option>
				        			<option>Miercoles</option>
				        			<option>Jueves</option>
				        			<option>Viernes</option>
				        			<option>Sabado</option>
				        		</select> 
				            </div>
				            
				            <div class="col-4">
					     		<label class="form-label">Horario Desde</label> 
					     		<input type="time" class="form-control form-control-lg" name="txtHorarioDesde" required/>
				            </div>
				            
				            <div class="col-4">
					     		<label class="form-label">Horario Hasta</label>
					     		<input type="time" class="form-control form-control-lg" name="txtHorarioHasta" required/>
				            </div>
						</div>
						
						<div class="row m-2" >
				        	<div class="col-6 editH" style="display: none;">
				        		<label class="form-label">Activo</label>
					        	<input class="form-check-input" style="margin-left:20px" type="radio" name="rdEstado" value="1" checked>
				        	</div>
				        	<div class="col-6 editH" style="display: none;">
				        		<label class="form-label">Inactivo</label>
				        		<input class="form-check-input" style="margin-left:20px" type="radio" name="rdEstado" value="0">
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
	
	<% if((Boolean) request.getAttribute("elimino") != null){
			boolean elimino =(boolean)request.getAttribute("elimino");
			if(elimino == true){
				%><div style="display: flex; justify-content: center; visibility="hidden";>
				        <div ID="MsgSuccesDiv" class="col-md-4 alert alert-success text-center">
				         <i class="bi-check-circle-fill text-center"></i>
				            <strong>Éxito</strong> Médico eliminado!
				            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
				        </div>
				    </div>
			    <% 
			}
			else{
				%><div style="display: flex; justify-content: center; visibility="hidden";>
				        <div ID="MsgErrorDiv" class="col-md-4 alert alert-danger  text-center">
				            <strong>Error</strong> No se pudo eliminar al médico!
				            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
				        </div>
				    </div>
			    <% 
			}
		}
	%>
	
	<%
		if((Boolean)request.getAttribute("CrearMedico") != null){
			boolean crearMedico = (boolean)request.getAttribute("CrearMedico");
			if(crearMedico==true){
	%>  
				<div class="alert alert-success alert-dismissible d-flex align-items-center fade show  m-auto " style="width:50%; margin-bottom:20px">
					<div class="m-auto">
						<i class="bi-check-circle-fill text-center"></i>
						<strong class="mx-2">Éxito!</strong> Médico creado con éxito!
						<button type="button" class="btn-close" data-bs-dismiss="alert"></button>
					</div>			
				</div>      
		<% 
			}    
			else{
				%><div style="display: flex; justify-content: center; visibility="hidden";>
				        <div ID="MsgErrorDiv" class="col-md-4 alert alert-danger  text-center">
				            <strong>Error</strong> No se pudo crear al médico!
				            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
				        </div>
				    </div>
			    <% 
			}
		}                                             	
	%>
	
	<%
		if((Boolean)request.getAttribute("edito") != null){
			boolean edito = (boolean)request.getAttribute("edito");
			if(edito==true){
	%>  
				<div class="alert alert-success alert-dismissible d-flex align-items-center fade show  m-auto " style="width:50%; margin-bottom:20px">
					<div class="m-auto">
						<i class="bi-check-circle-fill text-center"></i>
						<strong class="mx-2">Éxito!</strong> Usuario modificado con éxito!
						<button type="button" class="btn-close" data-bs-dismiss="alert"></button>
					</div>			
				</div>      
		<% 
			}    
			else{
				%><div style="display: flex; justify-content: center; visibility="hidden";>
				        <div ID="MsgErrorDiv" class="col-md-4 alert alert-danger  text-center">
				            <strong>Error</strong> No se pudo modificar al Usuario!
				            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
				        </div>
				    </div>
			    <% 
			}
		}                                             	
	%>
	
	
     	
<script>
	var botonAgregar = document.querySelector('.createH button');
	

	botonAgregar.addEventListener('click', function() {	
		var dia = document.querySelector('select[name="ddlDia"]').value;
		var horarioDesde = document.querySelector('input[name="txtHorarioDesde"]').value;
		var horarioHasta = document.querySelector('input[name="txtHorarioHasta"]').value;
		
		if(dia && horarioDesde && horarioHasta){		
			
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
		    checkbox.checked = true;
		   	celdaEstado.appendChild(checkbox);
		
		    celdaDia.textContent = dia;
		    celdaHorarioDesde.textContent = horarioDesde;
		    celdaHorarioHasta.textContent = horarioHasta;	
		    
		    nuevaFila.appendChild(celdaDia);
		    nuevaFila.appendChild(celdaHorarioDesde);
		    nuevaFila.appendChild(celdaHorarioHasta);
		    nuevaFila.appendChild(celdaEstado);
		
		    var tablaBody = document.getElementById("tablaHorariosBody");
		    tablaBody.appendChild(nuevaFila);

		}
	});

	function validarLetras(input) {
	  	var regex = /[^a-zA-Z]/g;
	  	input.value = input.value.replace(regex, '');
	}
	
	function openModal(modal, row) {
		document.getElementById(modal).style.display = "block";
		var cName = modal === 'modalMedico' ? 'M' : 'H';
		var isEdit = row !== undefined;
		
	 	if (isEdit) {
	        hideElements(true, cName);
	        chargeRow(row);
		} 
    	else {
    		hideElements(false, cName);
    	}
	}
	function chargeRow(row) {
		var cells = row.cells;
		
		document.getElementById('codMed').value = cells[0].querySelector('input[name="CodMed"]').value
   		document.getElementById('txtDNI').value = cells[2].innerText;
   		document.getElementById('txtNombre').value = cells[3].innerText;
   		document.getElementById('txtApellido').value = cells[4].innerText;
   	 	document.getElementById('ddlSexo').value = cells[5].innerText;
   		document.getElementById('txtNacionalidad').value = cells[6].innerText;
   		document.getElementById('txtFechaNacimiento').value = convertDateFormat(cells[7].innerText, "dd/MM/yyyy", "yyyy-MM-dd");
   		document.getElementById('txtDireccion').value = cells[8].innerText;
   		document.getElementById('ddlProvincia').selectedIndex =  getSelectedIndexByText(ddlProvincia, cells[9].innerText);
   		filtrarLocalidades();
   		document.getElementById('ddlLocalidad').selectedIndex = getSelectedIndexByText(ddlLocalidad, cells[10].innerText);
   		document.getElementById('txtCorreo').value = cells[11].innerText;
   		document.getElementById('txtTelefono').value = cells[12].innerText;
   		document.getElementById('ddlEspecialidad').selectedIndex =  getSelectedIndexByText(ddlEspecialidad, cells[13].innerText);
   		document.getElementById('txtUsuario').value = cells[15].innerText;
   		document.getElementById('txtContraseña').value = cells[16].innerText;
   		
   		var isChecked = cells[17].querySelector('input[type="checkbox"]').checked;
	  	var radioButtons = document.querySelectorAll('input[name="rdTipo"]');
	  	isChecked ? radioButtons[1].checked = true : radioButtons[0].checked = true
	  			
	  			
   		  isChecked = cells[18].querySelector('input[type="checkbox"]').checked;
	  	  radioButtons = document.querySelectorAll('input[name="rdEstado"]');
	  	isChecked ? radioButtons[0].checked = true : radioButtons[1].checked = true

   		
	  
    }
	
	function getSelectedIndexByText(selectElement, text) {
	    for (var i = 0; i < selectElement.options.length; i++) {
	        if (selectElement.options[i].text === text) {
	            return i;
	        }
	    }
	    return -1; 
	}
	
	function convertDateFormat(dateString, inputFormat, outputFormat) {
	    var parts = dateString.split("/");
	    var formattedDate = parts[2] + "-" + parts[1] + "-" + parts[0];
	    return formattedDate;
	}
	
	
	
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

	function selectHorario(row) {
  		var isSelected = row.classList.contains('selected-row');
  		selectedRows();
      
    	if (isSelected) {
    		hideElements(false, 'H');
		} 
    	else {
    		row.classList.add('selected-row');
        	hideElements(true, 'H');
    	}
    }
	
	function selectedRows() {
		var selectedRows = document.getElementsByClassName('selected-row');
	      
      	for (var i = 0; i < selectedRows.length; i++) {
        	selectedRows[i].classList.remove('selected-row');
      	}
	}
	
	function closeModal(modal, isHorarios) {
		document.getElementById(modal).style.display = "none";
    	
    	if(isHorarios){
    		selectedRows();
    		document.getElementsByName('ddlDia')[0].selectedIndex = 0;
    		document.getElementsByName('txtHorarioDesde')[0].value = "";
    		document.getElementsByName('txtHorarioHasta')[0].value = "";
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
    		document.getElementsByName('ddlLocalidad')[0].selectedIndex = 0;
    		document.getElementsByName('txtCorreo')[0].value = "";
    		document.getElementsByName('txtTelefono')[0].value = "";
    		document.getElementsByName('ddlEspecialidad')[0].selectedIndex = 0;
    		document.getElementsByName('txtUsuario')[0].value = "";
    		document.getElementsByName('txtContraseña')[0].value = "";
    	}
    }
      
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
	        dom: 'lrtip', // Mostrar solo los componentes necesarios
	        initComplete: function(settings, json) {
	            // Ocultar el campo de búsqueda predeterminado
	            $('.dataTables_filter').hide();
	        }
	    });

	 	// Agregar evento de cambio al campo de búsqueda
	    $('#search-input').on('input', function() {
	        var searchValue = $(this).val();

	        // Aplicar el filtro de búsqueda al DataTable
	        table.search(searchValue).draw();
	    });	 	
        filtrarLocalidades();
	});
  	
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

  
</script>
    
</body>
</html>
