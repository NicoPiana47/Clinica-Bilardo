<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>AdminMedicos</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-0evHe/X+R7YkIZDRvuzKMRqM+OrBnVFBL6DOitfPri4tjfHxaWutUpFmBp4vmVor" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-pprn3073KE6tl6bjs2QrFaJGz5/SUsLqktiwsUTF55Jfv3qYSDhgCecCxMW52nD2" crossorigin="anonymous"></script>


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
	<h1 class="text-center">Administraci�n de m�dicos</h1>
	
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
			<button class="form-control" onclick="openModal('modalMedico')">Crear Medico</button>
		</div>
	</div>
	
	<script>
		$(document).ready(function () {
			$('#table_id_usuarios').DataTable()             
		});
	</script>
	
	<div class="container-fluid" style="width:95%; margin-bottom:20px">
		<div class="card text-center" style="box-shadow: rgba(0, 0, 0, 0.24) 0px 3px 100px;">
			<div class="card-header "><h5>M�dicos</h5></div>
			<table class="table table-hover" id="table_id_medicos" style="font-size: 11px;">
				<thead>
					<tr>
						<th> </th> 
						<th>DNI</th>   
						<th>Nombre</th> 
						<th>Apellido</th>
						<th>Sexo</th> 
						<th>Nacionalidad</th> 
						<th>Fecha de nacimiento</th> 
						<th>Direcci�n</th>
						<th>Provincia</th>
						<th>Localidad</th>
						<th>Correo</th>
						<th>Tel�fono</th> 
						<th>Especialidad</th>
						<th>Fecha de atenci�n</th>  
						<th>Usuario</th>
						<th>Contrase�a</th>
						<th>Tipo</th>
						<th>Estado</th>
					</tr>
				</thead>
		        <tbody>
					<tr onclick="openModal('modalMedico', true)">
						<form >
							<th scope="row">
								<button type="submit" name ="btnEliminar"class="btn btn-outline-danger btn-sm" onclick="return confirm('�Esta seguro de que quiere eliminar el m�dico?')">
									<i class="fa-solid fa-trash"></i>
								</button>
		                	</th>
		                	<th>DNI</th>   
							<th>Nombre</th> 
							<th>Apellido</th>
							<th>Sexo</th> 
							<th>Nacionalidad</th> 
							<th>Fecha de nacimiento</th> 
							<th>Direcci�n</th>
							<th>Provincia</th>
							<th>Localidad</th>
							<th>Correo</th>
							<th>Tel�fono</th> 
							<th>Especialidad</th>
							<th>Fecha de atenci�n</th>  
							<th>Usuario</th>
							<th>Contrase�a</th>
							<th>Tipo</th>
							<th>Estado</th>
	   					</form>
		         	</tr>
		    	</tbody>                                             
			</table>
		</div>
	</div>
      
	<div id="modalMedico" class="modal">
   		<div class="modal-content">
        	<span class="close" onclick="closeModal('modalMedico', false)" >&times;</span>
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
				        	<label class="form-label">Direcci�n</label>
							<input class="form-control" name="txtDireccion" required>
			        	</div>
			        	
			        	<div class="col-4">
						  <label class="form-label">Provincia</label>
						  <select class="form-control" name="ddlProvincia" id="ddlProvincia"></select>
						</div>
			        	<div class="col-4"> 
			        		<label class="form-label">Localidad</label>
				        	<select class="form-control" name="ddlLocalidad"  id="ddlLocalidad"></select> 	
			        	</div>
			        </div>
			        
			        <div class="row m-2">
			        	<div class="col-4">
			        		<label class="form-label">Correo</label>
			        		<input class="form-control" type="email" name="txtCorreo" required>
			        	</div>
			        	
			        	<div class="col-4">
			        		<label class="form-label">Telefono</label> 
			        		<input class="form-control" type="number"  min="0" name="txtTelefono" required> 
			        	</div>
			        	<div class="col-4"> 
			        		<label class="form-label">Especialidad</label>
				        	<select class="form-control" name="ddlEspecialidad"></select> 	
			        	</div>
			        </div>
			        
			        <div class="row m-2">
			        	<div class="col-4">
			        		<label class="form-label">Ver</label> 			        		
			        		<button class="form-control" onclick="openModal('modalHorarios')">Horarios</button>
			        	</div>
			        	
			        	<div class="col-4">
			        		<label class="form-label">Usuario</label> 
			        		<input class="form-control" name="txtUsuario" required> 
			        	</div>
			        	<div class="col-4"> 
			        		<label class="form-label">Contrase�a</label>
				        	<input class="form-control" type="password" name="txtContrase�a" required> 			 	
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
				        	<button class="form-control" type="submit" style="margin-top:10px">Crear M�dico</button>
			        	</div>
			        </div>
			        
			        <div class="row m-2 editM" >
			        	<div class="col-12">
				        	<button class="form-control" type="submit" style="margin-top:10px">Editar M�dico</button>
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
											<button type="submit" name ="btnEliminar"class="btn btn-outline-danger btn-sm" onclick="return confirm('�Esta seguro de que quiere eliminar el horario?')">
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
				
				<div id="divHorario" class="col-6" style="display: block;">
					<div class="row m-2">
			        	<div class="col-4">
					     	<label class="form-label">Dia</label>   	
			                <select class="form-control" name="ddlDia">
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
				     		<input type="time" class="form-control form-control-lg" name="txtHorarioDesde"/>
			            </div>
			            
			            <div class="col-4">
				     		<label class="form-label">Horario Hasta</label>
				     		<input type="time" class="form-control form-control-lg" name="txtHorarioHasta"/>
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
			        		<button class="form-control btn-success" >Agregar</button>
				        </div>
			        </div>
			        
			        <div class="row m-2 editH" style="display: none;">
				        <div class="col-12">
			        		<button class="form-control btn-primary">Modificar</button>
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
		var cName = modal === 'modalMedico' ? 'M' : 'H';
		
	 	if (isEdit) {
	        hideElements(true, cName);
		} 
    	else {
    		hideElements(false, cName);
    	}
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

	function selectRow(row) {
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
    		document.getElementsByName('ddlEspecialidad')[0].selectedIndex = 0;
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
    		      // Agrega m�s localidades si es necesario
    		    ]
    		  },
    		  {
    		    id: 2,
    		    nombre: 'Catamarca',
    		    localidades: [
    		      'San Fernando del Valle de Catamarca',
    		      'Andalgal�',
    		      'Bel�n',
    		      // Agrega m�s localidades si es necesario
    		    ]
    		  },
    		  {
    		    id: 3,
    		    nombre: 'Chaco',
    		    localidades: [
    		      'Resistencia',
    		      'Barranqueras',
    		      'Fontana',
    		      // Agrega m�s localidades si es necesario
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
    		      // Agrega m�s localidades si es necesario
    		    ]
    		  },
    		  {
    		    id: 5,
    		    nombre: 'C�rdoba',
    		    localidades: [
    		      'C�rdoba',
    		      'Villa Carlos Paz',
    		      'R�o Cuarto',
    		      // Agrega m�s localidades si es necesario
    		    ]
    		  },
    		  {
    		    id: 6,
    		    nombre: 'Corrientes',
    		    localidades: [
    		      'Corrientes',
    		      'Goya',
    		      'Mercedes',
    		      // Agrega m�s localidades si es necesario
    		    ]
    		  },
    		  {
    		    id: 7,
    		    nombre: 'Entre R�os',
    		    localidades: [
    		      'Paran�',
    		      'Concordia',
    		      'Gualeguaych�',
    		      // Agrega m�s localidades si es necesario
    		    ]
    		  },
    		  {
    		    id: 8,
    		    nombre: 'Formosa',
    		    localidades: [
    		      'Formosa',
    		      'Clorinda',
    		      'Piran�',
    		      // Agrega m�s localidades si es necesario
    		    ]
    		  },
    		  {
    		    id: 9,
    		    nombre: 'Jujuy',
    		    localidades: [
    		      'San Salvador de Jujuy',
    		      'San Pedro',
    		      'Palpal�',
    		      // Agrega m�s localidades si es necesario
    		    ]
    		  },
    		  {
    		    id: 10,
    		    nombre: 'La Pampa',
    		    localidades: [
    		      'Santa Rosa',
    		      'General Pico',
    		      'Toay',
    		      // Agrega m�s localidades si es necesario
    		    ]
    		  },
    		  {
    		    id: 11,
    		    nombre: 'La Rioja',
    		    localidades: [
    		      'La Rioja',
    		      'Chilecito',
    		      'Famatina',
    		      // Agrega m�s localidades si es necesario
    		    ]
    		  },
    		  {
    		    id: 12,
    		    nombre: 'Mendoza',
    		    localidades: [
    		      'Mendoza',
    		      'San Rafael',
    		      'Godoy Cruz',
    		      // Agrega m�s localidades si es necesario
    		    ]
    		  },
    		  {
    		    id: 13,
    		    nombre: 'Misiones',
    		    localidades: [
    		      'Posadas',
    		      'Ober�',
    		      'Eldorado',
    		      // Agrega m�s localidades si es necesario
    		    ]
    		  },
    		  {
    		    id: 14,
    		    nombre: 'Neuqu�n',
    		    localidades: [
    		      'Neuqu�n',
    		      'San Mart�n de los Andes',
    		      'Cutral C�',
    		      // Agrega m�s localidades si es necesario
    		    ]
    		  },
    		  {
    		    id: 15,
    		    nombre: 'R�o Negro',
    		    localidades: [
    		      'Viedma',
    		      'San Carlos de Bariloche',
    		      'General Roca',
    		      // Agrega m�s localidades si es necesario
    		    ]
    		  },
    		  {
    		    id: 16,
    		    nombre: 'Salta',
    		    localidades: [
    		      'Salta',
    		      'San Ram�n de la Nueva Or�n',
    		      'Tartagal',
    		      // Agrega m�s localidades si es necesario
    		    ]
    		  },
    		  {
    		    id: 17,
    		    nombre: 'San Juan',
    		    localidades: [
    		      'San Juan',
    		      'Rawson',
    		      'Chimbas',
    		      // Agrega m�s localidades si es necesario
    		    ]
    		  },
    		  {
    		    id: 18,
    		    nombre: 'San Luis',
    		    localidades: [
    		      'San Luis',
    		      'Villa Mercedes',
    		      'San Francisco del Monte de Oro',
    		      // Agrega m�s localidades si es necesario
    		    ]
    		  },
    		  {
    		    id: 19,
    		    nombre: 'Santa Cruz',
    		    localidades: [
    		      'R�o Gallegos',
    		      'Caleta Olivia',
    		      'Pico Truncado',
    		      // Agrega m�s localidades si es necesario
    		    ]
    		  },
    		  {
    		    id: 20,
    		    nombre: 'Santa Fe',
    		    localidades: [
    		      'Santa Fe',
    		      'Rosario',
    		      'Venado Tuerto',
    		      // Agrega m�s localidades si es necesario
    		    ]
    		  },
    		  {
    		    id: 21,
    		    nombre: 'Santiago del Estero',
    		    localidades: [
    		      'Santiago del Estero',
    		      'La Banda',
    		      'Termas de R�o Hondo',
    		      // Agrega m�s localidades si es necesario
    		    ]
    		  },
    		  {
    		    id: 22,
    		    nombre: 'Tierra del Fuego',
    		    localidades: [
    		      'Ushuaia',
    		      'R�o Grande',
    		      'Tolhuin',
    		      // Agrega m�s localidades si es necesario
    		    ]
    		  },
    		  {
    		    id: 23,
    		    nombre: 'Tucum�n',
    		    localidades: [
    		      'San Miguel de Tucum�n',
    		      'Yerba Buena',
    		      'Taf� Viejo',
    		      // Agrega m�s localidades si es necesario
    		    ]
    		  }
    		];
        var ddlProvincia = document.getElementById('ddlProvincia');
        var ddlLocalidad = document.getElementById('ddlLocalidad');

        // Agrega una opci�n por defecto para provincia y localidad
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

      // Llama a la funci�n cargarProvincias al cargar la p�gina
      document.addEventListener('DOMContentLoaded', function () {
        cargarProvincias();
      });
    	
      $('#table_id_medicos').DataTable({
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
    
    
</script>
    
</body>
</html>
