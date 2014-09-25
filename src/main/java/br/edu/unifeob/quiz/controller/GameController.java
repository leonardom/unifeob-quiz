package br.edu.unifeob.quiz.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import br.edu.unifeob.quiz.component.JogadorLogado;
import br.edu.unifeob.quiz.model.Jogador;
import br.edu.unifeob.quiz.model.OpcaoResposta;
import br.edu.unifeob.quiz.model.Pergunta;
import br.edu.unifeob.quiz.model.Resposta;
import br.edu.unifeob.quiz.model.Sessao;
import br.edu.unifeob.quiz.service.ApplicationService;

@Controller
@Scope("request")
public class GameController {
	
	private ApplicationService service;
	
	@Autowired
	private SimpMessagingTemplate template;
	
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
		
		//se sessao ja finalizou redireciona para espera
		if (sessao == null || sessao.isFinalizada()) {
			return "espera";
		}
		
		sessao.addJogador(jogadorLogado.getJogador());
		sessao = service.salvar(sessao);
		
		model.addAttribute("sessao", sessao);
		model.addAttribute("pontuacao", service.getPontuacao(sessao, jogadorLogado.getJogador()));
		
		return "jogar";
	}
	
	@RequestMapping(value="/responder/{perguntaId}/{opcaoId}", method=RequestMethod.GET)
	public @ResponseBody String responder(@PathVariable Long perguntaId, @PathVariable Long opcaoId) {
		Sessao sessao = service.getSessaoAtiva();
		
		//verifica se a sessão foi finalizada
		if (sessao == null || sessao.isFinalizada() || sessao.isTodasPerguntasRespondidas()) {
			template.convertAndSend("/topic/game", "{\"status\": \"finalizado\"}");
		}
		
		Jogador jogador = jogadorLogado.getJogador();
		
		Pergunta pergunta = service.getPergunta(perguntaId);
		
		Resposta resposta = service.getResposta(sessao, pergunta);
		
		//verifica se tem uma resposta
		if (resposta != null) {
			//verifica se foi respondida pelo jogador
			if (resposta.getJogador().equals(jogador)) {
				return "{\"status\": \"respondida\"}";
			} else if (resposta.isCorreta()) {
				return "{\"status\": \"respondidaPeloOponente\"}";
			}
		}
		
		OpcaoResposta opcao = service.getOpcaoResposta(opcaoId);
		
		resposta = new Resposta();
		resposta.setSessao(sessao);
		resposta.setJogador(jogador);
		resposta.setPergunta(pergunta);
		resposta.setOpcao(opcao);
		
		//salva e pontua se estiver correta
		service.salvar(resposta);

		if (service.isTodasPerguntasRespondidas(sessao)) {
			sessao.finalizar();
			service.salvar(sessao);
			
			template.convertAndSend("/topic/game", "{\"status\": \"finalizado\"}");
		}
		
		//notifica o jogador
		if (resposta.isCorreta()) {
			//avisa os jogadores que pergunta foi respondida
			template.convertAndSend(
					"/topic/game", 
					"{\"status\": \"perguntaRespondida\", \"pergunta\": " + perguntaId + ", \"jogador\":" + jogador.getId() + "}"
			);

			return  "{\"status\": \"correta\", \"opcao\": \"" + opcao.getDescricao() + "\", \"pontos\": 10}";
		} else{
			return  "{\"status\": \"incorreta\"}";
		}
	}
}