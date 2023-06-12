package entidades;

public class Especialidad {
	private int codEspecialidad;
	private String descripcion;
	
	public Especialidad() {
		
	}
	public Especialidad(int codEspecialidad, String descripcion) {
		this.codEspecialidad = codEspecialidad;
		this.descripcion = descripcion;
	}

	public int getCodEspecialidad() {
		return codEspecialidad;
	}
	public void setCodEspecialidad(int codEspecialidad) {
		this.codEspecialidad = codEspecialidad;
	}
	public String getDescripcion() {
		return descripcion;
	}
	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
	}

	@Override
	public String toString() {
		return descripcion;
	}
}
