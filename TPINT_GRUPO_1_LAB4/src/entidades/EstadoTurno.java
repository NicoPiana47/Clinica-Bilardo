package entidades;

public class EstadoTurno {
	private int codEstado_EST;
	private String descripcion_EST;
	
	public EstadoTurno() {}
	public EstadoTurno(int c, String d) {
		this.codEstado_EST = c;
		this.descripcion_EST = d;
	}
	
	public int getCodEstado_EST() {
		return codEstado_EST;
	}
	public void setCodEstado_EST(int codEstado_EST) {
		this.codEstado_EST = codEstado_EST;
	}
	public String getDescripcion_EST() {
		return descripcion_EST;
	}
	public void setDescripcion_EST(String descripcion_EST) {
		this.descripcion_EST = descripcion_EST;
	}
	@Override
	public String toString() {
		return "EstadoTurno [codEstado_EST=" + codEstado_EST + ", descripcion_EST=" + descripcion_EST + "]";
	}
	
}
