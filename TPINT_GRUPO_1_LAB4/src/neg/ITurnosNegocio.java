package neg;
import entidades.Turno;

import java.util.Date;
import java.util.List;

public interface ITurnosNegocio {
	 public List<Turno> obtenerTurnos();
	 public List<Turno> obtenerTurnosEntreFechas(String fechaDesde, String fechaHasta);
	 public boolean grabarTurno(Turno turno);
	 public boolean buscarTurno(Date fecha, int codMed);
}
