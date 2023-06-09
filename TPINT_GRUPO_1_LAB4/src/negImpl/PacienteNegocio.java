package negImpl;

import java.util.List;
import java.util.Map;

import daoImpl.PacienteDao;
import entidades.Paciente;
import neg.IPacienteNegocio;

public class PacienteNegocio extends GeneralNegocio implements IPacienteNegocio{
	
	PacienteDao pDao = new PacienteDao();
	
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
		return pDao.readAll();
	}
	
	@Override
    public Map<String, String> obtenerColumnas() {
        List<String> columnasList = pDao.getColumns();
        return super.obtenerColumnas("_PAC", columnasList);
    }

	@Override
	public List<Paciente> obtenerPacientesPorFiltro(String columna, String texto) {
		return pDao.getPacientesByFilter(columna, texto);
	}


}
