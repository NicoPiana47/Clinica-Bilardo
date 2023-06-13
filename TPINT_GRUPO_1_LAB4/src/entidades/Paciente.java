package entidades;

import java.util.Date;

public class Paciente {
	private int codPac;
	private String DNI;
	private Provincia provincia;
	private Localidad localidad;
	private String nombre;
	private String apellido;
	private String correo;
	private String sexo;
	private String nacionalidad;
	private Date fechaNacimiento;
	private String direccion;
	private String telefono;
	private boolean estado;

	public Paciente() {
		localidad = new Localidad();
		provincia = new Provincia();
	}

	public Paciente(int codPac, String dni, Provincia provincia, Localidad localidad, String nombre, String apellido, 
			String correo, String sexo, String nacionalidad, Date fechaNacimiento, String direccion, String telefono,
		    boolean estado) {
		this.codPac = codPac;
		this.DNI = dni;
		this.provincia = provincia;
		this.localidad = localidad;
		this.nombre = nombre;
		this.apellido = apellido;
		this.correo = correo;
		this.sexo = sexo;
		this.nacionalidad = nacionalidad;
		this.fechaNacimiento = fechaNacimiento;
		this.direccion = direccion;
		this.telefono = telefono;
		this.estado = estado;
	}
	
	public Paciente(String dni, Provincia provincia, Localidad localidad, String nombre, String apellido, 
			String correo, String sexo, String nacionalidad, Date fechaNacimiento, String direccion, String telefono) {
		this.DNI = dni;
		this.provincia = provincia;
		this.localidad = localidad;
		this.nombre = nombre;
		this.apellido = apellido;
		this.correo = correo;
		this.sexo = sexo;
		this.nacionalidad = nacionalidad;
		this.fechaNacimiento = fechaNacimiento;
		this.direccion = direccion;
		this.telefono = telefono;
	}

	public int getCodPac() {
		return codPac;
	}
	public void setCodPac(int codPac) {
		this.codPac = codPac;
	}
	public String getDNI() {
		return DNI;
	}
	public void setDNI(String dNI) {
		DNI = dNI;
	}
	public Provincia getProvincia() {
		return provincia;
	}
	public void setProvincia(Provincia provincia) {
		this.provincia = provincia;
	}
	public Localidad getLocalidad() {
		return localidad;
	}
	public void setLocalidad(Localidad localidad) {
		this.localidad = localidad;
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
	public String getCorreo() {
		return correo;
	}
	public void setCorreo(String correo) {
		this.correo = correo;
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
	public boolean getEstado() {
		return estado;
	}
	public void setEstado(boolean estado) {
		this.estado = estado;
	}
	
	
}
