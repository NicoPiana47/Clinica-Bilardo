package entidades;

import java.util.Date;;

public class Medico {
	private int codMed;
	private String DNI;
    private Especialidad especialidad;
    private Localidad localidad;
    private Provincia provincia;
    private String correo;
    private String username;
    private String contraseña;
    private String nombre;
    private String apellido;
    private String sexo;
    private String nacionalidad;
    private Date fechaNacimiento;
    private String direccion;
    private String telefono;
    private boolean tipo;
    private boolean estado;
    
    
    public Medico() {
    	especialidad = new Especialidad();
    	localidad = new Localidad();
    	provincia = new Provincia();
    }
    
    //GETTERS AND SETTERS
    public int getCodMed() {
		return codMed;
	}
	public void setCodMed(int codMed) {
		this.codMed = codMed;
	}
	public String getDNI() {
		return DNI;
	}
	public void setDNI(String dNI) {
		DNI = dNI;
	}
	public Especialidad getEspecialidad() {
		return especialidad;
	}
	public void setEspecialidad(Especialidad especialidad) {
		this.especialidad = especialidad;
	}
	public Localidad getLocalidad() {
		return localidad;
	}
	public void setLocalidad(Localidad localidad) {
		this.localidad = localidad;
	}
	public Provincia getProvincia() {
		return provincia;
	}
	public void setProvincia(Provincia provincia) {
		this.provincia = provincia;
	}
	public String getCorreo() {
		return correo;
	}
	public void setCorreo(String correo) {
		this.correo = correo;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getContraseña() {
		return contraseña;
	}
	public void setContraseña(String contraseña) {
		this.contraseña = contraseña;
	}
	public String getNombre() {
		return nombre;
	}
	public void setNombre(String nombre) {
		this.nombre = nombre;
	}
	public String getApellido() {
		return apellido;
	}
	public void setApellido(String apellido) {
		this.apellido = apellido;
	}
	public String getSexo() {
		return sexo;
	}
	public void setSexo(String sexo) {
		this.sexo = sexo;
	}
	public String getNacionalidad() {
		return nacionalidad;
	}
	public void setNacionalidad(String nacionalidad) {
		this.nacionalidad = nacionalidad;
	}
	public Date getFechaNacimiento() {
		return fechaNacimiento;
	}
	public void setFechaNacimiento(Date fechaNacimiento) {
		this.fechaNacimiento = fechaNacimiento;
	}
	public String getDireccion() {
		return direccion;
	}
	public void setDireccion(String direccion) {
		this.direccion = direccion;
	}
	public String getTelefono() {
		return telefono;
	}
	public void setTelefono(String telefono) {
		this.telefono = telefono;
	}
	public boolean getTipo() {
		return tipo;
	}
	public void setTipo(boolean tipo) {
		this.tipo = tipo;
	}
	public boolean getEstado() {
		return estado;
	}
	public void setEstado(boolean estado) {
		this.estado = estado;
	}

	@Override
	public String toString() {
		return "Medico [codMed=" + codMed + ", DNI=" + DNI + ", especialidad=" + especialidad
				+ ", localidad=" + localidad + ", provincia=" + provincia + ", correo=" + correo
				+ ", username=" + username + ", contraseña=" + contraseña + ", nombre=" + nombre
				+ ", apellido=" + apellido + ", sexo=" + sexo + ", nacionalidad=" + nacionalidad
				+ ", fechaNacimiento=" + fechaNacimiento + ", direccion=" + direccion
				+ ", telefono=" + telefono + ", tipo=" + tipo + ", estado=" + estado + "]";
	}
	
}
