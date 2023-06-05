package entidades;

public class Localidad {
	private int codLocalidad_LOC;
	private Provincia provincia_LOC;
	private String descripcion_LOC;
	
	public Localidad() {
		
	}

	public int getCodLocalidad_LOC() {
		return codLocalidad_LOC;
	}

	public void setCodLocalidad_LOC(int codLocalidad_LOC) {
		this.codLocalidad_LOC = codLocalidad_LOC;
	}

	public Provincia getProvincia_LOC() {
		return provincia_LOC;
	}

	public void setProvincia_LOC(Provincia provincia_LOC) {
		this.provincia_LOC = provincia_LOC;
	}

	public String getDescripcion_LOC() {
		return descripcion_LOC;
	}

	public void setDescripcion_LOC(String descripcion_LOC) {
		this.descripcion_LOC = descripcion_LOC;
	}

	@Override
	public String toString() {
		return "Localidad [codLocalidad_LOC=" + codLocalidad_LOC + ", provincia_LOC=" + provincia_LOC
				+ ", descripcion_LOC=" + descripcion_LOC + "]";
	}
	
	
}
