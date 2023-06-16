package negImpl;

import java.util.List;

import daoImpl.TurnosDao;
import entidades.Turno;
import neg.ITurnosNegocio;

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

	@Override
	public boolean grabarTurno(Turno turno) {
		return tdao.grabarTurno(turno);
	}
}
