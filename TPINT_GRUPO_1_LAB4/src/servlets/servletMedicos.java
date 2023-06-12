package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.sun.org.apache.xerces.internal.impl.xpath.regex.ParseException;

import entidades.Especialidad;
import entidades.Localidad;
import entidades.Medico;
import entidades.Paciente;
import entidades.Provincia;
import negImpl.EspecialidadNegocio;
import negImpl.LocalidadNegocio;
import negImpl.MedicoNegocio;
import negImpl.PacienteNegocio;
import negImpl.ProvinciaNegocio;


/**
 * Servlet implementation class servletMedicos
 */
@WebServlet("/servletMedicos")

public class servletMedicos extends HttpServlet {
	private static final long serialVersionUID = 1L;
	MedicoNegocio mNeg = new MedicoNegocio();
	ProvinciaNegocio pNeg = new ProvinciaNegocio();
    LocalidadNegocio lNeg=new LocalidadNegocio();
    EspecialidadNegocio eNeg=new EspecialidadNegocio();
    public servletMedicos() {
        super();
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		inicializarModuloMedicos(request, response, null);
	
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		iniciarSesion(request, response);
		eliminarMedico(request, response);
		listarMedicosConFiltro(request, response);
		crearMedico(request, response);

	}

		
	
	
	
	public void iniciarSesion(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession sessionMedico = request.getSession();
		Boolean filas = false;
		if(request.getParameter("btnIngresar")!=null)
        {
			sessionMedico.setAttribute("sessionMedico", null);
        	
			Medico med = mNeg.iniciarSesion(request.getParameter("txtNombreUsuario"), request.getParameter("txtContraseña"));
			
        	if(med != null) {
        		sessionMedico.setAttribute("sessionMedico", med);
        		filas = true;
        	}
        	
        	RequestDispatcher rd = null;
        	
        	if(filas) {
        		if(med.getTipo()) {
        			inicializarModuloMedicos(request, response, null);
        			return;
        		}
        		else rd = request.getRequestDispatcher("/Inicio.jsp");
        	}
        	else rd = request.getRequestDispatcher("/Login.jsp");
        	      	
        	request.setAttribute("inicioSesion", filas);
			rd.forward(request, response);

        }
	}
	
	public void inicializarModuloMedicos(HttpServletRequest request, HttpServletResponse response, List<Medico> listaMedicos) throws ServletException, IOException {
		
		if(listaMedicos == null) {		
			List<Medico> listaMedicosCompleta = mNeg.obtenerMedicos();
			request.setAttribute("listaMedicos", listaMedicosCompleta); 
		}
		else {
			request.setAttribute("listaMedicos", listaMedicos); 
		}
		
		inicializarListas(request);
			
    	
    	RequestDispatcher rd = request.getRequestDispatcher("/AdminMedicos.jsp");    	
	
		rd.forward(request, response);
		
		
	}
	

	
	public void listarMedicosConFiltro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    
	    if(request.getParameter("btnFiltrar")!=null || request.getParameter("btnLimpiarFiltros")!=null) {
	    	List<Medico> listaMedicos = null;
	    	
	    	if(request.getParameter("btnFiltrar")!=null) {
	    		String texto = request.getParameter("txtFiltro");
	    		String columna = request.getParameter("ddlFiltros");
	    		listaMedicos = mNeg.obtenerMedicosPorFiltro(columna, texto);
	    	}
	    	
	    	if(request.getParameter("btnLimpiarFiltros")!=null) {
	    		listaMedicos = mNeg.obtenerMedicos();
	    	}
	    	
	    	inicializarModuloMedicos(request, response, listaMedicos);
	    }
	}
	
	private void inicializarListas(HttpServletRequest request) {
	    LocalidadNegocio localidadNegocio = new LocalidadNegocio();
	    ProvinciaNegocio provinciaNegocio = new ProvinciaNegocio();
	    EspecialidadNegocio especialidadNegocio = new EspecialidadNegocio();
        List<Localidad> listaLocalidades = localidadNegocio.obtenerLocalidades();
        List<Provincia> listaProvincias = provinciaNegocio.obtenerProvincias();
        List<Especialidad> listaEspecialidades = especialidadNegocio.obtenerEspecialidades();
        Map<String, String> listaFiltros = mNeg.obtenerColumnas();
		request.setAttribute("listaLocalidades", listaLocalidades);
		request.setAttribute("listaProvincias", listaProvincias);
		request.setAttribute("listaEspecialidades", listaEspecialidades);	
		request.setAttribute("listaFiltros", listaFiltros); 
	}
	
	private void eliminarMedico(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		if(request.getParameter("btnEliminar") != null) {
			int codMed = Integer.parseInt(request.getParameter("CodMed").toString());
			boolean elimino = mNeg.eliminarMedico(codMed);
			request.setAttribute("elimino", elimino);
		
			inicializarModuloMedicos(request, response, null);
		}
	}
	
	private void crearMedico(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
	    // Obtener los valores del formulario
		if(request.getParameter("btnCrearMedico") != null) {
	    String dni = request.getParameter("txtDNI");
	    int codEspecialidad =  Integer.parseInt(request.getParameter("ddlEspecialidad").toString());
	    int  codLocalidad = Integer.parseInt(request.getParameter("ddlLocalidad").toString());
	    int codProvincia = Integer.parseInt(request.getParameter("ddlProvincia").toString());
	    String correo = request.getParameter("txtCorreo");
	    String username = request.getParameter("txtUsuario");
	    String contrasena = request.getParameter("txtContraseña");
	    String nombre = request.getParameter("txtNombre");
	    String apellido = request.getParameter("txtApellido");
	    String sexo = request.getParameter("ddlSexo");
	    String nacionalidad = request.getParameter("txtNacionalidad");
	    String fechaNacimientoStr = request.getParameter("txtFechaNacimiento");
	    String direccion = request.getParameter("txtDireccion");
	    String telefono = request.getParameter("txtTelefono");
	    boolean tipo = request.getParameter("rdTipo").equals("1");
	    

	    // Realizar las conversiones necesarias, como parsear la fecha de nacimiento
	    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
	    java.util.Date utilFechaNacimiento = null;
	    
	     try {
			utilFechaNacimiento = dateFormat.parse(fechaNacimientoStr);
		} catch (java.text.ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	   

	    // Convertir java.util.Date a java.sql.Date
	    java.sql.Date sqlFechaNacimiento = new java.sql.Date(utilFechaNacimiento.getTime());
	    // Crear el objeto Medico con los valores proporcionados
	    Medico medico = new Medico();
	    medico.setDNI(dni);
	    medico.getEspecialidad().setCodEspecialidad(codEspecialidad); // Aquí deberías asignar el objeto Especialidad correspondiente en lugar del ID
	    medico.getLocalidad().setCodLocalidad(codLocalidad); // Aquí deberías asignar el objeto Localidad correspondiente en lugar del ID
	    medico.getProvincia().setCodProvincia(codProvincia); // Aquí deberías asignar el objeto Provincia correspondiente en lugar del ID
	    medico.setCorreo(correo);
	    medico.setUsername(username);
	    medico.setContraseña(contrasena);
	    medico.setNombre(nombre);
	    medico.setApellido(apellido);
	    medico.setSexo(sexo);
	    medico.setNacionalidad(nacionalidad);
	    medico.setFechaNacimiento(sqlFechaNacimiento);
	    medico.setDireccion(direccion);
	    medico.setTelefono(telefono);
	    medico.setTipo(tipo);
	    medico.setEstado(true);

	    // Aquí puedes llamar al método de tu lógica de negocio para crear el médico en la base de datos
	    Boolean CrearMedico= mNeg.crearMedico(medico);
	    request.setAttribute("CrearMedico", CrearMedico);
	    // Redireccionar o realizar cualquier CrearMedico adicional según sea necesario
	    
	    
	    
	    inicializarModuloMedicos(request, response, null);
	    
	    
	    
	    
	}

	
}
	}

