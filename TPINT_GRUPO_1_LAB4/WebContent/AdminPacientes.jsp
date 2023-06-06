<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>AdminPacientes</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-0evHe/X+R7YkIZDRvuzKMRqM+OrBnVFBL6DOitfPri4tjfHxaWutUpFmBp4vmVor" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-pprn3073KE6tl6bjs2QrFaJGz5/SUsLqktiwsUTF55Jfv3qYSDhgCecCxMW52nD2" crossorigin="anonymous"></script>
<link rel="stylesheet" type="text/css"
	href="https://cdn.datatables.net/1.10.19/css/jquery.dataTables.css">
<script type="text/javascript" charset="utf8"
	src="https://cdn.datatables.net/1.10.19/js/jquery.dataTables.js"></script>
<style>
        .modal {
            display: none;
            position: fixed;
            z-index: 1;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgba(0, 0, 0, 0.4);
        }
        
        .modal-content {
            background-color: #fefefe;
            margin: 10% auto;
            padding: 20px;
            border: 1px solid #888;
            max-width: 80%;
        }
        
        .close {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
        }
        
        .close:hover,
        .close:focus {
            color: black;
            text-decoration: none;
            cursor: pointer;
        }
</style>
<%@ page import="java.util.List" %>
<%@ page import="entidades.Paciente" %>
</head>

<body>
	<%@ include file="/MasterPage.jsp" %>
	<h1 class="text-center">Administración de pacientes</h1>
	
	<div class="row m-4">
		<div class="col-4">
			<input class="form-control" name="txtFiltro"> 
		</div>
		<div class="col-4"> 
			<select class="form-control" name="ddlFiltros"> </select>
		</div>
		<div class="col-4"> 
			<button  class="form-control" name="btnFiltrar">Filtrar</button>
		</div>
	</div>
	
	<div class="row m-4">
		<div class="col-4 m-auto">
			<button class="form-control" onclick="openModal('modalPaciente')">Crear Paciente</button>
		</div>
	</div>
	
	<div class="container-fluid" style="width:95%; margin-bottom:20px">
		<div class="card text-center" style="box-shadow: rgba(0, 0, 0, 0.24) 0px 3px 100px;">
			<div class="card-header "><h5>Pacientes</h5></div>
			<table class="table table-hover" id="table_id_usuarios" style="font-size: 11px;">
				<thead>
					<tr>
						<th> </th> 
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
				            <td scope="row">
				                <button type="submit" name="idPaciente" value="<%= paciente.getCodPac() %>" class="btn btn-outline-danger btn-sm" onclick="return confirm('¿Estás paciente de que quieres eliminar al paciente?')">
				                    <i class="fa-solid fa-trash"></i>
				                </button>
				            </td>
					        <td><%= paciente.getDNI() %></td>
					        <td><%= paciente.getNombre() %></td>
					        <td><%= paciente.getApellido()%></td>
					        <td><%= paciente.getSexo() %></td>
					        <td><%= paciente.getNacionalidad() %></td>
					        <td><%= paciente.getFechaNacimiento() %></td>
					        <td><%= paciente.getDireccion() %></td>
					        <td><%= paciente.getProvincia().toString() %></td>
					        <td><%= paciente.getLocalidad().toString() %></td>
					        <td><%= paciente.getCorreo() %></td>
					        <td><%= paciente.getTelefono() %></td>
					        <td><%= paciente.getEstado() %></td>
				    </tr>
					<% 
			        	} 
				    }
					%>
		    	</tbody>                                             
			</table>
		</div>
	</div>
      
	<div id="modalPaciente" class="modal">
   		<div class="modal-content">
        	<span class="close" onclick="closeModal('modalPaciente')" >&times;</span>
        	<div class="d-flex align-items-center justify-content-center">
	        	<div class="col-6">
					<div class="row m-2">
			        	<div class="col-4">
					     	<label class="form-label">DNI</label>   	
			                <input class="form-control" type="number"  min="0" name="txtDNI" required>
			            </div>
			            
			            <div class="col-4">
				     		<label class="form-label">Nombre</label> 
			                <input class="form-control" name="txtNombre" oninput="validarLetras(this)" required>
			            </div>
			            
			            <div class="col-4">
				     		<label class="form-label">Apellido</label>
			                <input class="form-control" name="txtApellido" oninput="validarLetras(this)" required>
			            </div>
					</div>
			        
			        <div class="row m-2">
			        	<div class="col-4">
			        	<label class="form-label">Sexo</label>
			        		<select class="form-control" name="txtSexo">
			        			<option>Masculino</option>
			        			<option>Femenino</option>
			        			<option>Otro</option>
			        		</select> 
			        	</div>
			        	
			        	<div class="col-4">
			        		<label class="form-label">Nacionalidad</label> 
			        		<input class="form-control" name="txtNacionalidad" oninput="validarLetras(this)" required> 
			        	</div>
			        	<div class="col-4"> 
			        		<label class="form-label">Fecha de nacimiento</label>
				        	<input class="form-control" type="date" name="txtFechaNacimiento" required>
			        	
			        	</div>
			        </div>
			        
			        <div class="row m-2">
			        	<div class="col-4">
				        	<label class="form-label">Dirección</label>
							<input class="form-control" name="txtDireccion" required>
			        	</div>
			        	
			        	<div class="col-4">
			        		<label class="form-label">Provincia</label> 
			        		<select class="form-control" name="ddlProvincia" id="ddlProvincia"></select> 
			        	</div>
			        	<div class="col-4"> 
			        		<label class="form-label">Localidad</label>
				        	<select class="form-control" name="ddlLocalidad" id="ddlLocalidad"></select> 	
			        	</div>
			        </div>
			        
			        <div class="row m-2">
			        	<div class="col-6">
			        		<label class="form-label">Correo</label>
			        		<input class="form-control" type="email" name="txtCorreo" required>
			        	</div>
			        	
			        	<div class="col-6">
			        		<label class="form-label">Telefono</label> 
			        		<input class="form-control" type="number"  min="0" name="txtTelefono" required> 
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
				        	<button class="form-control" type="submit" style="margin-top:10px">Crear Paciente</button>
			        	</div>
			        </div>
			        
			        <div class="row m-2 edit">
			        	<div class="col-12">
				        	<button class="form-control" type="submit" style="margin-top:10px">Editar Paciente</button>
			        	</div>
			        </div>
				</div>
			</div>
		</div>
	</div>
      
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
    	
   		document.getElementsByName('txtDNI')[0].selectedIndex = 0;
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
    }
	
</script>
    
</body>
</html>
