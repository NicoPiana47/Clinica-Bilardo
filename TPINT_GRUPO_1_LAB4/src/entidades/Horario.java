package entidades;

import java.time.LocalTime;

public class Horario implements Comparable<Horario>{
	private String dia;
	private LocalTime horarioDesde;
	private LocalTime horarioHasta;
	private boolean estado;

	public Horario(String dia, LocalTime horarioDesde, LocalTime horarioHasta, boolean estado) {
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

	public boolean isEstado() {
		return estado;
	}

	public void setEstado(boolean estado) {
		this.estado = estado;
	}

	@Override
	public int compareTo(Horario horario) {
		return this.dia.compareToIgnoreCase(horario.dia);
	}


}
