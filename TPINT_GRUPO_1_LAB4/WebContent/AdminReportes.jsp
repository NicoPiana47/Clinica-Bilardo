<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.util.List" %>
<%@ page import="entidades.Turno" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>AdminReportes</title>
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
	<h1 class="text-center">Reportes</h1>
	<form action="servletTurnos" method="post">
		<div class="row m-4">
			<div class="col-4">
				<input class="form-control" type="date" name="txtFechaDesde"> 
			</div>
			<div class="col-4"> 
				<input class="form-control" type="date" name="txtFechaHasta"> 
			</div>
			<div class="col-4"> 
				<button  class="form-control" name="btnFiltrarFechas">Filtrar</button>
			</div>
		</div>
	</form>
	

	<div class="row"> 
		<div class="col-4 m-auto" > 
			<button class="form-control" name="btnReportes" onclick="openModal('modalReportes')" style="margin-bottom:10px"> Reportes </button>
		</div>
	</div>	

	<div class="container-fluid" style="width:95%; margin-bottom:20px">
		<div class="card" style="box-shadow: rgba(0, 0, 0, 0.24) 0px 3px 100px;">
			<div class="card-header  text-center"><h5>Turnos</h5></div>
			<table class="table table-hover" id="table_id_reportes" style="font-size: 11px;">
				<thead>
					<tr>
						
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
					
					  <tr>

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
	
	<% 
		long cantTurnos = 0;
		String medicoConMasTurnos = "";
	    if (request.getAttribute("cantTurnos") != null &&  request.getAttribute("medicoConMasTurnos") != null) {
				cantTurnos = (long)request.getAttribute("cantTurnos");
				medicoConMasTurnos = (String)request.getAttribute("medicoConMasTurnos");
	    }
				        
	%>
	
	<div id="modalReportes" class="modal">
   		<div class="modal-content">
        	<span class="close" onclick="closeModal('modalReportes')" >&times;</span>
        	<div class="d-flex align-items-center justify-content-center">
				<div class="row m-2">
		        	<div class="col-8">
				     	<label class="form-label">Cantidad de turnos asignados entre las fechas seleccionadas:</label>   	
		            </div>
		            
		            <div class="col-4">
		                <input class="form-control" name="txtTurnosAsignados" value=<%=cantTurnos%> disabled> 
		            </div>
				</div>
				
				<div class="row m-2">
		        	<div class="col-8">
				     	<label class="form-label">Médico con más turnos asignados:</label>   	
		            </div>
		            
		            <div class="col-4">
		                <input class="form-control" name="txtMedicoTurnosAsignados" value= <%=medicoConMasTurnos%> disabled>
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
	    
		$('#table_id_reportes').DataTable({
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
		    "bInfo": false,		    
	    });
	</script>    
</body>
</html>