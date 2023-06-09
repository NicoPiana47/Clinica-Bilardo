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
	            String descripcion = columna.replaceAll(text + "$", "")
	                    .replaceAll("([A-Z][a-z]+)([A-Z][a-z]+)", "$1 de $2")
	                    .replaceAll("([A-Z]+)([A-Z][a-z])", "$1 $2")
	                    .replaceAll("([a-z])([A-Z])", "$1 $2");

	            if (descripcion.contains("Cod")) {
	                descripcion = descripcion.replace("Cod", "Codigo");
	            }

	            columnas.put(columna, descripcion);
	        }

	        return columnas;
	    }


}
