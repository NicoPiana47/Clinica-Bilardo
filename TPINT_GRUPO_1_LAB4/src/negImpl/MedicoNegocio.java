package negImpl;

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

}
