package negImpl;

import java.sql.Date;
import java.util.List;

import entidades.Turno;
import neg.ITurnosNegocio;

import daoImpl.TurnosDao;

public class TurnosNegocio implements ITurnosNegocio{
	TurnosDao tdao = new TurnosDao();
	@Override
	public List<Turno> obtenerTurnos() {				
		return tdao.readAll(null, null);		
	}
	
	

	@Override
	public List<Turno> obtenerTurnosEntreFechas(String fechaDesde, String fechaHasta) {
		return tdao.readAll(fechaDesde, fechaHasta);	
	}

}
