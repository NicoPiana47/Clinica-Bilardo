package negImpl;

import neg.MedicosNegocio;


import dao.MedicosDao;
import daoImpl.MedicosDaoImpl;
import entidades.Medico;

public class MedicosNegocioImpl implements MedicosNegocio{
	MedicosDao mDao = new MedicosDaoImpl ();
	
	
	@Override
	public Medico iniciarSesion(String username, String contraseña) {
		Medico med = new Medico();
		
		if (!username.isEmpty() || !contraseña.isEmpty()) {
    		
			med= mDao.traerMedicoPorNombreUsuario(username);
			if(med != null && med.getContraseña_MED().equals(contraseña)) {
				return med;
			}
    	}
		
		return null;
	}

}
