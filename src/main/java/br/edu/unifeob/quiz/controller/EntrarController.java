package br.edu.unifeob.quiz.controller;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import br.edu.unifeob.quiz.model.Jogador;
import br.edu.unifeob.quiz.model.Sessao;
import br.edu.unifeob.quiz.service.ApplicationService;

@Controller
public class EntrarController {
	
	private ApplicationService service;
	
	@Autowired
	public EntrarController(ApplicationService service) {
		this.service = service;
	}

	@RequestMapping(value = "/entrar", method=RequestMethod.GET)
    public String index(Model model) {
		model.addAttribute("jogador", new Jogador());
		
        return "/entrar";
    }

	@RequestMapping(value = "/entrar", method=RequestMethod.POST)
    public String entrar(@Valid @ModelAttribute Jogador jogador, BindingResult result, Model model) {
		
		if (result.hasErrors()) {
			return "/entrar";
		}
		
		service.salvar(jogador);
		model.addAttribute("jogador", jogador);
		
		Sessao sessao = service.getSessaoAtiva();
		
		if (sessao == null) {
			return "/espera";
		}
		
        return "/jogar";
    }
}