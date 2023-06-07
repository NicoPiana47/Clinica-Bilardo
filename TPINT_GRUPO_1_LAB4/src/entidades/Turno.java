package entidades;

import java.util.Date;

public class Turno {
	private int CodTurno;
	private Medico medico;
	private Paciente paciente;
	private EstadoTurno estado;
	private Date fechaTurno;
	
	
	public Turno() {
		medico = new Medico();
		paciente = new Paciente();
		estado = new EstadoTurno();
	}
	
	public int getCodTurno() {
		return CodTurno;
	}
	public void setCodTurno(int codTurno) {
		CodTurno = codTurno;
	}
	public Medico getMedico() {
		return medico;
	}
	public void setMedico(Medico medico) {
		this.medico = medico;
	}
	public Paciente getPaciente() {
		return paciente;
	}
	public void setPaciente(Paciente paciente) {
		this.paciente = paciente;
	}
	public EstadoTurno getEstado() {
		return estado;
	}
	public void setEstado(EstadoTurno estado) {
		this.estado = estado;
	}
	public Date getFechaTurno() {
		return fechaTurno;
	}
	public void setFechaTurno(Date fechaTurno) {
		this.fechaTurno = fechaTurno;
	}

	@Override
	public String toString() {
		return "Turno [CodTurno=" + CodTurno + ", medico=" + medico + ", paciente=" + paciente + ", estado=" + estado
				+ ", fechaTurno=" + fechaTurno + "]";
	}	
}
