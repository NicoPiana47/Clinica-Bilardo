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

import entidades.Paciente;
import negImpl.PacienteNegocio;

@WebServlet("/servletPacientes")
public class servletPacientes extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public servletPacientes() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		PacienteNegocio pacienteNegocio = new PacienteNegocio();
    	List<Paciente> listaPacientes = pacienteNegocio.obtenerPacientes();
		inicializarModuloPacientes(request, pacienteNegocio, listaPacientes);
		    
	    forwardToPage(request, response, "/AdminPacientes.jsp");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		PacienteNegocio pacienteNegocio = new PacienteNegocio();
	    List<Paciente> listaPacientes = null;
	    
		if(request.getParameter("btnFiltrar")!=null) {
			String texto = request.getParameter("txtFiltro");
			String columna = request.getParameter("ddlFiltros");
			listaPacientes = pacienteNegocio.obtenerPacientesPorFiltro(columna, texto);
		}
		
		if(request.getParameter("btnLimpiarFiltros")!=null) {
			listaPacientes = pacienteNegocio.obtenerPacientes();
		}

		inicializarModuloPacientes(request, pacienteNegocio, listaPacientes);
	    forwardToPage(request, response, "/AdminPacientes.jsp");
	}
	
	private void forwardToPage(HttpServletRequest request, HttpServletResponse response, String page) throws ServletException, IOException {
	    RequestDispatcher rd = request.getRequestDispatcher(page);
	    rd.forward(request, response);
	}
	
	private void inicializarModuloPacientes(HttpServletRequest request, PacienteNegocio pacienteNegocio, List<Paciente> listaPacientes) {
		inicializarListaFiltros(request, pacienteNegocio);
		request.setAttribute("listaPacientes", listaPacientes);
	}
	
	private void inicializarListaFiltros(HttpServletRequest request, PacienteNegocio pacienteNegocio) {
		Map<String, String> listaFiltros = pacienteNegocio.obtenerColumnas();
	    request.setAttribute("listaFiltros", listaFiltros);
	}
	
}
