package br.edu.unifeob.quiz.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import br.edu.unifeob.quiz.model.Sessao;
import br.edu.unifeob.quiz.service.ApplicationService;

@Controller
public class PlacarController {

	private ApplicationService service;
	
	@Autowired
	public PlacarController(ApplicationService service) {
		this.service = service;
	}
	
	@RequestMapping(value="/placar/{sessaoId}", method=RequestMethod.GET)
	public String placar(@PathVariable Long sessaoId, Model model) {
		Sessao sessao = service.getSessao(sessaoId);
		
		model.addAttribute("pontuacoes", sessao.getPontuacoes());
		
		return "placar";
	}
}