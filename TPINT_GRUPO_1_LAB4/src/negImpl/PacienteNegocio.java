package negImpl;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import daoImpl.LocalidadDao;
import daoImpl.PacienteDao;
import entidades.Localidad;
import entidades.Paciente;
import entidades.Provincia;
import neg.IPacienteNegocio;

public class PacienteNegocio extends GeneralNegocio implements IPacienteNegocio{
	
	PacienteDao pacienteDao = new PacienteDao();
	LocalidadNegocio localidadNegocio = new LocalidadNegocio();
	
	@Override
	public List<Paciente> obtenerPacientes() {
		return pacienteDao.readAll();
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
	        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
	        return dateFormat.parse(fechaNacString);
	    } catch (ParseException e) {
	        e.printStackTrace();
	    }
	    return null;
	}

	
	@Override
	public boolean guardar(Paciente unPaciente) {
		return pacienteDao.insert(unPaciente);
	}

	@Override
	public boolean eliminarPaciente(int codMed) {
		return pacienteDao.delete(codMed);
	}


}
