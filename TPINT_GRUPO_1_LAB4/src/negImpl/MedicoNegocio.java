package negImpl;

import java.util.List;
import java.util.Map;

import daoImpl.MedicoDao;
import entidades.Medico;
import neg.IMedicoNegocio;

public class MedicoNegocio extends GeneralNegocio implements IMedicoNegocio{
	MedicoDao mDao = new MedicoDao();
	
	
	@Override
	public Medico iniciarSesion(String username, String contrase�a) {
		Medico med = new Medico();
		
		if (!username.isEmpty() || !contrase�a.isEmpty()) {
    		
			med= mDao.traerMedicoPorNombreUsuario(username);
			if(med != null && med.getContrase�a() != null && med.getContrase�a().equals(contrase�a)) {
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
        List<String> columnasList = mDao.getColumns();
        return super.obtenerColumnas("_MED", columnasList);
    }


	@Override
	public List<Medico> obtenerMedicosPorFiltro(String columna, String texto) {
		return mDao.getMedicosByFilter(columna, texto);
	}

}
