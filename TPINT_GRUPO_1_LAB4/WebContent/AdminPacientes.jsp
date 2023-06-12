<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>AdminPacientes</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-0evHe/X+R7YkIZDRvuzKMRqM+OrBnVFBL6DOitfPri4tjfHxaWutUpFmBp4vmVor" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-pprn3073KE6tl6bjs2QrFaJGz5/SUsLqktiwsUTF55Jfv3qYSDhgCecCxMW52nD2" crossorigin="anonymous"></script>
<link rel="stylesheet" type="text/css" href="./src/Style/estilos.css">
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="entidades.Paciente" %>
<%@ page import="entidades.Provincia" %>
<%@ page import="entidades.Localidad" %>
</head>


<body>
	<%@ include file="/MasterPage.jsp" %>
	
	<h1 class="text-center">Administración de pacientes</h1>

	<div class="row m-4">
		<div class="col-4 m-auto">
			<button class="form-control" onclick="openModal('modalPaciente')">Crear Paciente</button>
		</div>
	</div>
	
	<form method="post" action="servletPacientes">
		<div class="row m-4">
			<div class="col-4">
				<input class="form-control" name="txtFiltro" id="txtFiltro" placeholder="Ingrese para filtrar"> 
			</div>
			<div class="col-4"> 
			    <select class="form-control" name="ddlFiltros">
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
				<button  class="form-control" name="btnLimpiarFiltros" id="btnLimpiarFiltros">Limpiar Filtro</button>
			</div>
		</div>
	</form>
	
	<div class="input-group col-6 m-auto">
  		<input type="search" class="form-control rounded" placeholder="Buscar en la grilla" aria-label="Search" id="search-input" aria-describedby="search-addon" />
	</div>
	
	<div class="container-fluid mt-5" style="width:95%; margin-bottom:20px">
		<div class="card text-center" style="box-shadow: rgba(0, 0, 0, 0.24) 0px 3px 100px;">
			<div class="card-header "><h5>Pacientes</h5></div>
			<table class="table table-hover text-center" id="table_id_usuarios" style="font-size: 11px;">
				<thead>
					<tr class="center-header">
						<th></th> 
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
				        <th>Estado</th>
					</tr>
				</thead>
		        <tbody>
		        	<% 
				    if (request.getAttribute("listaPacientes") instanceof List) {
				        List<Paciente> listaPacientes = (List<Paciente>) request.getAttribute("listaPacientes");
				        for (Paciente paciente : listaPacientes) { 
					%>
				    <tr onclick="openModal('modalPaciente', true)">
				    		
				    		<% SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy"); %>
				    	
				            <td scope="row">
				                <button style="position:relative;" type="submit" name="idPaciente" value="<%= paciente.getCodPac() %>" class="btn btn-outline-danger btn-sm" onclick="return confirm('¿Estás paciente de que quieres eliminar al paciente?')">
				                    <i class="fa-solid fa-trash"></i>
				                </button>
				            </td>
					        <td><%= paciente.getDNI() %></td>
					        <td><%= paciente.getNombre() %></td>
					        <td><%= paciente.getApellido()%></td>
					        <td><%= paciente.getSexo() %></td>
					        <td><%= paciente.getNacionalidad() %></td>
							<td><%= formatter.format(paciente.getFechaNacimiento()) %></td>
					        <td><%= paciente.getDireccion() %></td>
					        <td><%= paciente.getProvincia() %></td>
					        <td><%= paciente.getLocalidad() %></td>
					        <td><%= paciente.getCorreo() %></td>
					        <td><%= paciente.getTelefono() %></td>
					        <td>
						        <label class="checkbox-label">
						            <input type="checkbox" <%= paciente.getEstado() ? "checked" : "" %> disabled>
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
      
    <form method="post" action="servletPacientes">
		<div id="modalPaciente" class="modal">
	   		<div class="modal-content">
	        	<span class="close" onclick="closeModal('modalPaciente')" >&times;</span>
	        	<div class="d-flex align-items-center justify-content-center">
		        	<div class="col-12">
						<div class="row m-2">
				        	<div class="col-4">
							    <label class="form-label">DNI</label>
							    <input class="form-control" type="number" min="0" name="txtDNI" id="txtDNI" required>
							</div>
							
							<div class="col-4">
							    <label class="form-label">Nombre</label>
							    <input class="form-control" name="txtNombre" id="txtNombre" oninput="validarLetras(this)" required>
							</div>
							
							<div class="col-4">
							    <label class="form-label">Apellido</label>
							    <input class="form-control" name="txtApellido" id="txtApellido" oninput="validarLetras(this)" required>
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
				        	<div class="col-6">
				        		<label class="form-label">Correo</label>
				        		<input class="form-control" type="email" name="txtCorreo" id="txtCorreo" required>
				        	</div>
				        	
				        	<div class="col-6">
				        		<label class="form-label">Telefono</label> 
				        		<input class="form-control" type="number"  min="0" name="txtTelefono" id="txtTelefono" required> 
				        	</div>					
				        </div>
				        
				       <div class="row m-2">
				        	<div class="col-6 edit">
				        		<label class="form-label">Activo</label>
					        	<input class="form-check-input" style="margin-left:20px" type="radio" name="rdEstado" value="1" checked>
				        	</div>
				        	<div class="col-6 edit">
				        		<label class="form-label">Inactivo</label>
				        		<input class="form-check-input" style="margin-left:20px" type="radio" name="rdEstado" value="0">
				        	</div>
				        </div>
				        
				        <div class="row m-2 create">
				        	<div class="col-12">
					        	<button class="form-control" type="submit" name="btnCrearPaciente" style="margin-top:10px"> Crear Paciente </button>
				        	</div>
				        </div>
				        
				        <div class="row m-2 edit">
				        	<div class="col-12">
					        	<button class="form-control" type="submit" name="btnEditarPaciente" style="margin-top:10px"> Editar Paciente </button>
				        	</div>
				        </div>
					</div>
				</div>
			</div>
		</div>
	</form>
      
<script>
	function validarLetras(input) {
	  	var regex = /[^a-zA-Z]/g;
	  	input.value = input.value.replace(regex, '');
	}
	
	function openModal(modal, isEdit) {
		document.getElementById(modal).style.display = "block";
		
	 	if (isEdit) {
	        hideElements(true);
		} 
    	else {
    		hideElements(false);
    	}
	}
	
	function hideElements(isEdit) {
		var createElements = document.querySelectorAll(".create");
		var editElements = document.querySelectorAll(".edit");
		
		createElements.forEach(function(element) {
		  element.style.display = isEdit ? "none" : "block";
		});
		
		editElements.forEach(function(element) {
		  element.style.display = isEdit ? "block" : "none";
		});
	}
	
	function closeModal(modal) {
		document.getElementById(modal).style.display = "none";
    	
   		document.getElementById('txtDNI').value = "";
   		document.getElementById('txtNombre').value = "";
   		document.getElementById('txtApellido').value = "";
   		document.getElementById('ddlSexo').selectedIndex = 0;
   		document.getElementById('txtNacionalidad').value = "";
   		document.getElementById('txtFechaNacimiento').value = "";
   		document.getElementById('txtDireccion').value = "";
   		document.getElementById('ddlProvincia').selectedIndex = 0;
   		document.getElementById('ddlLocalidad').selectedIndex = 0;
   		document.getElementById('txtCorreo').value = "";
   		document.getElementById('txtTelefono').value = "";
		document.querySelector('input[name="rdEstado"][value="1"]').checked = true;
    }
	
	$(document).ready(function() {
	    var table = $('#table_id_usuarios').DataTable({
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
	
	
	$(document).ready(function () {
  		filtrarLocalidades();            
	});
	
	var localidades = ddlLocalidad.options;
	function filtrarLocalidades() {
		  var provinciaSeleccionada = document.getElementById('ddlProvincia').value;
		  var ddlLocalidad = document.getElementById('ddlLocalidad');
		  var opcionesFiltradas = [];

		  for (var i = 0; i < localidades.length; i++) {
		    var option = localidades[i];
		    var codProvincia = option.getAttribute('data-provincia-id');

		    if (codProvincia === provinciaSeleccionada) {
		      opcionesFiltradas.push(option.outerHTML);
		    }
		  }

		  // Crear un nuevo elemento select
		  var nuevoSelect = document.createElement('select');
		  nuevoSelect.innerHTML = opcionesFiltradas.join('');
		  nuevoSelect.id = 'ddlLocalidad';
		  nuevoSelect.className = "form-control";

		  // Reemplazar el elemento select existente con el nuevo
		  ddlLocalidad.parentNode.replaceChild(nuevoSelect, ddlLocalidad);
	}

</script>
    
</body>
</html>
