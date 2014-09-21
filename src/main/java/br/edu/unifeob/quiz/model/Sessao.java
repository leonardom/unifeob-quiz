package br.edu.unifeob.quiz.model;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.OneToMany;
import javax.persistence.OrderBy;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * 
 * @author Leonardo Marcelino
 *
 */
@Entity
@Table(name="sessoes")
public class Sessao implements Serializable {
	
	private static final long serialVersionUID = 2120536865882194422L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Long id;

	@Temporal(TemporalType.TIMESTAMP)
	private Calendar inicio;
	
	@Temporal(TemporalType.TIMESTAMP)
	@Column(nullable=true)
	private Calendar fim;
	
	@ManyToMany
	@JoinTable(
    	joinColumns=@JoinColumn(name="sessao_id"),
    	inverseJoinColumns=@JoinColumn(name="jogador_id")
	)
	private List<Jogador> jogadores;
	
	@ManyToMany
	@JoinTable(
    	joinColumns=@JoinColumn(name="sessao_id"),
    	inverseJoinColumns=@JoinColumn(name="pergunta_id")
    )
	private List<Pergunta> perguntas;

	@OneToMany(mappedBy="sessao")
	@JoinColumn(name="sessao_id")
	@OrderBy("totalPontos DESC")
	private List<Pontuacao> pontuacoes;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Calendar getInicio() {
		return inicio;
	}

	public void setInicio(Calendar inicio) {
		this.inicio = inicio;
	}

	public Calendar getFim() {
		return fim;
	}

	public void setFim(Calendar fim) {
		this.fim = fim;
	}

	public List<Jogador> getJogadores() {
		return jogadores;
	}

	public void setJogadores(List<Jogador> jogadores) {
		this.jogadores = jogadores;
	}

	public List<Pergunta> getPerguntas() {
		return perguntas;
	}

	public void setPerguntas(List<Pergunta> perguntas) {
		this.perguntas = perguntas;
	}
	
	public List<Pontuacao> getPontuacoes() {
		return pontuacoes;
	}

	public void setPontuacoes(List<Pontuacao> pontuacoes) {
		this.pontuacoes = pontuacoes;
	}

	public void iniciar(List<Pergunta> perguntas) {
		setInicio(Calendar.getInstance());
		setJogadores(new ArrayList<Jogador>());
		setPerguntas(perguntas);
	}
	
	public void finalizar() {
		setFim(Calendar.getInstance());
	}
	
	public boolean isFinalizada() {
		return fim != null;
	}
	
	public Ganhador getGanhador() {
		if (pontuacoes == null || pontuacoes.isEmpty()) {
			return null;
		}
		
		return new Ganhador(
				pontuacoes.get(0).getJogador().getNome(), 
				pontuacoes.get(0).getQuatidadePontos()
		); 
	}
}