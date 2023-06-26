package negImpl;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import daoImpl.GeneralDao;
import daoImpl.PacienteDao;
import entidades.Localidad;
import entidades.Paciente;
import entidades.Provincia;
import exceptions.DNIInvalidoException;
import exceptions.MailInvalidoException;
import neg.IPacienteNegocio;

public class PacienteNegocio extends GeneralNegocio implements IPacienteNegocio{
	GeneralDao generalDao = new GeneralDao();
	PacienteDao pacienteDao = new PacienteDao();
	LocalidadNegocio localidadNegocio = new LocalidadNegocio();
	
	@Override
	public List<Paciente> obtenerPacientes(boolean sinInactivos) {
		return pacienteDao.readAll(sinInactivos);
	}
	
	@Override
    public Map<String, String> obtenerColumnas() {
        List<String> columnasList = pacienteDao.getColumns();
        return super.obtenerColumnas("_PAC", columnasList);
    }

	@Override
	public List<Paciente> obtenerPacientesPorFiltro(String columna, String texto) {
		return pacienteDao.getPacientesByFilter(columna, texto);
	}

	@Override
	public Paciente getPacienteCrear(HttpServletRequest request) {

		String dni = request.getParameter("txtDNI");    
		Provincia provincia = createProvinciaFromRequest(request);
	    Localidad localidad = createLocalidadFromRequest(request);
		String nombre = request.getParameter("txtNombre");
		String apellido = request.getParameter("txtApellido");
		String correo = request.getParameter("txtCorreo");
		String sexo = request.getParameter("ddlSexo");
		String nacionalidad = request.getParameter("txtNacionalidad");
		Date fechaNac = parseDate(request);
		String direccion = request.getParameter("txtDireccion");
		String telefono = request.getParameter("txtTelefono");
		
	    return new Paciente(dni, provincia, localidad, nombre, apellido, correo, 
	    					sexo, nacionalidad, fechaNac, direccion, telefono);
	}
	
	@Override
	public Paciente getPacienteEditar(HttpServletRequest request) {
		int codPac = Integer.parseInt(request.getParameter("codPac"));
		String dni = request.getParameter("txtDNI");    
		Provincia provincia = createProvinciaFromRequest(request);
	    Localidad localidad = createLocalidadFromRequest(request);
		String nombre = request.getParameter("txtNombre");
		String apellido = request.getParameter("txtApellido");
		String correo = request.getParameter("txtCorreo");
		String sexo = request.getParameter("ddlSexo");
		String nacionalidad = request.getParameter("txtNacionalidad");
		Date fechaNac = parseDate(request);
		String direccion = request.getParameter("txtDireccion");
		String telefono = request.getParameter("txtTelefono");
		Boolean estado = request.getParameter("rdEstado").equals("1");
		
	    return new Paciente(codPac, dni, provincia, localidad, nombre, apellido, correo, 
	    					sexo, nacionalidad, fechaNac, direccion, telefono, estado);
	}
	
	private Provincia createProvinciaFromRequest(HttpServletRequest request) {
	    int codigoProvincia = Integer.parseInt(request.getParameter("ddlProvincia"));
	    Provincia provincia = new Provincia();
	    provincia.setCodProvincia(codigoProvincia);
	    return provincia;
	}

	private Localidad createLocalidadFromRequest(HttpServletRequest request) {
	    int codigoLocalidad = Integer.parseInt(request.getParameter("ddlLocalidad"));
	    Localidad localidad = new Localidad();
	    localidad.setCodLocalidad(codigoLocalidad);
	    return localidad;
	}
	
	private Date parseDate(HttpServletRequest request) {
	    try {
	        String fechaNacString = request.getParameter("txtFechaNacimiento");
	        SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
	        return dateFormat.parse(fechaNacString);
	    } catch (ParseException e) {
	        e.printStackTrace();
	    }
	    return null;
	}

	@Override
	public int guardar(Paciente unPaciente) throws DNIInvalidoException, MailInvalidoException{
		DNIInvalidoException excDNI = new DNIInvalidoException();
		MailInvalidoException excMail = new MailInvalidoException();
		if(generalDao.dniRepetido(unPaciente.getDNI(), unPaciente.getCodPac())) throw excDNI;
		if(generalDao.correoRepetido(unPaciente.getCorreo(), unPaciente.getCodPac())) throw excMail;
		if(pacienteDao.insert(unPaciente)) return 1;
		else return 0;
	}

	@Override
	public boolean eliminarPaciente(int codMed) {
		return pacienteDao.delete(codMed);
	}

	@Override
	public int editarPaciente(Paciente unPaciente)  throws DNIInvalidoException, MailInvalidoException{
		DNIInvalidoException excDNI = new DNIInvalidoException();
		MailInvalidoException excMail = new MailInvalidoException();
		if(generalDao.dniRepetido(unPaciente.getDNI(), unPaciente.getCodPac())) throw excDNI;
		if(generalDao.correoRepetido(unPaciente.getCorreo(), unPaciente.getCodPac())) throw excMail;
		if(pacienteDao.update(unPaciente)) return 1;
		else return 0;
	}


}
