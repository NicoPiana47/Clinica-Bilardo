<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="entidades.Medico" %>
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
                    <input class="form-control" type="number" min="0" name="txtDNI" value="<%= med.getDNI() %>" disabled>
                </div>
                
                <div class="col-4">
                    <label class="form-label">Nombre</label>
                    <input class="form-control" name="txtNombreCR" value="<%= med.getNombre() %>" disabled>
                </div>
                
                <div class="col-4">
                    <label class="form-label">Apellido</label>
                    <input class="form-control" name="txtApellido" value="<%= med.getApellido() %>" disabled>
                </div>
            </div>
            
            <div class="row m-2">
                <div class="col-4">
                    <label class="form-label">Sexo</label>
                    <select class="form-control" name="txtSexo" disabled>
                        <option<% if (med.getSexo().equals("Masculino")) { %> selected <% } %>>Masculino</option>
                        <option<% if (med.getSexo().equals("Femenino")) { %> selected <% } %>>Femenino</option>
                        <option<% if (med.getSexo().equals("Otro")) { %> selected <% } %>>Otro</option>
                    </select> 
                </div>
                
                <div class="col-4">
                    <label class="form-label">Nacionalidad</label> 
                    <input class="form-control" name="txtNacionalidad" value="<%= med.getNacionalidad() %>" disabled> 
                </div>
                <div class="col-4"> 
                    <label class="form-label">Fecha de nacimiento</label>
                    <input class="form-control" type="date" name="txtFechaNacimiento" value="<%= med.getFechaNacimiento() %>" disabled>
                </div>
            </div>
            
            <div class="row m-2">
                <div class="col-4">
                    <label class="form-label">Dirección</label>
                    <input class="form-control" name="txtDireccion" value="<%= med.getDireccion() %>" disabled>
                </div>
                
                <div class="col-4">
                    <label class="form-label">Provincia</label> 
                    <select class="form-control" name="ddlProvincia" disabled>
                        <option value="<%= med.getProvincia().getCodProvincia() %>"><%= med.getProvincia().getDescripcion() %></option>
                     
                    </select> 
                </div>
                <div class="col-4"> 
                    <label class="form-label">Localidad</label>
                    <select class="form-control" name="ddlLocalidad" disabled>
                        <option value="<%= med.getLocalidad().getCodLocalidad() %>"><%= med.getLocalidad().getDescripcion() %></option>
                      
                    </select>    
                </div>
            </div>
            
            <div class="row m-2">
                <div class="col-4">
                    <label class="form-label">Correo</label>
                    <input class="form-control" type="email" name="txtCorreo" value="<%= med.getCorreo() %>" disabled>
                </div>
                
                <div class="col-4">
                    <label class="form-label">Telefono</label> 
                    <input class="form-control" type="number" min="0" name="txtTelefono" value="<%= med.getTelefono() %>" disabled> 
                </div>
                <div class="col-4"> 
                    <label class="form-label">Especialidad</label>
                    <select class="form-control" name="ddlEspecialidades" disabled>
                        <option value="<%= med.getEspecialidad().getCodEspecialidad_ESP()%>"><%= med.getEspecialidad().getDescripcion_ESP() %></option>
                      
                    </select>    
                </div>
            </div>
            
            <div class="row m-2">
                
                
                <div class="col-4">
                    <label class="form-label">Usuario</label> 
                    <input class="form-control" name="txtUsuario" value="<%= med.getUsername() %>" disabled> 
                </div>
                <div class="col-4"> 
                    <label class="form-label">Contraseña</label>
                    <input class="form-control" type="password" name="txtContraseña" value="<%= med.getContraseña() %>" disabled>              
                </div>
            </div>        
        </div>
    </form>
    <div class="col-4">
                    <label class="form-label">Ver horarios</label> 			        		
	        		<button class="form-control" onclick="openModal('modalHorarios')">Horarios</button>
                </div>
   <div id="modalHorarios" class="modal">
	<div class="modal-content">
		<span class="close" onclick="closeModal('modalHorarios')">&times;</span>
		<div class="d-flex align-items-center justify-content-center">
			<div class="container-fluid" style="width:95%; margin-bottom:20px">
				<div class="card text-center" style="box-shadow: rgba(0, 0, 0, 0.24) 0px 3px 100px;">
					<div class="card-header"><h5>Horario</h5></div>
					<table class="table table-hover" id="table_horarios" style="font-size: 11px;">
						<thead>
							<tr>
								<th></th>
								<th>Día</th>
								<th>Horario Desde</th>
								<th>Horario Hasta</th>
								<th>Horas</th>
								<th>Estado</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>Día</td>
								<td>Horario Desde</td>
								<td>Horario Hasta</td>
								<td>Horas</td>
								<td>Estado</td>
							</tr>
						</tbody>
					</table>
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