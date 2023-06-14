package negImpl;

import java.util.List;

import daoImpl.EspecialidadDao;
import entidades.Especialidad;
import neg.IEspecialidadNegocio;

public class EspecialidadNegocio implements IEspecialidadNegocio {
	EspecialidadDao edao=new EspecialidadDao();
	
	@Override
	public List<Especialidad> obtenerEspecialidades() {
		return edao.readAll();
	}
}
