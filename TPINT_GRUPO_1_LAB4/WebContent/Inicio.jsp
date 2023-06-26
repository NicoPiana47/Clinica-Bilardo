<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.List" %>
<%@ page import="entidades.Turno" %>
<%@ page import="entidades.Paciente" %>
<%@ page import="entidades.EstadoTurno" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.stream.Collectors" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Inicio</title>
<link rel="stylesheet" type="text/css" href="./src/Style/estilos.css">
</head>
<body>
<%@ include file="/MasterPage.jsp" %>
<h1 class="text-center">Administración de Turnos</h1>

	<form method="post" action="servletTurnos">
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
				<button  class="form-control" name="btnLimpiarFiltros" id="btnLimpiarFiltros">Limpiar Filtro</button>
			</div>
		</div>
	</form>
	
	<div class="input-group col-6 m-auto">
  		<input type="search" class="form-control rounded" placeholder="Buscar en la grilla" aria-label="Search" id="search-input" aria-describedby="search-addon" />
	</div>	

	<div class="container-fluid mt-4" style="width:95%; margin-bottom:20px">
		<div class="card text-center" style="box-shadow: rgba(0, 0, 0, 0.24) 0px 3px 100px;">
			<div class="card-header "><h5>Turnos</h5></div>		
			<table class="table table-hover" id="table_id_turnos" style="width: 100%; font-size: 11px;">
				<thead>
					<tr class="center-header">
						<th> </th>  
						<th>Paciente</th> 
						<th>Turno</th>
						<th>Estado</th>
					</tr>
				</thead>
		        <tbody id="table_body_turnos">
                	<% 
				    if (request.getAttribute("listaTurnos") instanceof List) {
				        List<Turno> listaTurnos = (List<Turno>) request.getAttribute("listaTurnos");
				        SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
				        for (Turno turno : listaTurnos) { 
					%>									 
					<tr onclick="setCodPac(this); openModal('modalDatosPaciente', this)" data-codpac="<%= turno.getPaciente().getCodPac() %>">
						
						<td scope="row">
							<button name="btnAbrirEstados" id="btnAbrirEstados" class="btn btn-outline-danger btn-sm" 
									onclick="event.stopPropagation(); openModal('modalCambiarEstado'); setCodTurno(this)"
									data-codturno="<%= turno.getCodTurno() %>">
								<i class="fa-solid fa-clock"></i>
							</button>
						</td>
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
			                <input class="form-control" type="number"  min="0" name="txtDNI" id= "txtDNI" disabled required>
			            </div>
			            
			            <div class="col-4">
				     		<label class="form-label">Nombre</label> 
			                <input class="form-control" name="txtNombre" id="txtNombre" disabled oninput="validarLetras(this)" required>
			            </div>
			            
			            <div class="col-4">
				     		<label class="form-label">Apellido</label>
			                <input class="form-control" name="txtApellido" id="txtApellido" disabled oninput="validarLetras(this)" required>
			            </div>
					</div>
			        
			        <div class="row m-2">
			        	<div class="col-4">
			        	<label class="form-label">Sexo</label>
			        		<select class="form-control" disabled name="txtSexo" id="ddlSexo">
			        			<option>Masculino</option>
			        			<option>Femenino</option>
			        			<option>Otro</option>
			        		</select> 
			        	</div>
			        	
			        	<div class="col-4">
			        		<label class="form-label">Nacionalidad</label> 
			        		<input class="form-control" name="txtNacionalidad" id="txtNacionalidad" disabled oninput="validarLetras(this)" required> 
			        	</div>
			        	<div class="col-4"> 
			        		<label class="form-label">Fecha de nacimiento</label>
				        	<input class="form-control" type="date" name="txtFechaNacimiento" id="txtFechaNacimiento" disabled required>
			        	
			        	</div>
			        </div>
			        
			        <div class="row m-2">
			        	<div class="col-4">
				        	<label class="form-label">Dirección</label>
							<input class="form-control" disabled name="txtDireccion" id="txtDireccion" required>
			        	</div>
			        	
			        	<div class="col-4">
			        		<label class="form-label">Provincia</label> 
			        		<select class="form-control" disabled name="ddlProvincia" id="ddlProvincia">
			        			
			        		</select> 
			        	</div>
			        	<div class="col-4"> 
			        		<label class="form-label">Localidad</label>
				        	<select class="form-control" disabled  name="ddlLocalidad" id="ddlLocalidad">
			        			
			        		</select> 	
			        	</div>
			        </div>
			        
			        <div class="row m-2">
			        	<div class="col-6">
			        		<label class="form-label">Correo</label>
			        		<input class="form-control" type="email" name="txtCorreo" id="txtCorreo" disabled required>
			        	</div>
			        	
			        	<div class="col-6">
			        		<label class="form-label">Telefono</label> 
			        		<input class="form-control" type="number"  min="0" name="txtTelefono" id="txtTelefono" disabled required> 
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
			                <select class="form-control" name="ddlEstados" id="ddlEstados"required> 
			                <% 
					        if (request.getAttribute("listaEstados") instanceof List) {
					            List<EstadoTurno> listaEstados = (List<EstadoTurno>) request.getAttribute("listaEstados");
					            for (EstadoTurno estado : listaEstados) { 
					        %>
					            <option value="<%= estado.getCodEstado_EST() %>"><%= estado.getDescripcion_EST() %></option>				
					        <% 
					            } 
					        }
					        %>
			                </select>
			            </div>
			            
			            <div class="col-6">
							<button  class="form-control" name="btnCambiarEstado" id="btnCambiarEstado" style="margin-top:32px">Cambiar Estado</button>
			            </div>			          
					</div>      			   	       
				</div>
			</div>
		</div>
	</div>        
	
<script>
	var codTurno = null;
	var codPac = null;

	function setCodTurno(button) {
		codTurno = button.getAttribute("data-codturno");
	}
	
	function setCodPac(tr) {
		codPac = tr.getAttribute("data-codpac");
	}

	document.getElementById("btnCambiarEstado").addEventListener('click', function() {
		if (codTurno) {
		    var estado = document.getElementById("ddlEstados").value;
		    $.ajax({
		        url: "servletTurnos",
		        method: "POST",
		        data: { estado: estado, codTurnoAjax: codTurno}
		    }).then(function(response) {
		        if (response === "true") {
		        	Notiflix.Notify.success("Se cambió el estado con éxito!");
		        	document.getElementById("btnLimpiarFiltros").click();
		        }
		        else Notiflix.Notify.failure("No se pudo cambiar el estado");
		    });
		}
	});
	
	function validarLetras(input) {
	  	var regex = /[^a-zA-Z]/g;
	  	input.value = input.value.replace(regex, '');
	}
	
	function openModal(modal, row) {
		document.getElementById(modal).style.display = "block";
		
		var isEdit = row !== undefined;
		
	 	if (isEdit) {
	        chargeRow(row);
		} 
	}
	
	function chargeRow(row) {
		var cells = row.cells;
	
	    var xhr = new XMLHttpRequest();
	    xhr.open("GET", "servletTurnos?codPac=" + codPac, true);
	    xhr.onreadystatechange = function() {
	        if (xhr.readyState === 4 && xhr.status === 200) {
	            var pacientesFiltrados = JSON.parse(xhr.responseText);

	            document.getElementById('txtDNI').value = pacientesFiltrados[0].DNI;
	            document.getElementById('txtNombre').value = pacientesFiltrados[0].nombre;	          
	       		document.getElementById('txtApellido').value = pacientesFiltrados[0].apellido;	
	       	 	document.getElementById('ddlSexo').value = pacientesFiltrados[0].sexo;	
	       		document.getElementById('txtNacionalidad').value = pacientesFiltrados[0].nacionalidad;
	       		var fechaObj = new Date(pacientesFiltrados[0].fechaNacimiento);
	       		var dia = fechaObj.getDate();
	       		var mes = fechaObj.getMonth() + 1;
	       		var anio = fechaObj.getFullYear();

	       		dia = (dia < 10) ? '0' + dia : dia;
	       		mes = (mes < 10) ? '0' + mes : mes;
	       		
	       		document.getElementById('txtFechaNacimiento').value = anio + '-' + mes + '-' + dia;
	       		document.getElementById('txtDireccion').value = pacientesFiltrados[0].direccion;
	       		
	       		var optionProv = document.createElement('option');
	       		optionProv.text = pacientesFiltrados[0].provincia.descripcion;
	       		document.getElementById('ddlProvincia').innerHTML = ''; 
	       		document.getElementById('ddlProvincia').appendChild(optionProv);
	       		
	       	 	var optionLoc = document.createElement('option');
	       		optionLoc.text = pacientesFiltrados[0].localidad.descripcion;
	       		document.getElementById('ddlLocalidad').innerHTML = ''; 
	       		document.getElementById('ddlLocalidad').appendChild(optionLoc);
	       		
	       		document.getElementById('txtCorreo').value = pacientesFiltrados[0].correo;
	       		document.getElementById('txtTelefono').value = pacientesFiltrados[0].telefono;
	        }
	    };
	    xhr.send();
    }

    function closeModal(modal) {
    	document.getElementById(modal).style.display = "none";
    }
    
	$(document).ready(function() {
	    var table = $('#table_id_turnos').DataTable({
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
	        scrollX: true,
	        lengthMenu: [[5, 25, -1], [10, 25, "All"]],
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
	});
	
</script>

</body>
</html>