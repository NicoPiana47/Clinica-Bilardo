package negImpl;

import neg.MedicosNegocio;


import dao.MedicosDao;
import daoImpl.MedicosDaoImpl;
import entidades.Medico;

public class MedicosNegocioImpl implements MedicosNegocio{
	MedicosDao mDao = new MedicosDaoImpl ();
	
	
	@Override
	public Medico iniciarSesion(String username, String contrase�a) {
		Medico med = new Medico();
		
		if (!username.isEmpty() || !contrase�a.isEmpty()) {
    		
			med= mDao.traerMedicoPorNombreUsuario(username);
			if(med != null && med.getContrase�a_MED().equals(contrase�a)) {
				return med;
			}
    	}
		
		return null;
	}

}
