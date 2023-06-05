package entidades;

public class Medico {
	private int codMed_MED;
	private String DNI_MED;
    private Especialidad especialidad_MED;
    private Localidad localidad_MED;
    private Provincia provincia_MED;
    private String correo_MED;
    private String username_MED;
    private String contraseña_MED;
    private String nombre_MED;
    private String apellido_MED;
    private String sexo_MED;
    private String nacionalidad_MED;
    private String fechaNacimiento_MED;
    private String direccion_MED;
    private String telefono_MED;
    private boolean tipo_MED;
    private boolean estado_MED;
    
    
    public Medico() {
    	
    }
    
    //GETTERS AND SETTERS
    public int getCodMed_MED() {
		return codMed_MED;
	}
	public void setCodMed_MED(int codMed_MED) {
		this.codMed_MED = codMed_MED;
	}
	public String getDNI_MED() {
		return DNI_MED;
	}
	public void setDNI_MED(String dNI_MED) {
		DNI_MED = dNI_MED;
	}
	public Especialidad getEspecialidad_MED() {
		return especialidad_MED;
	}
	public void setEspecialidad_MED(Especialidad especialidad_MED) {
		this.especialidad_MED = especialidad_MED;
	}
	public Localidad getLocalidad_MED() {
		return localidad_MED;
	}
	public void setLocalidad_MED(Localidad localidad_MED) {
		this.localidad_MED = localidad_MED;
	}
	public Provincia getProvincia_MED() {
		return provincia_MED;
	}
	public void setProvincia_MED(Provincia provincia_MED) {
		this.provincia_MED = provincia_MED;
	}
	public String getCorreo_MED() {
		return correo_MED;
	}
	public void setCorreo_MED(String correo_MED) {
		this.correo_MED = correo_MED;
	}
	public String getUsername_MED() {
		return username_MED;
	}
	public void setUsername_MED(String username_MED) {
		this.username_MED = username_MED;
	}
	public String getContraseña_MED() {
		return contraseña_MED;
	}
	public void setContraseña_MED(String contraseña_MED) {
		this.contraseña_MED = contraseña_MED;
	}
	public String getNombre_MED() {
		return nombre_MED;
	}
	public void setNombre_MED(String nombre_MED) {
		this.nombre_MED = nombre_MED;
	}
	public String getApellido_MED() {
		return apellido_MED;
	}
	public void setApellido_MED(String apellido_MED) {
		this.apellido_MED = apellido_MED;
	}
	public String getSexo_MED() {
		return sexo_MED;
	}
	public void setSexo_MED(String sexo_MED) {
		this.sexo_MED = sexo_MED;
	}
	public String getNacionalidad_MED() {
		return nacionalidad_MED;
	}
	public void setNacionalidad_MED(String nacionalidad_MED) {
		this.nacionalidad_MED = nacionalidad_MED;
	}
	public String getFechaNacimiento_MED() {
		return fechaNacimiento_MED;
	}
	public void setFechaNacimiento_MED(String fechaNacimiento_MED) {
		this.fechaNacimiento_MED = fechaNacimiento_MED;
	}
	public String getDireccion_MED() {
		return direccion_MED;
	}
	public void setDireccion_MED(String direccion_MED) {
		this.direccion_MED = direccion_MED;
	}
	public String getTelefono_MED() {
		return telefono_MED;
	}
	public void setTelefono_MED(String telefono_MED) {
		this.telefono_MED = telefono_MED;
	}
	public boolean isTipo_MED() {
		return tipo_MED;
	}
	public void setTipo_MED(boolean tipo_MED) {
		this.tipo_MED = tipo_MED;
	}
	public boolean isEstado_MED() {
		return estado_MED;
	}
	public void setEstado_MED(boolean estado_MED) {
		this.estado_MED = estado_MED;
	}

	@Override
	public String toString() {
		return "Medico [codMed_MED=" + codMed_MED + ", DNI_MED=" + DNI_MED + ", especialidad_MED=" + especialidad_MED
				+ ", localidad_MED=" + localidad_MED + ", provincia_MED=" + provincia_MED + ", correo_MED=" + correo_MED
				+ ", username_MED=" + username_MED + ", contraseña_MED=" + contraseña_MED + ", nombre_MED=" + nombre_MED
				+ ", apellido_MED=" + apellido_MED + ", sexo_MED=" + sexo_MED + ", nacionalidad_MED=" + nacionalidad_MED
				+ ", fechaNacimiento_MED=" + fechaNacimiento_MED + ", direccion_MED=" + direccion_MED
				+ ", telefono_MED=" + telefono_MED + ", tipo_MED=" + tipo_MED + ", estado_MED=" + estado_MED + "]";
	}
	
}
