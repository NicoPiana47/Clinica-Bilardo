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

	<input name="txtFiltro" style="margin-left:200px; margin-top:20px"> 
	<select name="ddlFiltros"> </select>
	<button name="btnFiltrar">Filtrar</button>
	
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
      
     <div class="col-md-6">
     	<div class="form-floating mb-3"> 	
	     	<input class="form-control-lg" name="txtDNICR">
	     	<label for="floatingSelect">DNI</label> 
     	</div>
     		<input name="txtNombreCR">
	     	<label for="floatingSelect">Nombre</label> 
	     	<input name="txtApellidoCR">
	     	<label for="floatingSelect">Apellido</label>
     </div>
     
     <input name="txtDNICR"> <input name="txtNombreCR"> <input name="txtApellidoCR">
     <input name="txtSexoCR"> <input name="txtNacionalidadCR"> <input type="date" name="txtFechaNacimientoCR"> <br> <br>
     <input name="txtDireccionCR"> <select name="ddlProvinciasCR"> </select> <select name="ddlLocalidadesCR"> </select> <br> <br>
     <input name="txtCorreoCR"> <input name="txtTelefonoCR"> <select name="ddlEspecialidadesCR"> </select> <br> <br>
     <input name="txtFechaAtencion"> <input name="txtNombreCR"> <input name="txtApellidoCR"> <br> <br>
     
     <div class="col-md-6">
     
     </div>
     
      
      
</body>
</html>