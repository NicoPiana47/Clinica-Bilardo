package daoImpl;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import conexión.Conexion;
import dao.ITurnosDao;
import entidades.Turno;

public class TurnosDao extends GeneralDao implements ITurnosDao{
	private static final String consultaSinFechas = 
				"SELECT t.CodTurno_TURN, t.CodPac_TURN, m.Nombre_MED, m.Apellido_MED, p.Nombre_PAC, p.Apellido_PAC, t.FechaTurno_TURN, e.Descripcion_EST " + 
				"FROM Turnos t " + 
				"INNER JOIN Medicos m ON t.CodMed_TURN = m.CodMed_MED " + 
				"INNER JOIN Pacientes p ON t.CodPac_TURN = p.CodPac_PAC " + 
				"INNER JOIN EstadosTurno e ON t.CodEstado_TURN = e.CodEstado_EST ";
	
	private String consultaConFechas = "SELECT CodTurno_TURN, CodPac_TURN, Nombre_MED, Apellido_MED, Nombre_PAC, Apellido_PAC, FechaTurno_TURN, Descripcion_EST " +
            "FROM Turnos " +
            "INNER JOIN Medicos ON CodMed_TURN = CodMed_MED " +
            "INNER JOIN Pacientes ON CodPac_TURN = CodPac_PAC " +
            "INNER JOIN EstadosTurno ON CodEstado_TURN = CodEstado_EST" +
            " WHERE ";
	private static final String insert = "INSERT INTO Turnos(CodMed_TURN, CodPac_TURN, CodEstado_TURN, FechaTurno_TURN) VALUES(?, ?, ?, ?)";
	private static final String search = "SELECT CASE WHEN EXISTS (SELECT * FROM TURNOS WHERE FechaTurno_TURN = ? AND CodMed_TURN = ?) THEN 1 ELSE 0 END AS Resultado;";
	private static final String changeEstado = "UPDATE Turnos SET CodEstado_TURN = ? WHERE CodTurno_TURN = ?";

	@Override
	public List<Turno> readAll(String fechaDesde, String fechaHasta, int codMed) {
		 List<Turno> turnos = new ArrayList<>();

	        try {
	        	 Connection conexion = Conexion.getConexion().getSQLConexion();
	        	 PreparedStatement statement = null;
	        	 if(fechaDesde == null || fechaHasta == null) {
	        		 statement = conexion.prepareStatement(consultaSinFechas);
	        		 if(codMed != -1)
	        			 statement = conexion.prepareStatement(consultaSinFechas + " WHERE CodMed_MED = " + codMed);
	        	 }
	        	 else {
	        		 if(codMed != -1) 
	        			 statement = conexion.prepareStatement(consultaConFechas + " CodMed_MED = " + codMed + " AND ");
	        		 
	        		 
	        		 if(fechaDesde.equals("") && !fechaHasta.equals("") ){
	        			 Date fechaHastaParam = Date.valueOf(fechaHasta);
	        			 statement = conexion.prepareStatement(consultaConFechas + "FechaTurno_TURN < ?");
	        			 statement.setDate(1, fechaHastaParam);
	        		 }
	        		 
	        		 else if(!fechaDesde.equals("") && fechaHasta.equals("") ){
	        			 Date fechaDesdeParam = Date.valueOf(fechaDesde);
	        			 statement = conexion.prepareStatement(consultaConFechas + "FechaTurno_TURN > ?");
	        			 statement.setDate(1, fechaDesdeParam);
	        		 }
	        		 
	        		 else {
	        			 Date fechaDesdeParam = Date.valueOf(fechaDesde);
	        			 Date fechaHastaParam = Date.valueOf(fechaHasta);
	        			 statement = conexion.prepareStatement(consultaConFechas + "FechaTurno_TURN > ? AND FechaTurno_TURN < ?");
	        			 statement.setDate(1, fechaDesdeParam);
	        			 statement.setDate(2, fechaHastaParam);
	        		 }
	        	 }
	        	   	 
	             ResultSet resultSet = statement.executeQuery();
	             while (resultSet.next()) {
	            	 int codTurno = resultSet.getInt("CodTurno_TURN");
	            	 int codPac = resultSet.getInt("CodPac_TURN");
	                 String nombreMedico = resultSet.getString("Nombre_MED");
	                 String nombrePaciente = resultSet.getString("Nombre_PAC");
	                 String apellidoMedico = resultSet.getString("Apellido_MED");
	                 String apellidoPaciente = resultSet.getString("Apellido_PAC");
	                 java.sql.Timestamp fechaTurnoTimestamp = resultSet.getTimestamp("FechaTurno_TURN");
	                 String descripcionEstado = resultSet.getString("Descripcion_EST");
	                 
	                 Date fechaTurno = new Date(fechaTurnoTimestamp.getTime());
	                 Turno turno = new Turno();
	                 
	                 turno.setCodTurno(codTurno);
	                 turno.getMedico().setNombre(nombreMedico);
	                 turno.getMedico().setApellido(apellidoMedico);
	                 turno.getPaciente().setCodPac(codPac);
	                 turno.getPaciente().setNombre(nombrePaciente);
	                 turno.getPaciente().setApellido(apellidoPaciente);
	                 turno.getEstado().setDescripcion_EST(descripcionEstado);
	                 turno.setFechaTurno(fechaTurno);
	                 
	                 turnos.add(turno);
	             }
	        } 
	        catch (Exception e) {
				e.printStackTrace();
	        }
		  finally  {
			  
		  }
		return turnos;
	}

	@Override
	public boolean grabarTurno(Turno turno) {
		 PreparedStatement statement;
		    Connection conexion = Conexion.getConexion().getSQLConexion();
		    boolean isInsert = false;
		    try {
		        statement = conexion.prepareStatement(insert);
		        statement.setInt(1, turno.getMedico().getCodMed());
		        statement.setInt(2, turno.getPaciente().getCodPac());
		        statement.setInt(3, turno.getEstado().getCodEstado_EST());
		        java.sql.Timestamp sqlFechaTurno = new java.sql.Timestamp(turno.getFechaTurno().getTime());
		        
		        statement.setTimestamp(4, sqlFechaTurno);


		        if (statement.executeUpdate() > 0) {
		            conexion.commit();
		            isInsert = true;
		        }
		    } catch (SQLException e) {
		        e.printStackTrace();
		    }

		    return isInsert;
	}

	@Override
	public boolean buscarTurno(java.util.Date fecha, int codMed) {
		Connection cn = Conexion.getConexion().getSQLConexion();
		boolean existe = true;
		  try
		  {
	 		 PreparedStatement st = cn.prepareStatement(search);
	 		 java.sql.Timestamp sqlFechaTurno = new java.sql.Timestamp(fecha.getTime());   
	 		 st.setTimestamp(1, sqlFechaTurno);
	 		 
			 st.setInt(2, codMed);
			 ResultSet rs = st.executeQuery();
			
			 while(rs.next()) {
				 existe = rs.getBoolean("Resultado");		
			 }				 
		  }
		  catch (Exception e) {
				e.printStackTrace();
		  }
		  finally  {
			  
		  }
		return existe;	
	}
	
	@Override
	public List<String> getColumns() {
	    String[] columnasCodigo = {"CodTurno_TURN", "CodMed_TURN"};
		return super.getColumns("turnos", columnasCodigo);
	}

	@Override
	public List<Turno> getTurnosByFilter(String column, String text, int codMed) {
		
		PreparedStatement statement;
		ResultSet resultSet; 
		ArrayList<Turno> turnos = new ArrayList<Turno>();
		Connection conexion = Conexion.getConexion().getSQLConexion();
		
		try{
			String query = createQueryFiltersTurnos(column);
			
			if(codMed != -1)
				query +=  " AND CodMed_TURN = " + codMed;
			
			statement = conexion.prepareStatement(query);
	        statement.setString(1, "%" + text + "%");
	        
	        resultSet = statement.executeQuery();      
			
			while(resultSet.next()){
				 int codTurno = resultSet.getInt("CodTurno_TURN");
            	 int codPac = resultSet.getInt("CodPac_TURN");
                 String nombreMedico = resultSet.getString("Nombre_MED");
                 String nombrePaciente = resultSet.getString("Nombre_PAC");
                 String apellidoMedico = resultSet.getString("Apellido_MED");
                 String apellidoPaciente = resultSet.getString("Apellido_PAC");
                 java.sql.Timestamp fechaTurnoTimestamp = resultSet.getTimestamp("FechaTurno_TURN");
                 String descripcionEstado = resultSet.getString("Descripcion_EST");
                 
                 Date fechaTurno = new Date(fechaTurnoTimestamp.getTime());
                 Turno turno = new Turno();
                 
                 turno.setCodTurno(codTurno);
                 turno.getMedico().setNombre(nombreMedico);
                 turno.getMedico().setApellido(apellidoMedico);
                 turno.getPaciente().setCodPac(codPac);
                 turno.getPaciente().setNombre(nombrePaciente);
                 turno.getPaciente().setApellido(apellidoPaciente);
                 turno.getEstado().setDescripcion_EST(descripcionEstado);
                 turno.setFechaTurno(fechaTurno);
                
                turnos.add(turno);
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
		
		return turnos;
	}
	
	private String createQueryFiltersTurnos(String column) {
	    Map<String, String> columnMappings = new HashMap<>();
	    String query = consultaSinFechas;

	    columnMappings.put("CodMed_TURN", " WHERE m.Nombre_MED LIKE ?");
	    columnMappings.put("CodPac_TURN", " WHERE p.Nombre_PAC LIKE ?");
	    columnMappings.put("CodEstado_TURN", " WHERE e.Descripcion_EST LIKE ?");
	    
	    if (columnMappings.containsKey(column)) {
	        query += columnMappings.get(column);
	    } else {
	        query += " WHERE " + column + " LIKE ?";
	    }

	    return query;
	}

	@Override
	public boolean cambiarEstado(int codEstado, int codTurno) {
		PreparedStatement statement;
		Connection conexion = Conexion.getConexion().getSQLConexion();
		boolean isUpdate = false;
		try{
			statement = conexion.prepareStatement(changeEstado);
			statement.setInt(1, codEstado);
		    statement.setInt(2, codTurno);
		   
			
			if(statement.executeUpdate() > 0){
				conexion.commit();
				isUpdate = true;
			}
		} 
		catch (SQLException e) {
			e.printStackTrace();
		}
		
		return isUpdate;
	}	
}
