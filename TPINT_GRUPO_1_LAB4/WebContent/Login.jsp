<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Login</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-0evHe/X+R7YkIZDRvuzKMRqM+OrBnVFBL6DOitfPri4tjfHxaWutUpFmBp4vmVor" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-pprn3073KE6tl6bjs2QrFaJGz5/SUsLqktiwsUTF55Jfv3qYSDhgCecCxMW52nD2" crossorigin="anonymous"></script>
<link rel="stylesheet" type="text/css"href="https://cdn.datatables.net/1.10.19/css/jquery.dataTables.css">
<link rel="stylesheet" href="./src/Style/login.css">
<script type="text/javascript" charset="utf8"
	src="https://cdn.datatables.net/1.10.19/js/jquery.dataTables.js"></script>
		<script src="https://kit.fontawesome.com/3c33daaf69.js" crossorigin="anonymous"></script>
</head>
<body>
	<h1 class="text-center">Iniciar sesión</h1>
	
	<form class=" login_Form">	
		<div class="Login_Form_Datos">		
			<input class="form__input" name="txtNombreUsuario" required>
			<label class="form__label">Nombre de usuario</label> 
		</div>	
		<div class="">
			<label>Contraseña:</label> <br>
			<input class="input_Form" name="txtContraseña" required>
		</div>	
		<button class="button_Form" type="" name="">Ingresar</button>
	</form>
	
</body>
</html>