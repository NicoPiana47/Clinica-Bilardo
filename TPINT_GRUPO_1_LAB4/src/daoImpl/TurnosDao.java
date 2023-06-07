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
import entidades.Paciente;
import entidades.Turno;

public class TurnosDao implements ITurnosDao{
	private static final String consultaSinFechas = "SELECT Nombre_MED, Nombre_PAC, FechaTurno_TURN, Descripcion_EST " +
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
	                 java.sql.Timestamp fechaTurnoTimestamp = resultSet.getTimestamp("FechaTurno_TURN");
	                 String descripcionEstado = resultSet.getString("Descripcion_EST");
	
	                 /*Medico medico = new Medico();
	                 medico.setNombre(nombreMedico);
	
	                 Paciente paciente = new Paciente();
	                 paciente.setNombre(nombrePaciente);
	 
	                 EstadoTurno estado = new EstadoTurno();
	                 estado.setDescripcion_EST(descripcionEstado);
	
	                 Turno turno = new Turno();
	                 turno.setMedico(medico);
	                 turno.setPaciente(paciente);
	                 turno.setFechaTurno(fechaTurno);
	                 turno.setEstado(estado);*/
	                 
	                 Date fechaTurno = new Date(fechaTurnoTimestamp.getTime());
	                 Turno turno = new Turno();
	                 
	                 turno.getMedico().setNombre(nombreMedico);
	                 turno.getPaciente().setNombre(nombrePaciente);
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
	
}
