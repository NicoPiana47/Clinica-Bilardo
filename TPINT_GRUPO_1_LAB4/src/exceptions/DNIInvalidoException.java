package exceptions;

import java.io.IOException;

public class DNIInvalidoException extends IOException{

	public DNIInvalidoException() {
		
	}

	@Override
	public String getMessage() {
		return "El DNI es invalido";
	}
}
