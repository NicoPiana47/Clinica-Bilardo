package neg;
import entidades.Turno;

import java.sql.Date;
import java.util.List;

public interface ITurnosNegocio {
	 public List<Turno> obtenerTurnos();
	 public List<Turno> obtenerTurnosEntreFechas(String fechaDesde, String fechaHasta);
}
