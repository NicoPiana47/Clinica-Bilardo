package negImpl;

import java.util.List;

import daoImpl.EstadoTurnoDao;
import entidades.EstadoTurno;
import neg.IEstadoTurnosNegocio;

public class EstadoTurnosNegocio implements IEstadoTurnosNegocio{
EstadoTurnoDao estDao = new EstadoTurnoDao();
	@Override
	public List<EstadoTurno> obtenerEstados() {
		return estDao.readAll();
	}

}
