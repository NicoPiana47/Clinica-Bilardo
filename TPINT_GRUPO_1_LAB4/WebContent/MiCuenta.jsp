<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>MiCuenta</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-0evHe/X+R7YkIZDRvuzKMRqM+OrBnVFBL6DOitfPri4tjfHxaWutUpFmBp4vmVor" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-pprn3073KE6tl6bjs2QrFaJGz5/SUsLqktiwsUTF55Jfv3qYSDhgCecCxMW52nD2" crossorigin="anonymous"></script>
</head>
<style>
	#form-micuenta{
		display: flex;
		justify-content: center;
		align-items: center;
	}

</style>


<body>
	<%@ include file="/MasterPage.jsp" %>
	<form class="w-100 m-auto" id="form-micuenta">
		<div class="col-6">
			<div class="row m-2">
	        	<div class="col-4">
			     	<label class="form-label">DNI</label>   	
	                <input class="form-control" type="number"  min="0" name="txtDNICR" disabled required>
	            </div>
	            
	            <div class="col-4">
		     		<label class="form-label">Nombre</label> 
	                <input class="form-control" name="txtNombreCR" oninput="validarLetras(this)" disabled required>
	            </div>
	            
	            <div class="col-4">
		     		<label class="form-label">Apellido</label>
	                <input class="form-control" name="txtApellidoCR" oninput="validarLetras(this)" disabled required>
	            </div>
			</div>
	        
	        <div class="row m-2">
	        	<div class="col-4">
	        	<label class="form-label">Sexo</label>
	        		<select class="form-control" name="txtSexoCR" disabled>
	        			<option>Masculino</option>
	        			<option>Femenino</option>
	        			<option>Otro</option>
	        		</select> 
	        	</div>
	        	
	        	<div class="col-4">
	        		<label class="form-label">Nacionalidad</label> 
	        		<input class="form-control" name="txtNacionalidadCR" oninput="validarLetras(this)" disabled required> 
	        	</div>
	        	<div class="col-4"> 
	        		<label class="form-label">Fecha de nacimiento</label>
		        	<input class="form-control" type="date" name="txtFechaNacimientoCR" disabled required>
	        	
	        	</div>
	        </div>
	        
	        <div class="row m-2">
	        	<div class="col-4">
		        	<label class="form-label">Dirección</label>
					<input class="form-control" name="txtDireccionCR" disabled required>
	        	</div>
	        	
	        	<div class="col-4">
	        		<label class="form-label">Provincia</label> 
	        		<select class="form-control" name="ddlProvinciaCR" disabled>
	        			
	        		</select> 
	        	</div>
	        	<div class="col-4"> 
	        		<label class="form-label">Localidad</label>
		        	<select class="form-control" name="ddlLocalidadCR" disabled>
	        			
	        		</select> 	
	        	</div>
	        </div>
	        
	        <div class="row m-2">
	        	<div class="col-4">
	        		<label class="form-label">Correo</label>
	        		<input class="form-control" type="email" name="txtCorreoCR" disabled required>
	        	</div>
	        	
	        	<div class="col-4">
	        		<label class="form-label">Telefono</label> 
	        		<input class="form-control" type="number"  min="0" name="txtTelefonoCR" disabled required> 
	        	</div>
	        	<div class="col-4"> 
	        		<label class="form-label">Especialidad</label>
		        	<select class="form-control" name="ddlEspecialidadesCR" disabled>
	        			
	        		</select> 	
	        	</div>
	        </div>
	        
	        <div class="row m-2">
	        	<div class="col-4">
	        		<label class="form-label">Fecha de atención</label>
	        		<input class="form-control" type="date" name="txtFechaAtencionCR" disabled required>
	        	</div>
	        	
	        	<div class="col-4">
	        		<label class="form-label">Usuario</label> 
	        		<input class="form-control" name="txtUsuarioCR" disabled required> 
	        	</div>
	        	<div class="col-4"> 
	        		<label class="form-label">Contraseña</label>
		        	<input class="form-control" type="password" name="txtContraseñaCR" disabled required> 			 	
	        	</div>
	        </div>        
		</div>
	</form>
</body>
</html>