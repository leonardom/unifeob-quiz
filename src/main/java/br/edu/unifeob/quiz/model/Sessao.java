package br.edu.unifeob.quiz.model;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.OneToMany;
import javax.persistence.OrderBy;
import javax.persistence.OrderColumn;
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
	
	@ManyToMany(fetch=FetchType.EAGER)
	@JoinTable(
    	joinColumns=@JoinColumn(name="sessao_id"),
    	inverseJoinColumns=@JoinColumn(name="jogador_id")
	)
	@OrderBy("nome")
	private List<Jogador> jogadores;
	
	@ManyToMany(fetch=FetchType.EAGER)
	@JoinTable(
    	joinColumns=@JoinColumn(name="sessao_id"),
    	inverseJoinColumns=@JoinColumn(name="pergunta_id")
    )
	@OrderColumn(name="ordem")
	private List<Pergunta> perguntas;

	@OneToMany(mappedBy="sessao", fetch=FetchType.EAGER)
	@JoinColumn(name="sessao_id")
	@OrderBy("totalPontos DESC")
	private List<Pontuacao> pontuacoes;

	@OneToMany(mappedBy="sessao", fetch=FetchType.EAGER)
	@JoinColumn(name="sessao_id")
	private List<Resposta> respostas;

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

	/**
	 * Tenta retornar a resposta correta primeiro

	 * @param perguntaId
	 * @param jogadorId
	 * 
	 * @return resposta
	 */
	public Resposta getResposta(Pergunta pergunta) {
		Resposta reposta = getResposta(pergunta, true);
		
		if (reposta == null) {
			reposta = getResposta(pergunta, false);
		}
		
		return reposta;
	}

	private Resposta getResposta(Pergunta pergunta, boolean correta) {
		for (Resposta resposta: respostas) {
			if (resposta.getPergunta().equals(pergunta) && resposta.isCorreta() == correta) {
				return resposta;
			}
		}
		
		return null;
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
	
	public void addJogador(Jogador jogador) {
		if (jogadores == null) {
			jogadores = new ArrayList<>();
		}
		
		if (!jogadores.contains(jogador)) {
			jogadores.add(jogador);
		}
	}
	
	public Ganhador getGanhador() {
		if (pontuacoes == null || pontuacoes.isEmpty()) {
			return null;
		}
		
		return new Ganhador(
				pontuacoes.get(0).getJogador().getNome(), 
				pontuacoes.get(0).getTotalPontos()
		); 
	}
	
	public boolean isTodasPerguntasRespondidas() {
		for (Pergunta pergunta: perguntas) {
			Resposta resposta = getResposta(pergunta, true);
			
			if (resposta == null) return false;
		}
		
		return true;
	}
}