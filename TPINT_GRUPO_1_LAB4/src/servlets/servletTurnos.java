package servlets;

import java.io.IOException;
import java.sql.Date;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;



import entidades.Turno;
import negImpl.TurnosNegocio;

/**
 * Servlet implementation class servletTurnos
 */
@WebServlet("/servletTurnos")
public class servletTurnos extends HttpServlet {
	private static final long serialVersionUID = 1L;
	TurnosNegocio turnoNegocio = new TurnosNegocio();
       
    public servletTurnos() {

    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		TurnosNegocio turnoNegocio = new TurnosNegocio();
    	List<Turno> listaTurnos = turnoNegocio.obtenerTurnos();
		request.setAttribute("listaTurnos", listaTurnos);
		    
	    RequestDispatcher rd = request.getRequestDispatcher("/AdminReportes.jsp");
		rd.forward(request, response);
		
			
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		listarTurnosConFechas(request, response);
	}
	
	
	public void listarTurnosConFechas(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		if(request.getParameter("btnFiltrar") != null) {
			List<Turno> listaTurnos = null;
			
			if(request.getParameter("txtFechaDesde").equals("") && request.getParameter("txtFechaHasta").equals("")) {
				listaTurnos = turnoNegocio.obtenerTurnos();
			}
			else {											
				listaTurnos = turnoNegocio.obtenerTurnosEntreFechas(request.getParameter("txtFechaDesde"), request.getParameter("txtFechaHasta"));
			}
				
			request.setAttribute("listaTurnos", listaTurnos);
			
			RequestDispatcher rd = request.getRequestDispatcher("/AdminReportes.jsp");
			rd.forward(request, response);
			
		}
	}
}
