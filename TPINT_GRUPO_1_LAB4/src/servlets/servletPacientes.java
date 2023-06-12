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

import entidades.Localidad;
import entidades.Paciente;
import entidades.Provincia;
import negImpl.LocalidadNegocio;
import negImpl.PacienteNegocio;
import negImpl.ProvinciaNegocio;

@SuppressWarnings("serial")
@WebServlet("/servletPacientes")
public class servletPacientes extends HttpServlet {
       
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
		
		if(request.getParameter("btnCrearPaciente") != null) {
			Paciente unPaciente = pacienteNegocio.getPacienteCrear(request);
			pacienteNegocio.guardar(unPaciente);
			listaPacientes = pacienteNegocio.obtenerPacientes();
		}
		
		if(request.getParameter("btnEliminar") != null) {
			int codPac = Integer.parseInt(request.getParameter("CodPac").toString());
			boolean elimino = pacienteNegocio.eliminarPaciente(codPac);
			request.setAttribute("elimino", elimino);
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
		inicializarListaProvinciasLocalidades(request, pacienteNegocio);
		request.setAttribute("listaPacientes", listaPacientes);
	}
	
	private void inicializarListaFiltros(HttpServletRequest request, PacienteNegocio pacienteNegocio) {
		Map<String, String> listaFiltros = pacienteNegocio.obtenerColumnas();
	    request.setAttribute("listaFiltros", listaFiltros);
	}
	
	private void inicializarListaProvinciasLocalidades(HttpServletRequest request, PacienteNegocio pacienteNegocio) {
	    LocalidadNegocio localidadNegocio = new LocalidadNegocio();
	    ProvinciaNegocio provinciaNegocio = new ProvinciaNegocio();
        List<Localidad> listaLocalidades = localidadNegocio.obtenerLocalidades();
        List<Provincia> listaProvincias = provinciaNegocio.obtenerProvincias();
		request.setAttribute("listaLocalidades", listaLocalidades);
		request.setAttribute("listaProvincias", listaProvincias);
	}
	
}
