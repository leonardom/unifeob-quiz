package br.edu.unifeob.quiz.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import br.edu.unifeob.quiz.model.Jogador;
import br.edu.unifeob.quiz.service.ApplicationService;

@Controller
public class JogadorController {
	
	private ApplicationService service;
	
	
	@Autowired
	public JogadorController(ApplicationService service) {
		this.service = service;
	}

	@RequestMapping(value = "/jogadores", method = RequestMethod.GET)
	public @ResponseBody List<Jogador> listar(@RequestParam(value="nome", required=false) String nome) {
		
		if (nome != null) {
			return service.getJogadores(nome);
		}
		
		return service.getJogadores();
	}

	@RequestMapping(value = "/admin/jogadores", method = RequestMethod.GET)
	public String listar(Model model) {
		model.addAttribute("jogadores", service.getJogadores());
		
		return "/admin/jogadores";
	}
}