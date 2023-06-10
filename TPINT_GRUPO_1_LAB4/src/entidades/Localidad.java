package entidades;

public class Localidad {
	private int codLocalidad;
	private Provincia provincia;
	private String descripcion;
	
	public Localidad() {
		provincia = new Provincia();
	}

	public Localidad(int codLocalidad, String descripcion, Provincia provincia) {
		this.codLocalidad = codLocalidad;
		this.descripcion = descripcion;
		this.provincia = provincia;
	}

	public int getCodLocalidad() {
		return codLocalidad;
	}

	public void setCodLocalidad(int codLocalidad) {
		this.codLocalidad = codLocalidad;
	}

	public Provincia getProvincia() {
		return provincia;
	}

	public void setProvincia(Provincia provincia) {
		this.provincia = provincia;
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
