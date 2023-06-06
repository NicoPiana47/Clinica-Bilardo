package servlets;

import java.io.IOException;
import java.util.List;

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
		request.setAttribute("listaPacientes", listaPacientes);
		    
	    RequestDispatcher rd = request.getRequestDispatcher("/AdminPacientes.jsp");
		rd.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	
		
			PacienteNegocio pacienteNegocio = new PacienteNegocio();
    	List<Paciente> listaSeguros = pacienteNegocio.obtenerPacientes();
		request.setAttribute("listaPacientes", listaSeguros);
		    
	    RequestDispatcher rd = request.getRequestDispatcher("/AdminPacientes.jsp");
		rd.forward(request, response);

			/*PacienteNegocio pacienteNegocio = new PacienteNegocio();
			
			int tipoDeSeguroId = Integer.parseInt(request.getParameter("selectTipoDeSeguro"));
			List<Paciente> listaSeguros = pacienteNegocio.obtenerSeguroPorTipoDeSeguro(tipoDeSeguroId);
    		request.setAttribute("listaSeguros", listaSeguros);
			
    		inicializarTiposDeSeguro(request, pacienteNegocio);
    		
			RequestDispatcher rd = request.getRequestDispatcher("/ListarSeguros.jsp");   
	        rd.forward(request, response);    */
	}
	
	private void inicializarAgregarSeguro(HttpServletRequest request, PacienteNegocio seguroDao, int idSeguro) {
		request.setAttribute("idSeguro", idSeguro+1);
	}

	/*private void inicializarTiposDeSeguro(HttpServletRequest request, PacienteNegocio seguroDao) {
		List<TipoDeSeguro> tiposDeSeguro = seguroDao.obtenerTiposDeSeguro();
        request.setAttribute("tipoDeSeguro", tiposDeSeguro);
	}*/

}
