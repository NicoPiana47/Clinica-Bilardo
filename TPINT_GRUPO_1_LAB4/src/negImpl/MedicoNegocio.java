package negImpl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import daoImpl.MedicoDao;
import entidades.Medico;
import neg.IMedicoNegocio;

public class MedicoNegocio implements IMedicoNegocio{
	MedicoDao mDao = new MedicoDao();
	
	
	@Override
	public Medico iniciarSesion(String username, String contraseña) {
		Medico med = new Medico();
		
		if (!username.isEmpty() || !contraseña.isEmpty()) {
    		
			med= mDao.traerMedicoPorNombreUsuario(username);
			if(med != null && med.getContraseña() != null && med.getContraseña().equals(contraseña)) {
				return med;
			}
    	}
		
		return null;
	}


	@Override
	public List<Medico> obtenerMedicos() {
		return mDao.readAll();
	}


	@Override
	public Map<String, String> obtenerColumnas() {
		  Map<String, String> columnas = new HashMap<>();

		    try {
		    	List<String> columnasList = mDao.getColumns();
		        
		    	 for (String columna : columnasList) {
	                String descripcion = columna.replaceAll("_MED$", "")
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
	public List<Medico> obtenerMedicosPorFiltro(String columna, String texto) {
		return mDao.getMedicosByFilter(columna, texto);
	}

}
