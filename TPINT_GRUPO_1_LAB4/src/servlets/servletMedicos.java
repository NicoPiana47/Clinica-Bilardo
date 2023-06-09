package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import entidades.Localidad;
import entidades.Medico;
import entidades.Paciente;
import entidades.Provincia;
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
    public servletMedicos() {
        super();
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		inicializarModuloMedicos(request, response);
	
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		iniciarSesion(request, response);
		listarMedicosConFiltro(request, response);
		 if (request.getParameter("btnFiltrar") != null || request.getParameter("btnLimpiarFiltros") != null) {
		        listarMedicosConFiltro(request, response);

		        int codProvincia = Integer.parseInt(request.getParameter("ddlProvincia"));

		        // Filtrar la lista de localidades según la provincia seleccionada
		        List<Localidad> listaLocalidadesFiltrada = lNeg.obtenerLocalidades(codProvincia);

		        // Actualizar la lista de localidades en el objeto request
		        request.setAttribute("listaLocalidades", listaLocalidadesFiltrada);
		    }
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
        			inicializarModuloMedicos(request, response);
        			return;
        		}
        		else rd = request.getRequestDispatcher("/Inicio.jsp");
        	}
        	else rd = request.getRequestDispatcher("/Login.jsp");
        	      	
        	request.setAttribute("inicioSesion", filas);
			rd.forward(request, response);

        }
	}
	
	public void inicializarModuloMedicos(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		List<Medico> listaMedicos = mNeg.obtenerMedicos();
		List<Provincia> listaProvincias = pNeg.obtenerProvincias(); 
		Map<String, String> listaFiltros = inicializarListaFiltros(request);
		
		
		
    	
    	RequestDispatcher rd = request.getRequestDispatcher("/AdminMedicos.jsp");    	
    	request.setAttribute("listaMedicos", listaMedicos);
    	request.setAttribute("listaFiltros", listaFiltros);  
	    request.setAttribute("listaProvincias", listaProvincias);	   
	
		rd.forward(request, response);
		
		
	}
	
	private Map<String, String> inicializarListaFiltros(HttpServletRequest request) {
		Map<String, String> listaFiltros = mNeg.obtenerColumnas();
		return listaFiltros;
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
	    	
	    	Map<String, String> listaFiltros = inicializarListaFiltros(request);
	    	
	    	RequestDispatcher rd = request.getRequestDispatcher("/AdminMedicos.jsp");   
	    	
	    	request.setAttribute("listaMedicos", listaMedicos);
	    	request.setAttribute("listaFiltros", listaFiltros);
	    	
	    	rd.forward(request, response);
	    }
	}
}

