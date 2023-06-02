<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>AdminMedicos</title>
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
        
		.selected-row {
		  background-color: #e0e0e0;
		}
</style>
</head>
<body>
	<%@ include file="/MasterPage.jsp" %>
	<h1 class="text-center">Administración de médicos</h1>
	
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
			<button class="form-control" onclick="openModal('modalCreate')">Crear Medico</button>
		</div>
	</div>
	
	<script>
		$(document).ready(function () {
			$('#table_id_usuarios').DataTable()             
		});
	</script>
	
	<div class="container-fluid" style="width:95%; margin-bottom:20px">
		<div class="card text-center" style="box-shadow: rgba(0, 0, 0, 0.24) 0px 3px 100px;">
			<div class="card-header "><h5>Médicos</h5></div>
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
						<th>Especialidad</th>
						<th>Fecha de atención</th>  
						<th>Usuario</th>
						<th>Contraseña</th>
						<th>Tipo</th>
						<th>Estado</th>
					</tr>
				</thead>
		        <tbody>
					<tr onclick="openModal('modalEdit')">
						<form >
							<th scope="row">
								<button type="submit" name ="btnEliminar"class="btn btn-outline-danger btn-sm" onclick="return confirm('¿Esta seguro de que quiere eliminar el médico?')">
									<i class="fa-solid fa-trash"></i>
								</button>
		                	</th>
	   					</form>
		         	</tr>
		    	</tbody>                                             
			</table>
		</div>
	</div>
      
	<div id="modalCreate" class="modal">
   		<div class="modal-content">
        	<span class="close" onclick="closeModal('modalCreate')" >&times;</span>
        	<div class="d-flex align-items-center justify-content-center">
	        	<div class="col-6">
					<div class="row m-2">
			        	<div class="col-4">
					     	<label class="form-label">DNI</label>   	
			                <input class="form-control" type="number"  min="0" name="txtDNICR" required>
			            </div>
			            
			            <div class="col-4">
				     		<label class="form-label">Nombre</label> 
			                <input class="form-control" name="txtNombreCR" oninput="validarLetras(this)" required>
			            </div>
			            
			            <div class="col-4">
				     		<label class="form-label">Apellido</label>
			                <input class="form-control" name="txtApellidoCR" oninput="validarLetras(this)" required>
			            </div>
					</div>
			        
			        <div class="row m-2">
			        	<div class="col-4">
			        	<label class="form-label">Sexo</label>
			        		<select class="form-control" name="txtSexoCR">
			        			<option>Masculino</option>
			        			<option>Femenino</option>
			        			<option>Otro</option>
			        		</select> 
			        	</div>
			        	
			        	<div class="col-4">
			        		<label class="form-label">Nacionalidad</label> 
			        		<input class="form-control" name="txtNacionalidadCR" oninput="validarLetras(this)" required> 
			        	</div>
			        	<div class="col-4"> 
			        		<label class="form-label">Fecha de nacimiento</label>
				        	<input class="form-control" type="date" name="txtFechaNacimientoCR" required>
			        	
			        	</div>
			        </div>
			        
			        <div class="row m-2">
			        	<div class="col-4">
				        	<label class="form-label">Dirección</label>
							<input class="form-control" name="txtDireccionCR" required>
			        	</div>
			        	
			        	<div class="col-4">
						  <label class="form-label">Provincia</label>
						  <select class="form-control" name="ddlProvinciaCR" id="ddlProvinciaCR"></select>
						</div>
			        	<div class="col-4"> 
			        		<label class="form-label">Localidad</label>
				        	<select class="form-control" name="ddlLocalidadCR"  id="ddlLocalidadCR"></select> 	
			        	</div>
			        </div>
			        
			        <div class="row m-2">
			        	<div class="col-4">
			        		<label class="form-label">Correo</label>
			        		<input class="form-control" type="email" name="txtCorreoCR" required>
			        	</div>
			        	
			        	<div class="col-4">
			        		<label class="form-label">Telefono</label> 
			        		<input class="form-control" type="number"  min="0" name="txtTelefonoCR" required> 
			        	</div>
			        	<div class="col-4"> 
			        		<label class="form-label">Especialidad</label>
				        	<select class="form-control" name="ddlEspecialidadesCR">
			        			
			        		</select> 	
			        	</div>
			        </div>
			        
			        <div class="row m-2">
			        	<div class="col-4">
			        		<label class="form-label">Ver</label> 			        		
			        		<button class="form-control" onclick="openModal('modalHorarios')">Horarios</button>
			        	</div>
			        	
			        	<div class="col-4">
			        		<label class="form-label">Usuario</label> 
			        		<input class="form-control" name="txtUsuarioCR" required> 
			        	</div>
			        	<div class="col-4"> 
			        		<label class="form-label">Contraseña</label>
				        	<input class="form-control" type="password" name="txtContraseñaCR" required> 			 	
			        	</div>
			        </div>
			        
			        <div class="row m-2">
			        	<div class="col-6">
			        		<label class="form-label">Normal</label>
				        	<input class="form-check-input" style="margin-left:20px" type="radio" name="rdTipoCR" value="0">
			        	</div>
			        	<div class="col-6">
			        		<label class="form-label">Admin</label>
			        		<input class="form-check-input" style="margin-left:20px" type="radio" name="rdTipoCR" value="1">
			        	</div>
			        </div>
			        
			        <div class="row m-2">
			        	<div class="col-12">
				        	<button class="form-control" type="submit" style="margin-top:10px">Crear Médico</button>
			        	</div>
			        </div>
				</div>
			</div>
		</div>
	</div>
      
    <div id="modalEdit" class="modal">
   		<div class="modal-content">
        	<span class="close" onclick="closeModal('modalEdit')" >&times;</span>
        	<div class="d-flex align-items-center justify-content-center">
	        	<div class="col-6">
					<div class="row m-2">
			        	<div class="col-4">
					     	<label class="form-label">DNI</label>   	
			                <input class="form-control" type="number"  min="0" name="txtDNIED" required>
			            </div>
			            
			            <div class="col-4">
				     		<label class="form-label">Nombre</label> 
			                <input class="form-control" name="txtNombreED" oninput="validarLetras(this)" required>
			            </div>
			            
			            <div class="col-4">
				     		<label class="form-label">Apellido</label>
			                <input class="form-control" name="txtApellidoED" oninput="validarLetras(this)" required>
			            </div>
					</div>
			        
			        <div class="row m-2">
			        	<div class="col-4">
			        	<label class="form-label">Sexo</label>
			        		<select class="form-control" name="txtSexoED">
			        			<option>Masculino</option>
			        			<option>Femenino</option>
			        			<option>Otro</option>
			        		</select> 
			        	</div>
			        	
			        	<div class="col-4">
			        		<label class="form-label">Nacionalidad</label> 
			        		<input class="form-control" name="txtNacionalidadED" oninput="validarLetras(this)" required> 
			        	</div>
			        	<div class="col-4"> 
			        		<label class="form-label">Fecha de nacimiento</label>
				        	<input class="form-control" type="date" name="txtFechaNacimientoED" required>
			        	
			        	</div>
			        </div>
			        
			        <div class="row m-2">
			        	<div class="col-4">
				        	<label class="form-label">Dirección</label>
							<input class="form-control" name="txtDireccionED" required>
			        	</div>
			        	
			        	<div class="col-4">
			        		<label class="form-label">Provincia</label> 
			        		<select class="form-control" name="ddlProvinciaED">
			        			
			        		</select> 
			        	</div>
			        	<div class="col-4"> 
			        		<label class="form-label">Localidad</label>
				        	<select class="form-control" name="ddlLocalidadED">
			        			
			        		</select> 	
			        	</div>
			        </div>
			        
			        <div class="row m-2">
			        	<div class="col-4">
			        		<label class="form-label">Correo</label>
			        		<input class="form-control" type="email" name="txtCorreoED" required>
			        	</div>
			        	
			        	<div class="col-4">
			        		<label class="form-label">Telefono</label> 
			        		<input class="form-control" type="number"  min="0" name="txtTelefonoED" required> 
			        	</div>
			        	<div class="col-4"> 
			        		<label class="form-label">Especialidad</label>
				        	<select class="form-control" name="ddlEspecialidadesED">
			        			
			        		</select> 	
			        	</div>
			        </div>
			        
			        <div class="row m-2">
			        	<div class="col-4">
			        		<label class="form-label">Fecha de atención</label>
			        		<input class="form-control" type="date" name="txtFechaAtencionED" required>
			        	</div>
			        	
			        	<div class="col-4">
			        		<label class="form-label">Usuario</label> 
			        		<input class="form-control" name="txtUsuarioED" required> 
			        	</div>
			        	<div class="col-4"> 
			        		<label class="form-label">Contraseña</label>
				        	<input class="form-control" type="password" name="txtContraseñaED" required> 			 	
			        	</div>
			        </div>
			        
			        <div class="row m-2">
			        	<div class="col-6">
			        		<label class="form-label">Normal</label>
				        	<input class="form-check-input" style="margin-left:20px" type="radio" name="rdTipoED" value="0">
			        	</div>
			        	<div class="col-6">
			        		<label class="form-label">Admin</label>
			        		<input class="form-check-input" style="margin-left:20px" type="radio" name="rdTipoED" value="1">
			        	</div>
			        </div>
			        
			        <div class="row m-2">
			        	<div class="col-6">
			        		<label class="form-label">Activo</label>
				        	<input class="form-check-input" style="margin-left:20px" type="radio" name="rdEstadoED" value="1">
			        	</div>
			        	<div class="col-6">
			        		<label class="form-label">Inactivo</label>
			        		<input class="form-check-input" style="margin-left:20px" type="radio" name="rdEstadoED" value="0">
			        	</div>
			        </div>
			        
			        
			        <div class="row m-2">
			        	<div class="col-12">
				        	<button class="form-control" type="submit" style="margin-top:10px">Editar Médico</button>
			        	</div>
			        </div>
				</div>
			</div>
		</div>
	</div>
	
	<div id="modalHorarios" class="modal">
   		<div class="modal-content">
        	<span class="close" onclick="closeModal('modalHorarios')" >&times;</span>
        	<div class="d-flex align-items-center justify-content-center">
        		<div class="container-fluid" style="width:95%; margin-bottom:20px">
					<div class="card text-center" style="box-shadow: rgba(0, 0, 0, 0.24) 0px 3px 100px;">
						<div class="card-header "><h5>Horario</h5></div>
						<table class="table table-hover" id="table_horarios" style="font-size: 11px;">
							<thead>
								<tr>
									<th> </th> 
									<th>Dia</th>   
									<th>Horario Desde</th> 
									<th>Horario Hasta</th>
									<th>Horas</th> 
									<th>Estado</th>
								</tr>
							</thead>
					        <tbody>
								<tr onclick="selectRow(this)">
									<form >
										<th scope="row">
											<button type="submit" name ="btnEliminar"class="btn btn-outline-danger btn-sm" onclick="return confirm('¿Esta seguro de que quiere eliminar el horario?')">
												<i class="fa-solid fa-trash"></i>
											</button>
					                	</th>
										<th>Dia</th>   
										<th>Horario Desde</th> 
										<th>Horario Hasta</th>
										<th>Horas</th> 
										<th>Estado</th>
				   					</form>
					         	</tr>
					    	</tbody>                                             
						</table>
					</div>
				</div>
				
	        	<div class="col-6">
					<div class="row m-2">
			        	<div class="col-4">
					     	<label class="form-label">Dia</label>   	
			                <select class="form-control" name="ddlDiaCR">
			                	<option> --- </option>
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
			                <input class="form-control" name="txtHorarioDesdeCR" required>
			            </div>
			            
			            <div class="col-4">
				     		<label class="form-label">Horario Hasta</label>
			                <input class="form-control" name="txtHorarioHastaCR" required>
			            </div>
					</div>
					
					<div class="row m-2" id="rdEstado" style="display: none;">
			        	<div class="col-6">
			        		<label class="form-label">Activo</label>
				        	<input class="form-check-input" style="margin-left:20px" type="radio" name="rdEstadoED" value="1">
			        	</div>
			        	<div class="col-6">
			        		<label class="form-label">Inactivo</label>
			        		<input class="form-check-input" style="margin-left:20px" type="radio" name="rdEstadoED" value="0">
			        	</div>
			        </div>
			        
			        
					<div class="row m-2">
				        <div class="col-12">
			        		<button id="btnModificarHorario" class="form-control btn-primary" style="display: none;" >Modificar</button>
							<button id="btnAgregarHorario" class="form-control btn-success" style="display: block;" >Agregar</button>
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
	
	function openModal(modal) {
		document.getElementById(modal).style.display = "block";
	}

    function closeModal(modal) {
    	document.getElementById(modal).style.display = "none";
    }
    
	function selectRow(row) {
  		var isSelected = row.classList.contains('selected-row');
      	var selectedRows = document.getElementsByClassName('selected-row');
      	var btnModificar = document.getElementById('btnModificarHorario');
      	var btnCrear = document.getElementById('btnAgregarHorario');
      	var rdEstado = document.getElementById('rdEstado');
      
      	for (var i = 0; i < selectedRows.length; i++) {
        	selectedRows[i].classList.remove('selected-row');
      	}
      
    	if (!isSelected) {
	        row.classList.add('selected-row');
	        btnModificar.style.display = 'block'; 
	        btnCrear.style.display = 'none'; 
	        rdEstado.style.display = 'block';
		} else {
		    btnModificar.style.display = 'none';
		    btnCrear.style.display = 'block'; 
		    rdEstado.style.display = 'none';
      	}
    }
  
    function cargarProvincias() {
    	var provincias = [
    		  {
    		    id: 1,
    		    nombre: 'Buenos Aires',
    		    localidades: [
    		      'Buenos Aires',
    		      'La Plata',
    		      'Mar del Plata',
    		      // Agrega más localidades si es necesario
    		    ]
    		  },
    		  {
    		    id: 2,
    		    nombre: 'Catamarca',
    		    localidades: [
    		      'San Fernando del Valle de Catamarca',
    		      'Andalgalá',
    		      'Belén',
    		      // Agrega más localidades si es necesario
    		    ]
    		  },
    		  {
    		    id: 3,
    		    nombre: 'Chaco',
    		    localidades: [
    		      'Resistencia',
    		      'Barranqueras',
    		      'Fontana',
    		      // Agrega más localidades si es necesario
    		    ]
    		  },
    		  // Agrega el resto de las provincias con sus localidades
    		  {
    		    id: 4,
    		    nombre: 'Chubut',
    		    localidades: [
    		      'Rawson',
    		      'Comodoro Rivadavia',
    		      'Puerto Madryn',
    		      // Agrega más localidades si es necesario
    		    ]
    		  },
    		  {
    		    id: 5,
    		    nombre: 'Córdoba',
    		    localidades: [
    		      'Córdoba',
    		      'Villa Carlos Paz',
    		      'Río Cuarto',
    		      // Agrega más localidades si es necesario
    		    ]
    		  },
    		  {
    		    id: 6,
    		    nombre: 'Corrientes',
    		    localidades: [
    		      'Corrientes',
    		      'Goya',
    		      'Mercedes',
    		      // Agrega más localidades si es necesario
    		    ]
    		  },
    		  {
    		    id: 7,
    		    nombre: 'Entre Ríos',
    		    localidades: [
    		      'Paraná',
    		      'Concordia',
    		      'Gualeguaychú',
    		      // Agrega más localidades si es necesario
    		    ]
    		  },
    		  {
    		    id: 8,
    		    nombre: 'Formosa',
    		    localidades: [
    		      'Formosa',
    		      'Clorinda',
    		      'Pirané',
    		      // Agrega más localidades si es necesario
    		    ]
    		  },
    		  {
    		    id: 9,
    		    nombre: 'Jujuy',
    		    localidades: [
    		      'San Salvador de Jujuy',
    		      'San Pedro',
    		      'Palpalá',
    		      // Agrega más localidades si es necesario
    		    ]
    		  },
    		  {
    		    id: 10,
    		    nombre: 'La Pampa',
    		    localidades: [
    		      'Santa Rosa',
    		      'General Pico',
    		      'Toay',
    		      // Agrega más localidades si es necesario
    		    ]
    		  },
    		  {
    		    id: 11,
    		    nombre: 'La Rioja',
    		    localidades: [
    		      'La Rioja',
    		      'Chilecito',
    		      'Famatina',
    		      // Agrega más localidades si es necesario
    		    ]
    		  },
    		  {
    		    id: 12,
    		    nombre: 'Mendoza',
    		    localidades: [
    		      'Mendoza',
    		      'San Rafael',
    		      'Godoy Cruz',
    		      // Agrega más localidades si es necesario
    		    ]
    		  },
    		  {
    		    id: 13,
    		    nombre: 'Misiones',
    		    localidades: [
    		      'Posadas',
    		      'Oberá',
    		      'Eldorado',
    		      // Agrega más localidades si es necesario
    		    ]
    		  },
    		  {
    		    id: 14,
    		    nombre: 'Neuquén',
    		    localidades: [
    		      'Neuquén',
    		      'San Martín de los Andes',
    		      'Cutral Có',
    		      // Agrega más localidades si es necesario
    		    ]
    		  },
    		  {
    		    id: 15,
    		    nombre: 'Río Negro',
    		    localidades: [
    		      'Viedma',
    		      'San Carlos de Bariloche',
    		      'General Roca',
    		      // Agrega más localidades si es necesario
    		    ]
    		  },
    		  {
    		    id: 16,
    		    nombre: 'Salta',
    		    localidades: [
    		      'Salta',
    		      'San Ramón de la Nueva Orán',
    		      'Tartagal',
    		      // Agrega más localidades si es necesario
    		    ]
    		  },
    		  {
    		    id: 17,
    		    nombre: 'San Juan',
    		    localidades: [
    		      'San Juan',
    		      'Rawson',
    		      'Chimbas',
    		      // Agrega más localidades si es necesario
    		    ]
    		  },
    		  {
    		    id: 18,
    		    nombre: 'San Luis',
    		    localidades: [
    		      'San Luis',
    		      'Villa Mercedes',
    		      'San Francisco del Monte de Oro',
    		      // Agrega más localidades si es necesario
    		    ]
    		  },
    		  {
    		    id: 19,
    		    nombre: 'Santa Cruz',
    		    localidades: [
    		      'Río Gallegos',
    		      'Caleta Olivia',
    		      'Pico Truncado',
    		      // Agrega más localidades si es necesario
    		    ]
    		  },
    		  {
    		    id: 20,
    		    nombre: 'Santa Fe',
    		    localidades: [
    		      'Santa Fe',
    		      'Rosario',
    		      'Venado Tuerto',
    		      // Agrega más localidades si es necesario
    		    ]
    		  },
    		  {
    		    id: 21,
    		    nombre: 'Santiago del Estero',
    		    localidades: [
    		      'Santiago del Estero',
    		      'La Banda',
    		      'Termas de Río Hondo',
    		      // Agrega más localidades si es necesario
    		    ]
    		  },
    		  {
    		    id: 22,
    		    nombre: 'Tierra del Fuego',
    		    localidades: [
    		      'Ushuaia',
    		      'Río Grande',
    		      'Tolhuin',
    		      // Agrega más localidades si es necesario
    		    ]
    		  },
    		  {
    		    id: 23,
    		    nombre: 'Tucumán',
    		    localidades: [
    		      'San Miguel de Tucumán',
    		      'Yerba Buena',
    		      'Tafí Viejo',
    		      // Agrega más localidades si es necesario
    		    ]
    		  }
    		];
        var ddlProvincia = document.getElementById('ddlProvinciaCR');
        var ddlLocalidad = document.getElementById('ddlLocalidadCR');

        // Agrega una opción por defecto para provincia y localidad
        var optionDefaultProvincia = document.createElement('option');
        optionDefaultProvincia.value = '';
        optionDefaultProvincia.text = 'Seleccionar provincia';
        ddlProvincia.appendChild(optionDefaultProvincia);

        var optionDefaultLocalidad = document.createElement('option');
        optionDefaultLocalidad.value = '';
        optionDefaultLocalidad.text = 'Seleccionar localidad';
        ddlLocalidad.appendChild(optionDefaultLocalidad);

        // Agrega las opciones de provincia al select
        provincias.forEach(function (provincia) {
          var option = document.createElement('option');
          option.value = provincia.id;
          option.text = provincia.nombre;
          ddlProvincia.appendChild(option);
        });

        // Evento change para cargar las localidades correspondientes a la provincia seleccionada
        ddlProvincia.addEventListener('change', function () {
          var selectedProvinceId = this.value;
          ddlLocalidad.innerHTML = ''; // Limpiar las opciones anteriores

          if (selectedProvinceId !== '') {
            var selectedProvince = provincias.find(function (provincia) {
              return provincia.id === parseInt(selectedProvinceId);
            });

            if (selectedProvince) {
              selectedProvince.localidades.forEach(function (localidad) {
                var option = document.createElement('option');
                option.value = localidad;
                option.text = localidad;
                ddlLocalidad.appendChild(option);
              });
            }
          }
        });
      }

      // Llama a la función cargarProvincias al cargar la página
      document.addEventListener('DOMContentLoaded', function () {
        cargarProvincias();
      });
    
    
    
</script>
    
</body>
</html>
