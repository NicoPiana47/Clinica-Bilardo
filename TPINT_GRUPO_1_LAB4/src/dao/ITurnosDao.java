package dao;

import java.util.Date;
import java.util.List;

import entidades.Paciente;
import entidades.Turno;

public interface ITurnosDao{
	  public List<Turno> readAll(String fechaDesde, String fechaHasta, int codMed);
	  public boolean grabarTurno(Turno turno);
	  public boolean buscarTurno(Date fecha, int codMed);
	  public List<String> getColumns();
	  public List<Turno> getTurnosByFilter(String column, String text, int codMed);
	  public boolean cambiarEstado(int codEstado, int codTurno);
}
