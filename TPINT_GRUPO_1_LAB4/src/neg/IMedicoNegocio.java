package neg;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import entidades.Medico;
import exceptions.DNIInvalidoException;
import exceptions.MailInvalidoException;


public interface IMedicoNegocio {
	public Medico iniciarSesion(String usurname, String contraseña);
	public List<Medico>obtenerMedicosPorFiltro(String columna, String texto);
	public Map<String, String> obtenerColumnas();
	public Medico getMedico(HttpServletRequest request,boolean isCreating);
	public int editarMedico(Medico medico) throws DNIInvalidoException, MailInvalidoException;
	public boolean eliminarMedico(int codMed);
	public int crearMedico(Medico medico) throws DNIInvalidoException, MailInvalidoException;
	public List<Medico> obtenerMedicos(boolean sinInactivos);
	public Medico obtenerMedicoPorUsername(String username);
	
	
	
}
