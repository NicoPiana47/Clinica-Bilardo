package negImpl;

import java.util.Date;
import java.util.List;
import java.util.Map;

import daoImpl.TurnosDao;
import entidades.Paciente;
import entidades.Turno;
import neg.ITurnosNegocio;

public class TurnosNegocio extends GeneralNegocio implements ITurnosNegocio{
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

	@Override
	public boolean buscarTurno(Date fecha, int codMed) {
		
		return tdao.buscarTurno(fecha, codMed);
	}

	@Override
    public Map<String, String> obtenerColumnas() {
        List<String> columnasList = tdao.getColumns();
        return super.obtenerColumnas("_TURN", columnasList);
    }

	@Override
	public List<Turno> obtenerTurnosPorFiltro(String columna, String text) {
		return tdao.getTurnosByFilter(columna, text);
	}

	@Override
	public boolean cambiarEstado(int codEstado, int codTurno) {
		return tdao.cambiarEstado(codEstado, codTurno);
	}
}
