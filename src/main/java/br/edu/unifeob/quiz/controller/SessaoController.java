package br.edu.unifeob.quiz.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import br.edu.unifeob.quiz.model.Sessao;
import br.edu.unifeob.quiz.service.ApplicationService;

@Controller
@RequestMapping(value = "/admin")
public class SessaoController {
	
	private ApplicationService service;
	
	@Autowired
	private SimpMessagingTemplate template;
	
	@Autowired
	public SessaoController(ApplicationService service) {
		this.service = service;
	}
	
	@RequestMapping(value = "/sessoes", method=RequestMethod.GET)
	public String listar(Model model) {
		model.addAttribute("sessoes",service.getSessoes());
		
		return "admin/sessoes";
	}

	@RequestMapping(value = "/sessoes/nova", method=RequestMethod.GET)
    public String form(Model model) {
		Sessao sessao = service.getSessaoAtiva();
		
		//se nao existe sessao ativa ou esta finalizada cria uma nova
		if (sessao == null || sessao.isFinalizada()) {
			sessao = new Sessao();
			sessao.iniciar(service.getPergutas(10));
			
			sessao = service.salvar(sessao);
			
			model.addAttribute("sessao", sessao);
			
			//avisa os clientes para irem para o jogo
			template.convertAndSend("/topic/sessao", "iniciada");
		}
		
		return exibir(sessao, model);
    }
	
	@RequestMapping(value = "/sessao/finalizar/{id}", method=RequestMethod.GET)
	public String finalizar(@PathVariable Long id, Model model) {
		Sessao sessao = service.procurarSessao(id);
		sessao.finalizar();
		service.salvar(sessao);
		
		return exibir(sessao, model);
	}

	@RequestMapping(value = "/sessao/{id}", method=RequestMethod.GET)
	public String exibir(@PathVariable Long id, Model model) {
		Sessao sessao = service.procurarSessao(id);
		
		return exibir(sessao, model);
	}

	@RequestMapping(value = "/sessao/ativa", method=RequestMethod.GET)
	public String exibir(Model model) {
		Sessao sessao = service.getSessaoAtiva();
		
		return exibir(sessao, model);
	}
	
	public String exibir(Sessao sessao, Model model) {
		model.addAttribute("sessao", sessao);
		
		return "admin/sessao";
	}
}