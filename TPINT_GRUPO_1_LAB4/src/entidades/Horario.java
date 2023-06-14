package entidades;

import java.time.LocalTime;

public class Horario {
	private String dia;
	private LocalTime horarioDesde;
	private LocalTime horarioHasta;

	public Horario(String dia, LocalTime horarioDesde, LocalTime horarioHasta) {
		this.dia = dia;
		this.setHorarioDesde(horarioDesde);
		this.setHorarioHasta(horarioHasta);
	}

	public String getDia() {
		return dia;
	}

	public void setDia(String dia) {
		this.dia = dia;
	}

	public LocalTime getHorarioDesde() {
		return horarioDesde;
	}

	public void setHorarioDesde(LocalTime horarioDesde) {
		this.horarioDesde = horarioDesde;
	}

	public LocalTime getHorarioHasta() {
		return horarioHasta;
	}

	public void setHorarioHasta(LocalTime horarioHasta) {
		this.horarioHasta = horarioHasta;
	}



}
