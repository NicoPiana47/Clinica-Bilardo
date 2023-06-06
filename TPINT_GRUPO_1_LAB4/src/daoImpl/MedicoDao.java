package daoImpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import conexión.Conexion;
import dao.IMedicoDao;
import entidades.Medico;

public class MedicoDao implements IMedicoDao {


	public Medico traerMedicoPorNombreUsuario(String username) {		
		Connection cn = Conexion.getConexion().getSQLConexion();
		Medico x = new Medico();
		  try
		  {
			 String query = "select * from Medicos where Username_MED = ?";
			 
			 PreparedStatement st = cn.prepareStatement(query);
			 st.setString(1, username);
			 ResultSet rs = st.executeQuery();
			
			 while(rs.next()) {
					x.setCodMed(rs.getInt("CodMed_MED")); 
					x.setDNI(rs.getString("DNI_MED"));
					x.getEspecialidad().setCodEspecialidad_ESP(rs.getInt("CodEspecialidad_MED")); 
					x.getLocalidad().setCodLocalidad(rs.getInt("CodLocalidad_MED"));
					x.getLocalidad().getProvincia().setCodProvincia(rs.getInt("CodProvincia_MED"));
					x.setCorreo(rs.getString("Correo_MED")); 
					x.setUsername(rs.getString("Username_MED")); 
					x.setContraseña(rs.getString("Contraseña_MED")); 
					x.setNombre(rs.getString("Nombre_MED")); 
					x.setApellido(rs.getString("Apellido_MED"));
					x.setSexo(rs.getString("Sexo_MED")); 
					x.setNacionalidad(rs.getString("Nacionalidad_MED")); 
					x.setFechaNacimiento(rs.getDate("FechaNacimiento_MED"));
					x.setDireccion(rs.getString("Direccion_MED"));
					x.setTelefono(rs.getString("Telefono_MED"));
					x.setTipo(rs.getBoolean("Tipo_MED"));
					x.setEstado(rs.getBoolean("Estado_MED"));					
			 }				 
		  }
		  catch (Exception e) {
				e.printStackTrace();
		  }
		  finally  {
			  
		  }
		return x;
		
	}

}
