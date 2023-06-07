package negImpl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import daoImpl.PacienteDao;
import entidades.Paciente;
import neg.IPacienteNegocio;

public class PacienteNegocio implements IPacienteNegocio{
	
	PacienteDao pdao = new PacienteDao();
	
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
		return pdao.readAll();
	}
	
	@Override
	public Map<String, String> obtenerColumnas() {
	    Map<String, String> columnas = new HashMap<>();

	    try {
	    	List<String> columnasList = pdao.getColumns();
	        
	    	 for (String columna : columnasList) {
                String descripcion = columna.replaceAll("_PAC$", "")
                        .replaceAll("([A-Z][a-z]+)([A-Z][a-z]+)", "$1 de $2")
                        .replaceAll("([A-Z]+)([A-Z][a-z])", "$1 $2")
                        .replaceAll("([a-z])([A-Z])", "$1 $2");

                if (descripcion.contains("Cod")) {
                    descripcion = descripcion.replace("Cod", "Codigo");
                }

                columnas.put(columna, descripcion);
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return columnas;
	}

	@Override
	public List<Paciente> obtenerPacientesPorFiltro(String columna, String texto) {
		return pdao.getPacientesByFilter(columna, texto);
	}


}
