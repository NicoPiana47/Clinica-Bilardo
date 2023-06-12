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
	public boolean insert(Paciente persona) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean update(Paciente persona) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean delete(String dni) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean existeDni(String dni) {
		// TODO Auto-generated method stub
		return false;
	}
	
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
		
		String aa = request.getParameter("ddlLocalidad");
		int codigoLocalidad = Integer.parseInt(request.getParameter("ddlLocalidad"));
		Localidad localidad = localidadNegocio.obtenerLocalidadPorCodigo(codigoLocalidad);
		Provincia provincia = localidad.getProvincia();
		
		String dni = request.getParameter("txtDNI");
		String nombre = request.getParameter("txtNombre");
		String apellido = request.getParameter("txtApellido");
		String correo = request.getParameter("txtCorreo");
		String sexo = request.getParameter("ddlSexo");
		String nacionalidad = request.getParameter("txtNacionalidad");
		Date fechaNac = null;
		String direccion = request.getParameter("txtDireccion");
		String telefono = request.getParameter("txtTelefono");
		boolean estado = Boolean.parseBoolean(request.getParameter("txtEstado"));
		
		try {
		    String fechaNacString = request.getParameter("txtFechaNacimiento");
		    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		    fechaNac = dateFormat.parse(fechaNacString);
		} catch (ParseException e) {
		    e.printStackTrace();
		}
		
	    return new Paciente(dni, provincia, localidad, nombre, apellido, correo, 
	    					sexo, nacionalidad, fechaNac, direccion, telefono, estado);
	}
	
	@Override
	public boolean guardar(Paciente unPaciente) {
		return pacienteDao.insert(unPaciente);
	}


}
