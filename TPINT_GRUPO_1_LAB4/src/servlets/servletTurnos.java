package servlets;

import java.io.IOException;
import java.util.Date;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import entidades.Especialidad;
import entidades.Medico;
import entidades.Paciente;
import entidades.Turno;
import negImpl.EspecialidadNegocio;
import negImpl.MedicoNegocio;
import negImpl.PacienteNegocio;
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
		if(request.getParameter("rep")!=null)
			inicializarAdminReportes(request, response);
		if(request.getParameter("asig")!=null)
			inicializarAdminAsigTurnos(request, response);	
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		listarTurnosConFechas(request, response);
		try {
			grabarTurno(request, response);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
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
			String medicoConMasTurnos = listarReportesMedicoConMasTurnos(request, response, listaTurnos);
			long cantTurnos = listaTurnos.stream().count();
			
			request.setAttribute("listaTurnos", listaTurnos);
			request.setAttribute("medicoConMasTurnos", medicoConMasTurnos);
			request.setAttribute("cantTurnos", cantTurnos);
			
			RequestDispatcher rd = request.getRequestDispatcher("/AdminReportes.jsp");
			rd.forward(request, response);
			
		}
	}
	
	
	public String listarReportesMedicoConMasTurnos(HttpServletRequest request, HttpServletResponse response, List<Turno> listaTurnos) throws ServletException, IOException {
		
		Map<String, Integer> conteoMedicos = new HashMap<>();
		
		for (Turno turno : listaTurnos) {
		    String medico = turno.getMedico().getNombre();
		    if (conteoMedicos.containsKey(medico)) {
		    	
		        int cantidadTurnos = conteoMedicos.get(medico);
		        conteoMedicos.put(medico, cantidadTurnos + 1);
		    } else {
		    	
		        conteoMedicos.put(medico, 1);
		    }
		}
		
		String medicoConMasTurnos = null;
		int maximoTurnos = 0;
		
		for (Map.Entry<String, Integer> entry : conteoMedicos.entrySet()) {
		    String medico = entry.getKey();
		    int cantidadTurnos = entry.getValue();

		    if (cantidadTurnos > maximoTurnos) {
		        medicoConMasTurnos = medico;
		        maximoTurnos = cantidadTurnos;
		    }
		}
	
		return medicoConMasTurnos;
	}
	
	public void inicializarAdminReportes(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		TurnosNegocio turnoNegocio = new TurnosNegocio();
    	List<Turno> listaTurnos = turnoNegocio.obtenerTurnos();
    	String medicoConMasTurnos = listarReportesMedicoConMasTurnos(request, response, listaTurnos);
    	long cantTurnos = listaTurnos.stream().count();
    	
		request.setAttribute("listaTurnos", listaTurnos);
		request.setAttribute("medicoConMasTurnos", medicoConMasTurnos);
		request.setAttribute("cantTurnos", cantTurnos);
		    
	    RequestDispatcher rd = request.getRequestDispatcher("/AdminReportes.jsp");
		rd.forward(request, response);
	}
	
	public void inicializarAdminAsigTurnos(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		EspecialidadNegocio espNeg = new EspecialidadNegocio();
		MedicoNegocio medNeg = new MedicoNegocio();
		PacienteNegocio pacNeg = new PacienteNegocio();
		
		List<Especialidad> listaEspecialidades = espNeg.obtenerEspecialidades();
		List<Medico> listaMedicos = medNeg.obtenerMedicos();
		List<Paciente> listaPacientes = pacNeg.obtenerPacientes();
    	
		request.setAttribute("listaEspecialidades", listaEspecialidades);
		request.setAttribute("listaMedicos", listaMedicos);
		request.setAttribute("listaPacientes", listaPacientes);
		    
	    RequestDispatcher rd = request.getRequestDispatcher("/AdminAsignacionTurnos.jsp");
		rd.forward(request, response);
	}
	
	public void grabarTurno(HttpServletRequest request, HttpServletResponse response) throws ParseException, ServletException, IOException {
		if(request.getParameter("btnAsignar") != null) {
			Turno turno = new Turno();
			
			String fechaTurnoS = request.getParameter("fecha");
			String horaTurnoS = request.getParameter("ddlHorariosDisponibles");
			String fecha = fechaTurnoS + " " + horaTurnoS;
	        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	        Date fechaTurno = dateFormat.parse(fecha);
	        
	     
	        int codMed = Integer.parseInt(request.getParameter("ddlMedicos"));
	        int codPac = Integer.parseInt(request.getParameter("ddlPacientes"));
	        
	        turno.setFechaTurno(fechaTurno);
	        turno.getMedico().setCodMed(codMed);
	        turno.getPaciente().setCodPac(codPac);
	        turno.getEstado().setCodEstado_EST(2);
	        
	        boolean guardo = turnoNegocio.grabarTurno(turno);
	        
	        request.setAttribute("guardo", guardo);
	        inicializarAdminAsigTurnos(request,  response);
		}
	}
}
