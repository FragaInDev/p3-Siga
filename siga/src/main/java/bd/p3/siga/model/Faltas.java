package bd.p3.siga.model;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Faltas {
	
	private String raAluno;
	private String codDisciplina;
	private String data;
	private int presenca;
}
