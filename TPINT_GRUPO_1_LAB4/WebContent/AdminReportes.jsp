<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
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
	<script>
	 $(document).ready(function() {
	        $('#table_id_reportes').DataTable({
	            "paging": true,
	            "pageLength": 10
	        });
	    });
		</script>
		
	<div class="row m-4">
		<div class="col-4">
			<input class="form-control" type="date" name="txtFechaDesde"> 
		</div>
		<div class="col-4"> 
			<input class="form-control" type="date" name="txtFechaHasta"> 
		</div>
		<div class="col-4"> 
			<button  class="form-control" name="btnFiltrar">Filtrar</button>
		</div>
	</div>
	
	<div class="row"> 
		<div class="col-4 m-auto" > 
			<button class="form-control" name="btnReportes" onclick="openModal('modalReportes')" style="margin-bottom:10px"> Reportes </button>
		</div>
	</div>

	<div class="container-fluid" style="width:95%; margin-bottom:20px">
		<div class="card text-center" style="box-shadow: rgba(0, 0, 0, 0.24) 0px 3px 100px;">
			<div class="card-header "><h5>Turnos</h5></div>
			<table class="table table-hover" id="table_id_reportes" style="font-size: 11px;">
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

		    	</tbody>                                             
			</table>
		</div>
	</div> 
	
	<div id="modalReportes" class="modal">
   		<div class="modal-content">
        	<span class="close" onclick="closeModal('modalReportes')" >&times;</span>
        	<div class="d-flex align-items-center justify-content-center">
				<div class="row m-2">
		        	<div class="col-8">
				     	<label class="form-label">Cantidad de turnos asignados entre las fechas seleccionadas:</label>   	
		            </div>
		            
		            <div class="col-4">
		                <input class="form-control" name="txtTurnosAsignados" disabled>
		            </div>
				</div>
				
				<div class="row m-2">
		        	<div class="col-8">
				     	<label class="form-label">Médico con más turnos asignados:</label>   	
		            </div>
		            
		            <div class="col-4">
		                <input class="form-control" name="txtMedicoTurnosAsignados" disabled>
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
	</script>    
</body>
</html>