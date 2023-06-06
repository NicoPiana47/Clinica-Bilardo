package daoImpl;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;


import conexión.Conexion;
import dao.MedicosDao;
import entidades.Medico;

public class MedicosDaoImpl implements MedicosDao {


	@Override
	public Medico traerMedicoPorNombreUsuario(String username) {		
		Connection cn = Conexion.getConexion().getSQLConexion();
		Medico x = new Medico();
		  try
		  {
			 Class.forName("com.mysql.jdbc.Driver");
			 String query = "select * from Medicos where Username_MED = ?";
			 
			 PreparedStatement st = cn.prepareStatement(query);
			 st.setString(1, username);
			 ResultSet rs = st.executeQuery();
			
			 while(rs.next()) {
					x.setCodMed_MED(rs.getInt("CodMed_MED")); 
					x.setDNI_MED(rs.getString("DNI_MED"));
					x.getEspecialidad_MED().setCodEspecialidad_ESP(rs.getInt("CodEspecialidad_MED")); 
					x.getLocalidad_MED().setCodLocalidad_LOC(rs.getInt("CodLocalidad_MED"));
					x.getLocalidad_MED().getProvincia_LOC().setCodProvincia_PROV(rs.getInt("CodProvincia_MED"));
					x.setCorreo_MED(rs.getString("Correo_MED")); 
					x.setUsername_MED(rs.getString("Username_MED")); 
					x.setContraseña_MED(rs.getString("Contraseña_MED")); 
					x.setNombre_MED(rs.getString("Nombre_MED")); 
					x.setApellido_MED(rs.getString("Apellido_MED"));
					x.setSexo_MED(rs.getString("Sexo_MED")); 
					x.setNacionalidad_MED(rs.getString("Nacionalidad_MED")); 
					x.setFechaNacimiento_MED(rs.getDate("FechaNacimiento_MED"));
					x.setDireccion_MED(rs.getString("Direccion_MED"));
					x.setTelefono_MED(rs.getString("Telefono_MED"));
					x.setTipo_MED(rs.getBoolean("Tipo_MED"));
					x.setEstado_MED(rs.getBoolean("Estado_MED"));					
			 }				 
		  }
		  catch (Exception e) {
				e.printStackTrace();
			}
			  finally {
					try {
						cn.close();
					} catch (SQLException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				}
		return x;
		
	}

}
