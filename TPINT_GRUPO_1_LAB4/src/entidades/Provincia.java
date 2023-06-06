package entidades;

public class Provincia {
	private int codProvincia;
	private String descripcion;
	
	public Provincia () {
		
	}
	
	public int getCodProvincia() {
		return codProvincia;
	}
	public void setCodProvincia(int codProvincia) {
		this.codProvincia = codProvincia;
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
