package dao;

import java.util.Date;
import java.util.List;

import entidades.Turno;

public interface ITurnosDao{
	  public List<Turno> readAll(String fechaDesde, String fechaHasta);
	  public boolean grabarTurno(Turno turno);
	  public boolean buscarTurno(Date fecha, int codMed);
}
