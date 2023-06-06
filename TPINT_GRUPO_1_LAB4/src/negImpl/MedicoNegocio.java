package negImpl;

import daoImpl.MedicoDao;
import entidades.Medico;
import neg.IMedicoNegocio;

public class MedicoNegocio implements IMedicoNegocio{
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

}
