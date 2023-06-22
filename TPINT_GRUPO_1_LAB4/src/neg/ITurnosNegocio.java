package neg;
import entidades.Paciente;
import entidades.Turno;

import java.util.Date;
import java.util.List;
import java.util.Map;

public interface ITurnosNegocio {
	 public List<Turno> obtenerTurnos();
	 public List<Turno> obtenerTurnosEntreFechas(String fechaDesde, String fechaHasta);
	 public boolean grabarTurno(Turno turno);
	 public boolean buscarTurno(Date fecha, int codMed);
	 public Map<String, String> obtenerColumnas();
	 public List<Turno> obtenerTurnosPorFiltro(String columna, String text);
	 public boolean cambiarEstado(int codEstado, int codTurno);
}
