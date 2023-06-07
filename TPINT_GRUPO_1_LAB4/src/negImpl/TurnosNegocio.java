package negImpl;

import java.util.List;

import entidades.Turno;
import neg.ITurnosNegocio;

import daoImpl.TurnosDao;

public class TurnosNegocio implements ITurnosNegocio{
	TurnosDao tdao = new TurnosDao();
	@Override
	public List<Turno> obtenerTurnos() {
		
		
		return tdao.readAll();
		
		
	}

}
