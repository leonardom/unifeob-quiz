package br.edu.unifeob.quiz.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import br.edu.unifeob.quiz.component.JogadorLogado;
import br.edu.unifeob.quiz.model.Sessao;
import br.edu.unifeob.quiz.service.ApplicationService;

@Controller
@Scope("request")
public class GameController {
	
	private ApplicationService service;
	
	@Autowired
	private JogadorLogado jogadorLogado;
	
	@Autowired
	public GameController(ApplicationService service) {
		this.service = service;
	}

	@RequestMapping(value="/jogar", method=RequestMethod.GET)
	public String jogar(Model model) {

		//se nao tiver jogador logado redirectiona para login
		if (jogadorLogado.getJogador() == null) {
			return "redirect:entrar";
		}

		Sessao sessao = service.getSessaoAtiva();
		
		//se sessao ja finalizou redireciona para
		if (sessao.isFinalizada()) {
			return "espera";
		}
		
		sessao.addJogador(jogadorLogado.getJogador());
		sessao = service.salvar(sessao);
		
		model.addAttribute("sessao", sessao);
		
		return "jogar";
	}
}