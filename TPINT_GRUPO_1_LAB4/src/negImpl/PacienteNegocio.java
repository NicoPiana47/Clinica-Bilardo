package negImpl;

import java.util.List;

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

}
