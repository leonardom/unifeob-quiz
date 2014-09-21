package br.edu.unifeob.quiz.model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

/**
 * 
 * @author Leonardo Marcelino
 */
@Entity
@Table(name="pontuacoes")
public class Pontuacao implements Serializable {

	private static final long serialVersionUID = 5723308421968649143L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Long id;
	
	@ManyToOne
	private Sessao sessao;
	
	@ManyToOne
	private Jogador jogador;
	
	@Column(name="total_pontos")
	private int totalPontos;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Sessao getSessao() {
		return sessao;
	}

	public void setSessao(Sessao sessao) {
		this.sessao = sessao;
	}

	public Jogador getJogador() {
		return jogador;
	}

	public void setJogador(Jogador jogador) {
		this.jogador = jogador;
	}

	public int getQuatidadePontos() {
		return totalPontos;
	}

	public void setQuatidadePontos(int quatidadePontos) {
		this.totalPontos = quatidadePontos;
	}
}