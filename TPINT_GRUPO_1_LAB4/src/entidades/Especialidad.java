package entidades;

public class Especialidad {
	private int codEspecialidad_ESP;
	private String descripcion_ESP;
	
	public Especialidad() {
		
	}
	public Especialidad(int codEspecialidad_ESP, String descripcion_ESP) {
		this.codEspecialidad_ESP = codEspecialidad_ESP;
		this.descripcion_ESP = descripcion_ESP;
	}

	
	public int getCodEspecialidad_ESP() {
		return codEspecialidad_ESP;
	}
	public void setCodEspecialidad_ESP(int codEspecialidad_ESP) {
		this.codEspecialidad_ESP = codEspecialidad_ESP;
	}
	public String getDescripcion_ESP() {
		return descripcion_ESP;
	}
	public void setDescripcion_ESP(String descripcion_ESP) {
		this.descripcion_ESP = descripcion_ESP;
	}

	@Override
	public String toString() {
		return "Especialidad [codEspecialidad_ESP=" + codEspecialidad_ESP + ", descripcion_ESP=" + descripcion_ESP
				+ "]";
	}
}
