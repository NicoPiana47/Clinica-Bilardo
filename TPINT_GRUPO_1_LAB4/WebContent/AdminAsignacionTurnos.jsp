<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>AdminAsignacionTurnos</title>
</head>
<body>
	<form>
		<h1>Admin Asignación de Turnos</h1> <br> <br>
		
		<label>Especialidad:</label> <br>
		<select name="ddlEspecialidades"> </select> <br> <br> <br>
		<label>Médico:</label> <br>
		<select name="ddlMedicos"> </select> <br> <br> <br>
		<label>Horarios:</label> <br>
		<select name="ddlHorarios"> </select> <br> <br> <br>
		<label>Pacientes:</label> <br>
		<select name="ddlPacientes"> </select> <br> <br> <br>
		
		<button type="submit" name="btnAsignar">Asignar turno</button>
	</form>
</body>
</html>