package br.edu.unifeob.quiz.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import br.edu.unifeob.quiz.service.ApplicationService;

@Controller
public class RankingController {

	private ApplicationService service;
	
	@Autowired
	public RankingController(ApplicationService service) {
		this.service = service;
	}
	
	@RequestMapping(value="/ranking", method=RequestMethod.GET)
	public String placar(Model model) {
		
		model.addAttribute("ranking", service.getRanking());
		
		return "ranking";
	}
}