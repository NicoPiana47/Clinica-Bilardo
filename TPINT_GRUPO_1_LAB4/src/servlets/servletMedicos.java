package servlets;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import entidades.Medico;
import entidades.Paciente;
import negImpl.MedicoNegocio;
import negImpl.PacienteNegocio;


/**
 * Servlet implementation class servletMedicos
 */
@WebServlet("/servletMedicos")
public class servletMedicos extends HttpServlet {
	private static final long serialVersionUID = 1L;
	MedicoNegocio mNeg = new MedicoNegocio();
       
    public servletMedicos() {
        super();
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		inicializarModuloMedicos(request, response);
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
		Map<String, String> listaFiltros = inicializarListaFiltros(request);
    	
    	RequestDispatcher rd = request.getRequestDispatcher("/AdminMedicos.jsp");    	
    	request.setAttribute("listaMedicos", listaMedicos);
    	request.setAttribute("listaFiltros", listaFiltros);
    	
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

