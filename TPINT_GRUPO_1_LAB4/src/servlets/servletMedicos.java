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
		inicializarModuloMedicos(request, response, null);
	
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		iniciarSesion(request, response);
		listarMedicosConFiltro(request, response);
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
		inicializarListaFiltros(request);
		inicializarListaProvinciasLocalidades(request);
			
    	
    	RequestDispatcher rd = request.getRequestDispatcher("/AdminMedicos.jsp");    	
	
		rd.forward(request, response);
		
		
	}
	
	private void inicializarListaFiltros(HttpServletRequest request) {
		Map<String, String> listaFiltros = mNeg.obtenerColumnas();
		request.setAttribute("listaFiltros", listaFiltros);  
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
	
	private void inicializarListaProvinciasLocalidades(HttpServletRequest request) {
	    LocalidadNegocio localidadNegocio = new LocalidadNegocio();
	    ProvinciaNegocio provinciaNegocio = new ProvinciaNegocio();
        List<Localidad> listaLocalidades = localidadNegocio.obtenerLocalidades();
        List<Provincia> listaProvincias = provinciaNegocio.obtenerProvincias();
		request.setAttribute("listaLocalidades", listaLocalidades);
		request.setAttribute("listaProvincias", listaProvincias);
	}
}

