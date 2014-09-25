package br.edu.unifeob.quiz.model;

public class Posicao {

	private Jogador jogador;
	
	private long totalPontos;

	public Posicao(Jogador jogador, long totalPontos) {
		this.jogador = jogador;
		this.totalPontos = totalPontos;
	}

	public Jogador getJogador() {
		return jogador;
	}

	public long getTotalPontos() {
		return totalPontos;
	}
}