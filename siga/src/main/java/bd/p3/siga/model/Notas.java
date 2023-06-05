package bd.p3.siga.model;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Notas {
	
	private String raAluno;
	private String codDisciplina;
	private int codAvaliacao;
	private double nota;
}
