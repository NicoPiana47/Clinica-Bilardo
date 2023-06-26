package negImpl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import daoImpl.MedicoDao;
import entidades.Medico;
import neg.IMedicoNegocio;

public class GeneralNegocio {
	
	 public Map<String, String> obtenerColumnas(String text, List<String> columnasList) {
	        Map<String, String> columnas = new HashMap<>();

	        for (String columna : columnasList) {
	        	String descripcion = columna.replace(text, "");
	        	
	        	if (descripcion.contains("Fecha")) {
	        	    descripcion = descripcion.replaceAll("Fecha([A-Z])", "Fecha de $1");
	        	}

	            if (descripcion.contains("Cod")) {
	                descripcion = descripcion.replace("Cod", "");
	            }
	            
	            if (descripcion.contains("Med")) {
	                descripcion = "Médico";
	            }
	            
	            if (descripcion.contains("Pac")) {
	                descripcion = "Paciente";
	            }

	            columnas.put(columna, descripcion);
	        }

	        return columnas;
	    }
}
