package bd.p3.siga.model;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class AlunoNota {
	
	private String ra;
	private String nome;
	private double nota1;
	private double nota2;
	private double nota3;
	private double media;
	private String situacao;
	
}
