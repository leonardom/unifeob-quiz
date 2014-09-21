package br.edu.unifeob.quiz.model;

import java.io.Serializable;
import java.util.List;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

/**
 * 
 * @author Leonardo Marcelino
 *
 */
@Entity
@Table(name="perguntas")
public class Pergunta implements Serializable {

	private static final long serialVersionUID = 2090696352604862496L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Long id;

	private String descricao;

	@OneToMany(mappedBy = "pergunta")
	private List<OpcaoResposta> opcoesResposta;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getDescricao() {
		return descricao;
	}

	public void setDescricao(String descricao) {
		this.descricao = descricao;
	}

	public List<OpcaoResposta> getOpcoes() {
		return opcoesResposta;
	}

	public void setOpcoes(List<OpcaoResposta> opcoes) {
		this.opcoesResposta = opcoes;
	}
}