package daoImpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.sql.Date;
import java.util.List;

import conexión.Conexion;
import dao.ITurnosDao;
import entidades.EstadoTurno;
import entidades.Medico;
import entidades.MedicosXDias;
import entidades.Paciente;
import entidades.Turno;

public class TurnosDao implements ITurnosDao{
	private static final String consultaSinFechas = "SELECT Nombre_MED, Apellido_MED, Nombre_PAC, Apellido_PAC, FechaTurno_TURN, Descripcion_EST " +
            "FROM Turnos " +
            "INNER JOIN Medicos ON CodMed_TURN = CodMed_MED " +
            "INNER JOIN Pacientes ON CodPac_TURN = CodPac_PAC " +
            "INNER JOIN EstadosTurno ON CodEstado_TURN = CodEstado_EST";
	
	private String consultaConFechas = "SELECT Nombre_MED, Nombre_PAC, FechaTurno_TURN, Descripcion_EST " +
            "FROM Turnos " +
            "INNER JOIN Medicos ON CodMed_TURN = CodMed_MED " +
            "INNER JOIN Pacientes ON CodPac_TURN = CodPac_PAC " +
            "INNER JOIN EstadosTurno ON CodEstado_TURN = CodEstado_EST" +
            " WHERE ";
	private static final String insert = "INSERT INTO Turnos(CodMed_TURN, CodPac_TURN, CodEstado_TURN, FechaTurno_TURN) VALUES(?, ?, ?, ?)";
	private static final String search = "SELECT CASE WHEN EXISTS (SELECT * FROM TURNOS WHERE FechaTurno_TURN = ? AND CodMed_TURN = ?) THEN 1 ELSE 0 END AS Resultado;";

	@Override
	public List<Turno> readAll(String fechaDesde, String fechaHasta) {
		 List<Turno> turnos = new ArrayList<>();

	        try {
	        	 Connection conexion = Conexion.getConexion().getSQLConexion();
	        	 PreparedStatement statement = null;
	        	 if(fechaDesde == null || fechaHasta == null)
	        		 statement = conexion.prepareStatement(consultaSinFechas);
	        	 
	        	 else if(fechaDesde.equals("") && !fechaHasta.equals("") ){
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
	        	 	        	 
	             ResultSet resultSet = statement.executeQuery();
	             while (resultSet.next()) {
	                 String nombreMedico = resultSet.getString("Nombre_MED");
	                 String nombrePaciente = resultSet.getString("Nombre_PAC");
	                 String apellidoMedico = resultSet.getString("Apellido_MED");
	                 String apellidoPaciente = resultSet.getString("Apellido_PAC");
	                 java.sql.Timestamp fechaTurnoTimestamp = resultSet.getTimestamp("FechaTurno_TURN");
	                 String descripcionEstado = resultSet.getString("Descripcion_EST");
	                 
	                 Date fechaTurno = new Date(fechaTurnoTimestamp.getTime());
	                 Turno turno = new Turno();
	                 
	                 turno.getMedico().setNombre(nombreMedico);
	                 turno.getMedico().setApellido(apellidoMedico);
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
}
