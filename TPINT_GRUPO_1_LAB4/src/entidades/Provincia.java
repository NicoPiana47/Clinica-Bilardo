package entidades;

public class Provincia {
	private int codProvincia_PROV;
	private String descripcion_PROV;
	
	public Provincia () {
		
	}
	
	public int getCodProvincia_PROV() {
		return codProvincia_PROV;
	}
	public void setCodProvincia_PROV(int codProvincia_PROV) {
		this.codProvincia_PROV = codProvincia_PROV;
	}
	public String getDescripcion_PROV() {
		return descripcion_PROV;
	}
	public void setDescripcion_PROV(String descripcion_PROV) {
		this.descripcion_PROV = descripcion_PROV;
	}

	@Override
	public String toString() {
		return "Provincia [codProvincia_PROV=" + codProvincia_PROV + ", descripcion_PROV=" + descripcion_PROV + "]";
	}
	
	
}
