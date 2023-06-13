package servlets;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
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
		editarMedico(request, response);

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
		if(request.getParameter("btnCrearMedico") != null) {
			Date fechaNac = null;
			try {
	            String fechaNacString = request.getParameter("txtFechaNacimiento");
	            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
	            fechaNac = dateFormat.parse(fechaNacString);
	        } 
			catch (ParseException e) {
	        } 
			catch (java.text.ParseException e) {
			}
		    // Crear el objeto Medico con los valores proporcionados
		    Medico medico = new Medico();
		    medico.setDNI(request.getParameter("txtDNI"));
		    medico.getEspecialidad().setCodEspecialidad(Integer.parseInt(request.getParameter("ddlEspecialidad").toString()));
		    medico.getProvincia().setCodProvincia(Integer.parseInt(request.getParameter("ddlProvincia").toString())); 
		    medico.getLocalidad().setCodLocalidad(Integer.parseInt(request.getParameter("ddlLocalidad").toString()));
		    medico.setCorreo(request.getParameter("txtCorreo"));
		    medico.setUsername(request.getParameter("txtUsuario"));
		    medico.setContraseña(request.getParameter("txtContraseña"));
		    medico.setNombre(request.getParameter("txtNombre"));
		    medico.setApellido(request.getParameter("txtApellido"));
		    medico.setSexo(request.getParameter("ddlSexo"));
		    medico.setNacionalidad(request.getParameter("txtNacionalidad"));
		    medico.setFechaNacimiento(fechaNac);
		    medico.setDireccion(request.getParameter("txtDireccion"));
		    medico.setTelefono(request.getParameter("txtTelefono"));
		    medico.setTipo(request.getParameter("rdTipo").equals("1"));
		    medico.setEstado(request.getParameter("rdEstado").equals("1"));
		    
		    Boolean CrearMedico= mNeg.crearMedico(medico);
		    request.setAttribute("CrearMedico", CrearMedico);
		    		    
		    inicializarModuloMedicos(request, response, null);		        	  	    
		}	
	}
	private void editarMedico(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		if(request.getParameter("btnEditarMedico") != null) {
				Medico medico = mNeg.getMedicoEditar(request);
				boolean edito = mNeg.editarMedico(medico);
				request.setAttribute("edito", edito);
				inicializarModuloMedicos(request, response, null);
							
	}
	
	
			}
}

