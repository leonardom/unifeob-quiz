package br.edu.unifeob.quiz.service;

import java.util.Collections;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import br.edu.unifeob.quiz.model.Jogador;
import br.edu.unifeob.quiz.model.Pergunta;
import br.edu.unifeob.quiz.model.Pontuacao;
import br.edu.unifeob.quiz.model.Sessao;

@Service
public class ApplicationService {

	@PersistenceContext(name="unifeob")
	private EntityManager em;

	@Transactional(readOnly=true)
	public List<Jogador> getJogadores() {
		return getJogadores(null);
	}

	@Transactional(readOnly=true)
	@SuppressWarnings("unchecked")
	public List<Jogador> getJogadores(String nome) {
		String sql = "select j from Jogador j";
		
		if (nome != null) {
			 sql += " where j.nome like :nome";
		}
		
		Query query = em.createQuery(sql);
		
		if (nome != null) {
			query.setParameter("nome", nome + "%");
		}
		
		return query.getResultList();
	}
	
	@Transactional
	public Jogador salvar(Jogador jogador) {
		
		if (jogador.getId() == null) {
			Jogador j = procurarJogador(jogador.getNome(), jogador.getEmail());
			
			if (j != null) return j;
		}
		
		return em.merge(jogador);
	}
	
	@Transactional(readOnly=true)
	private Jogador procurarJogador(String nome, String email) {
		Query query = em.createQuery("select j from Jogador j where j.nome = :nome and j.email = :email");
		query.setParameter("nome", nome);
		query.setParameter("email", email);

		@SuppressWarnings("unchecked")
		List<Jogador> lista = query.getResultList();
		
		if (lista == null || lista.isEmpty()) {
			return null;
		}
		
		return lista.get(0);
	}
	
	@Transactional(readOnly=true)
	public Sessao getSessaoAtiva() {
		Query query = em.createQuery("select s from Sessao s where s.fim IS NULL order by s.id desc");
		
		@SuppressWarnings("unchecked")
		List<Sessao> lista = query.getResultList();
		
		if (lista == null || lista.isEmpty()) {
			return null;
		}
		
		return lista.get(0);
	}
	
	@Transactional
	public Sessao salvar(Sessao sessao) {
		if (sessao.getId() == null) {
			em.persist(sessao);
			return sessao;
		}
		
		return em.merge(sessao);
	}
	
	@Transactional(readOnly=true)
	public List<Pergunta> getPergutas(int quantidade) {
		Query query = em.createQuery("select p from Pergunta p");
		
		@SuppressWarnings("unchecked")
		List<Pergunta> lista = query.getResultList();
		
		//Embaralha 2 vezes
		Collections.shuffle(lista);
		Collections.shuffle(lista);
		
		return lista.subList(0, quantidade);
	}

	@Transactional(readOnly=true)
	public Sessao procurarSessao(Long id) {
		return  em.find(Sessao.class, id);
	}
	
	@Transactional(readOnly=true)
	@SuppressWarnings("unchecked")
	public List<Pontuacao> getPontuacoes(Sessao sessao) {
		Query query = em.createQuery("select p from Pontuacao p where p.sessao = :sessao order by p.totalPontos desc");
		query.setParameter("sessao", sessao);
		
		return query.getResultList();
	}

	@Transactional(readOnly=true)
	@SuppressWarnings("unchecked")
	public List<Sessao> getSessoes() {
		Query query = em.createQuery("select s from Sessao s order by s.id desc");
		
		return query.getResultList();
	}
}