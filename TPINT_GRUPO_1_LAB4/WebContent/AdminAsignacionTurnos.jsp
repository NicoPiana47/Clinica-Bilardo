<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>AdminAsignacionTurnos</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-0evHe/X+R7YkIZDRvuzKMRqM+OrBnVFBL6DOitfPri4tjfHxaWutUpFmBp4vmVor" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-pprn3073KE6tl6bjs2QrFaJGz5/SUsLqktiwsUTF55Jfv3qYSDhgCecCxMW52nD2" crossorigin="anonymous"></script>
<link rel="stylesheet" type="text/css"
	href="https://cdn.datatables.net/1.10.19/css/jquery.dataTables.css">
<script type="text/javascript" charset="utf8"
	src="https://cdn.datatables.net/1.10.19/js/jquery.dataTables.js"></script>
	
</head>
<body>
	<%@ include file="/MasterPage.jsp" %>
	<h1 class="text-center">Asignación de Turnos</h1> 
	<form class="w-50 m-auto">
		
		<div class="row text-center m-4" >		
			<label>Especialidad:</label> <br>
			<select class="form-control" name="ddlEspecialidades"> </select>
		</div>
		
		<div class="row text-center m-4" >	
			<label>Médico:</label> <br>
			<select class="form-control" name="ddlMedicos"> </select>
		</div>
		
		<div class="row text-center m-4">
            <label>Fecha:</label><br>
            <input class="form-control" type="date" name="fecha" id="fecha" onchange="generarHorariosDisponibles()" required>
        </div>
        <div class="row text-center m-4">
            <label>Horarios disponibles:</label><br>
            <select class="form-control" name="ddlHorariosDisponibles" id="ddlHorariosDisponibles" disabled></select>
        </div>
		
		<div class="row text-center m-4">
			<label>Pacientes:</label> <br>
			<select class="form-control" name="ddlPacientes"> </select>
		</div>
		
		<button class="form-control" type="submit" name="btnAsignar">Asignar turno</button>
	</form>
</body>

<script>
        function generarHorariosDisponibles() {
            var fechaSeleccionada = document.getElementById("fecha").value;

            var horariosDisponibles = obtenerHorariosDisponibles(fechaSeleccionada);

            var ddlHorariosDisponibles = document.getElementById("ddlHorariosDisponibles");
            ddlHorariosDisponibles.innerHTML = "";

            for (var i = 0; i < horariosDisponibles.length; i++) {
                var option = document.createElement("option");
                option.value = horariosDisponibles[i];
                option.text = horariosDisponibles[i];
                ddlHorariosDisponibles.add(option);
            }

            ddlHorariosDisponibles.disabled = false;
        }

        function obtenerHorariosDisponibles(fecha) {
            // Aquí puedes implementar la lógica para obtener los horarios disponibles basados en la fecha seleccionada.
            // En este caso, se hardcodea el horario disponible de 10 AM a 11 AM.
            var horarios = ["10:00 - 11:00"];

            return horarios;
        }

        function asignarTurno() {
            // Aquí puedes implementar la lógica para asignar el turno seleccionado.
            // Puedes obtener los valores seleccionados de los campos correspondientes y realizar las acciones necesarias.
        }
    </script>
</html>