<%@ page import="entidades.Medico" %>
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
 <script src="notiflix-Notiflix-6936fff/dist/notiflix-notify-aio-3.2.6.min.js"></script>
		
</head>
<body>

<section class="vh-100" 
		 style="background-color: #2a2a72; 
			    background-image: linear-gradient(315deg, #2a2a72 0%, #009ffd 74%);">
  <div class="container py-5 h-100">
    <div class="row d-flex justify-content-center align-items-center h-100">
      <div class="col col-xl-10">
        <div class="card" style="border-radius: 1rem;">
          <div class="row g-0">
            <div class="col-md-6 col-lg-5 d-none d-md-block" style="margin:auto;">
              <img src="./src/assets/Ilustracion.jpg"
                alt="login form" class="img-fluid" style="border-radius: 1rem 0 0 1rem;" />
            </div>
            <div class="col-md-6 col-lg-7 d-flex align-items-center">
              <div class="card-body p-4 p-lg-5 text-black">

                <form action= "servletMedicos" method="post" name="formInicioSesion" >

                  <div class="d-flex align-items-center mb-3 pb-1">
                   
                     <img class="fas fa-cubes fa-2x me-3 img-fluid"src="./src/assets/Clinica.svg" class="logo img-fluid " alt="logo"  />
                    
                  </div>

                  <h5 class="fw-normal mb-3 pb-3" style="letter-spacing: 1px;">Iniciar Sesión</h5>

                  <div class="form-outline mb-4">
                    <input type="text" name="txtNombreUsuario" id="" class="form-control form-control-lg" required/>
                    <label class="form-label" >Nombre de usuario</label>
                  </div>

                  <div class="form-outline mb-4">
                    <input type="password" id="" name="txtContraseña" class="form-control form-control-lg" required="true"/>
                    <label class="form-label" for="">Contraseña</label>
                  </div>

                  <div class="pt-1 mb-4">
                    <button type = "submit" class="btn btn-dark btn-lg btn-block" name="btnIngresar" >Ingresar</button>
                  </div>
                  
                </form>
                
                  <%if((Boolean)request.getAttribute("inicioSesion") != null){
                	  
                	  boolean inicioSesion = (boolean)request.getAttribute("inicioSesion");

                	  if(!inicioSesion){
                		  %><script>Notiflix.Notify.failure("Usuario o contraseña incorrecta!")</script> <% 
					    }    
                	  }                                             	
                  %>             
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</section>
	
	
	
	
</body>
</html>