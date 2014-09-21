package br.edu.unifeob.quiz.model;

public class Ganhador {

	private String nome;
	
	private Integer totalPontos;
	
	public Ganhador(String nome, Integer totalPontos) {
		this.nome = nome;
		this.totalPontos = totalPontos;
	}
	
	public String getNome() {
		return nome;
	}

	public Integer getTotalPontos() {
		return totalPontos;
	}
}
