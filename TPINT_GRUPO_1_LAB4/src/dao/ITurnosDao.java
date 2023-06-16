package dao;

import java.sql.Date;
import java.util.List;

import entidades.Turno;

public interface ITurnosDao{
	  public List<Turno> readAll(String fechaDesde, String fechaHasta);
	  public boolean grabarTurno(Turno turno);
}
