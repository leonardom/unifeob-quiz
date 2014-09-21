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
public class SessaoController {
	
	private ApplicationService service;
	
	@Autowired
	public SessaoController(ApplicationService service) {
		this.service = service;
	}

	@RequestMapping(value = "/sessao/nova", method=RequestMethod.GET)
    public String form(Model model) {
		Sessao sessao = service.getSessaoAtiva();
		
		if (sessao == null || sessao.isFinalizada()) {
			sessao = new Sessao();
			sessao.iniciar(service.getPergutas(10));
			
			sessao = service.salvar(sessao);
		}
		
		model.addAttribute("sessao", sessao);
		
        return "sessao";
    }
	
	@RequestMapping(value = "/sessao/finalizar/{id}", method=RequestMethod.GET)
	public String finalizar(@PathVariable Long id, Model model) {
		Sessao sessao = service.procurarSessao(id);
		sessao.finalizar();
		service.salvar(sessao);
		
		return exibir(id, model);
	}
	
	@RequestMapping(value = "/sessao/{id}", method=RequestMethod.GET)
	public String exibir(@PathVariable Long id, Model model) {
		Sessao sessao = service.procurarSessao(id);
		model.addAttribute("sessao", sessao);
		
		return "sessao";
	}
}