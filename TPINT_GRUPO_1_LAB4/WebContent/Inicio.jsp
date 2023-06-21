<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.List" %>
<%@ page import="entidades.Turno" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Map" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Inicio</title>
 
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





</head>
<body>
<%@ include file="/MasterPage.jsp" %>
<h1 class="text-center">Administración de Turnos</h1>

<form method="post" action="servletTurnos">
	<div class="row m-4">
			<div class="col-4">
				<input class="form-control" name="txtFiltro"> 
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
		<div class="col-4"> 
			<button  class="form-control" name="btnFiltrar">Filtrar</button>
		</div>
	</div>
</form>

	<div class="container-fluid" style="width:95%; margin-bottom:20px">
		<div class="card text-center" style="box-shadow: rgba(0, 0, 0, 0.24) 0px 3px 100px;">
			<div class="card-header "><h5>Turnos</h5></div>		
			<table class="table table-hover" id="table_id_turnos" style="font-size: 11px;">
				<thead>
					<tr>
						<th> </th> 
						<th>Médico</th>   
						<th>Paciente</th> 
						<th>Turno</th>
						<th>Estado</th>
					</tr>
				</thead>
		        <tbody>
                	<% 
				    if (request.getAttribute("listaTurnos") instanceof List) {
				        List<Turno> listaTurnos = (List<Turno>) request.getAttribute("listaTurnos");
				        SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
				        for (Turno turno : listaTurnos) { 
				        
					%>									 
					<tr onclick="openModal('modalDatosPaciente')">
						<td scope="row">
							<button name = "btnCambiarEstado" class="btn btn-outline-danger btn-sm"  onclick="event.stopPropagation(); openModal('modalCambiarEstado')">
								<i class="fa-solid fa-clock"></i>
							</button>
						</td>
					        <td><%= turno.getMedico().getNombre() + " " + turno.getMedico().getApellido()%></td>
					        <td><%= turno.getPaciente().getNombre() + " " + turno.getPaciente().getApellido()%></td>
					        <td><%= formatter.format(turno.getFechaTurno())%></td>
					        <td><%= turno.getEstado().getDescripcion_EST()%></td>
				    
		         	</tr>
					<% 
			        	} 
				    }
					%>
	                	
		         	
		    	</tbody>                                             
			</table>
		</div>
	</div>     
     <div id="modalDatosPaciente" class="modal">
   		<div class="modal-content">
        	<span class="close" onclick="closeModal('modalDatosPaciente')" >&times;</span>
        	<div class="d-flex align-items-center justify-content-center">
	        	<div class="col-6">
					<div class="row m-2">
			        	<div class="col-4">
					     	<label class="form-label">DNI</label>   	
			                <input class="form-control" type="number"  min="0" name="txtDNI" disabled required>
			            </div>
			            
			            <div class="col-4">
				     		<label class="form-label">Nombre</label> 
			                <input class="form-control" name="txtNombre" disabled oninput="validarLetras(this)" required>
			            </div>
			            
			            <div class="col-4">
				     		<label class="form-label">Apellido</label>
			                <input class="form-control" name="txtApellido" disabled oninput="validarLetras(this)" required>
			            </div>
					</div>
			        
			        <div class="row m-2">
			        	<div class="col-4">
			        	<label class="form-label">Sexo</label>
			        		<select class="form-control" disabled name="txtSexo">
			        			<option>Masculino</option>
			        			<option>Femenino</option>
			        			<option>Otro</option>
			        		</select> 
			        	</div>
			        	
			        	<div class="col-4">
			        		<label class="form-label">Nacionalidad</label> 
			        		<input class="form-control" name="txtNacionalidad" disabled oninput="validarLetras(this)" required> 
			        	</div>
			        	<div class="col-4"> 
			        		<label class="form-label">Fecha de nacimiento</label>
				        	<input class="form-control" type="date" name="txtFechaNacimiento" disabled required>
			        	
			        	</div>
			        </div>
			        
			        <div class="row m-2">
			        	<div class="col-4">
				        	<label class="form-label">Dirección</label>
							<input class="form-control" disabled name="txtDireccion" required>
			        	</div>
			        	
			        	<div class="col-4">
			        		<label class="form-label">Provincia</label> 
			        		<select class="form-control" disabled name="ddlProvincia">
			        			
			        		</select> 
			        	</div>
			        	<div class="col-4"> 
			        		<label class="form-label">Localidad</label>
				        	<select class="form-control" disabled  name="ddlLocalidad">
			        			
			        		</select> 	
			        	</div>
			        </div>
			        
			        <div class="row m-2">
			        	<div class="col-6">
			        		<label class="form-label">Correo</label>
			        		<input class="form-control" type="email" name="txtCorreo" disabled required>
			        	</div>
			        	
			        	<div class="col-6">
			        		<label class="form-label">Telefono</label> 
			        		<input class="form-control" type="number"  min="0" name="txtTelefono" disabled required> 
			        	</div>					
			        </div>			        			   	       
				</div>
			</div>
		</div>
	</div>
	
	 <div id="modalCambiarEstado" class="modal">
   		<div class="modal-content">
        	<span class="close" onclick="closeModal('modalCambiarEstado')" >&times;</span>
        	<div class="d-flex align-items-center justify-content-center">
	        	<div class="col-6">
					<div class="row">
			        	<div class="col-6">
					     	<label class="form-label">Estados</label>   	
			                <select class="form-control" name="ddlEstados" required> </select>
			            </div>
			            
			            <div class="col-6">
							<button  class="form-control" name="btnCambiarEstado" style="margin-top:32px">Cambiar Estado</button>
			            </div>			          
					</div>      			   	       
				</div>
			</div>
		</div>
	</div>
	
	<script>
	$('#table_id_turnos').DataTable({
	    language: {
	        processing: "Tratamiento en curso...",
	        search: "Buscar&nbsp;:",
	        infoEmpty: "No existen datos.",
	        infoPostFix: "",
	        loadingRecords: "Cargando...",
	        zeroRecords: "No se encontraron datos con tu busqueda",
	        emptyTable: "No hay datos disponibles en la tabla.",
	        paginate: {
	            first: "Primero",
	            previous: "Anterior",
	            next: "Siguiente",
	            last: "Ultimo"
	        },
	        aria: {
	            sortAscending: ": active para ordenar la columna en orden ascendente",
	            sortDescending: ": active para ordenar la columna en orden descendente"
	        }
	    },
	    scrollY: "auto",
	    lengthMenu: [ [5, 25, -1], [10, 25, "All"] ],
	    "bLengthChange" : false,
	    "bInfo": false
	});
	
	function validarLetras(input) {
	  	var regex = /[^a-zA-Z]/g;
	  	input.value = input.value.replace(regex, '');
	}
	
	function openModal(modal) {
		document.getElementById(modal).style.display = "block";
	}

    function closeModal(modal) {
    	document.getElementById(modal).style.display = "none";
    }
</script>

</body>
</html>