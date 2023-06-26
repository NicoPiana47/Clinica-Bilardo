package exceptions;

import java.io.IOException;

public class MailInvalidoException extends IOException{

	public MailInvalidoException() {
		
	}

	@Override
	public String getMessage() {
		return "El Mail es invalido";
	}
}
