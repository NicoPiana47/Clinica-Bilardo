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

</head>
<body>
	
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
	                    </tr>
	                </thead>
	                <tbody>
	                 	<tr>
	                 		<form >
		                        <th scope="row">
									<button type="submit" name ="btnEliminar"class="btn btn-outline-danger btn-sm" onclick="return confirm('¿Esta seguro de que quiere eliminar el usuario?')">
										<i class="fa-solid fa-trash"></i>
									</button>
		                        </th>
				        	</form>
		                </tr>
	            	</tbody>                                             
	            </table>
	        </div>
      </div>
      
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
        		<select class="form-control" name="ddlProvinciaCR">
        			
        		</select> 
        	</div>
        	<div class="col-4"> 
        		<label class="form-label">Localidad</label>
	        	<select class="form-control" name="ddlLocalidadCR">
        			
        		</select> 	
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
        		<label class="form-label">Fecha de atención</label>
        		<input class="form-control" type="date" name="txtFechaAtencionCR" required>
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
        	<div class="col-4">
	        	<button class="form-control" type="submit" style="margin-top:10px">Editar Médico</button>
        	</div>
        </div>
    </div>
     	
<script>
	function validarLetras(input) {
	  	var regex = /[^a-zA-Z]/g;
	  	input.value = input.value.replace(regex, '');
	}
</script>
    
</body>
</html>
