<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>MiCuenta</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-0evHe/X+R7YkIZDRvuzKMRqM+OrBnVFBL6DOitfPri4tjfHxaWutUpFmBp4vmVor" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-pprn3073KE6tl6bjs2QrFaJGz5/SUsLqktiwsUTF55Jfv3qYSDhgCecCxMW52nD2" crossorigin="anonymous"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css" rel="stylesheet">

</head>
<style>
	#form-micuenta{
		display: flex;
		justify-content: center;
		align-items: center;
	}
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

</style>


<body>
    <%@ include file="/MasterPage.jsp" %>
    <form class="w-100 m-auto" id="form-micuenta">
        <div class="col-6">
            <div class="row m-2">
                <div class="col-4">
                    <label class="form-label">DNI</label>       
                    <input class="form-control" type="number" min="0" name="txtDNI" value="" disabled>
                </div>
                
                <div class="col-4">
                    <label class="form-label">Nombre</label>
                    <input class="form-control" name="txtNombreCR" value="" disabled>
                </div>
                
                <div class="col-4">
                    <label class="form-label">Apellido</label>
                    <input class="form-control" name="txtApellido" value="" disabled>
                </div>
            </div>
            
            <div class="row m-2">
                <div class="col-4">
                    <label class="form-label">Sexo</label>
                    <select class="form-control" name="txtSexo" disabled>
                        <option>Masculino</option>
                        <option>Femenino</option>
                        <option>Otro</option>
                    </select> 
                </div>
                
                <div class="col-4">
                    <label class="form-label">Nacionalidad</label> 
                    <input class="form-control" name="txtNacionalidad" value="" disabled> 
                </div>
                <div class="col-4"> 
                    <label class="form-label">Fecha de nacimiento</label>
                    <input class="form-control" type="date" name="txtFechaNacimiento" value="" disabled>
                </div>
            </div>
            
            <div class="row m-2">
                <div class="col-4">
                    <label class="form-label">Direcci�n</label>
                    <input class="form-control" name="txtDireccion" value="" disabled>
                </div>
                
                <div class="col-4">
                    <label class="form-label">Provincia</label> 
                    <select class="form-control" name="ddlProvincia" disabled>
                        <option value=""></option>
                     
                    </select> 
                </div>
                <div class="col-4"> 
                    <label class="form-label">Localidad</label>
                    <select class="form-control" name="ddlLocalidad" disabled>
                        <option value=""></option>
                      
                    </select>    
                </div>
            </div>
            
            <div class="row m-2">
                <div class="col-4">
                    <label class="form-label">Correo</label>
                    <input class="form-control" type="email" name="txtCorreo" value="" disabled>
                </div>
                
                <div class="col-4">
                    <label class="form-label">Telefono</label> 
                    <input class="form-control" type="number" min="0" name="txtTelefono" value="" disabled> 
                </div>
                <div class="col-4"> 
                    <label class="form-label">Especialidad</label>
                    <select class="form-control" name="ddlEspecialidades" disabled>
                        <option value=""></option>
                      
                    </select>    
                </div>
            </div>
            
            <div class="row m-2">
                
                
                <div class="col-6">
                    <label class="form-label">Usuario</label> 
                    <input class="form-control" name="txtUsuario" value="" disabled> 
                </div>
              <div class="col-6"> 
    <label class="form-label">Contrase�a</label>
    <div class="input-group">
        <input class="form-control" type="password" name="txtContrase�a" value="" disabled> 
        <button class="btn btn-outline-secondary" type="button" id="togglePassword">
            <i class="bi bi-eye"></i>
        </button>
    </div>
</div>

            </div>        
        </div>
    </form>
    <div class="row">
     <div class="col-4 m-auto">
                          		
	        		<button class="form-control" onclick="openModal('modalHorarios')">Horarios</button>
                </div>
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
								 
								<th>D�a</th>
								<th>Horario Desde</th>
								<th>Horario Hasta</th>
								<th>Horas</th>
								<th>Estado</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>D�a</td>
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
	
	const passwordInput = document.querySelector("input[name='txtContrase�a']");
    const togglePasswordButton = document.getElementById("togglePassword");

    togglePasswordButton.addEventListener("click", function() {
        if (passwordInput.type === "password") {
            passwordInput.type = "text";
            togglePasswordButton.innerHTML = '<i class="bi bi-eye-slash"></i>';
        } else {
            passwordInput.type = "password";
            togglePasswordButton.innerHTML = '<i class="bi bi-eye"></i>';
        }
    });
</script>
    
    
    
</body>
</html>