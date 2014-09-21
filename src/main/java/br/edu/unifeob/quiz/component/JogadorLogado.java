package br.edu.unifeob.quiz.component;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import br.edu.unifeob.quiz.model.Jogador;

@Component
@Scope("session")
public class JogadorLogado {

	private Jogador jogador;
	
	public JogadorLogado() {
	}
	
	public Jogador getJogador() {
		return jogador;
	}
	
	public void setJogador(Jogador jogador) {
		this.jogador = jogador;
	}

	//metodos delegados para o objeto jogador
	public Long getId() {
		return jogador.getId();
	}

	public String getNome() {
		return jogador.getNome();
	}

	public String getEmail() {
		return jogador.getEmail();
	}

	public void limpar() {
		jogador = null;
	}
}
