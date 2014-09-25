package br.edu.unifeob.quiz.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

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

	@RequestMapping(value = "/sessoes/nova", method=RequestMethod.POST)
    public String nova(@RequestParam("quatidadePerguntas")Integer quantidade, Model model) {
		Sessao sessao = service.getSessaoAtiva();
		
		//se nao existe sessao ativa ou esta finalizada cria uma nova
		if (sessao == null || sessao.isFinalizada()) {
			sessao = new Sessao();
			sessao.iniciar(service.getPergutas(quantidade));
			sessao = service.salvar(sessao);
			
			model.addAttribute("sessao", sessao);
			
			//avisa os clientes que a sessao foi criada
			template.convertAndSend("/topic/game", "{\"status\": \"iniciado\"}");
		}
		
		return exibir(sessao, model);
    }
	
	@RequestMapping(value = "/sessao/finalizar/{id}", method=RequestMethod.GET)
	public String finalizar(@PathVariable Long id, Model model) {
		Sessao sessao = service.procurarSessao(id);
		sessao.finalizar();
		service.salvar(sessao);
		
		template.convertAndSend("/topic/game", "{\"status\": \"finalizado\"}");

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
		if (sessao == null) {
			return "redirect:/admin/sessoes";
		}
		
		model.addAttribute("sessao", sessao);
		
		return "admin/sessao";
	}
}