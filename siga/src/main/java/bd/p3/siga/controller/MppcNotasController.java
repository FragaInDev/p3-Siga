package bd.p3.siga.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import bd.p3.siga.model.AlunoNota;
import bd.p3.siga.model.Notas;
import bd.p3.siga.persistence.NotasDAO;

@Controller
public class MppcNotasController {
	
	@Autowired
	private NotasDAO nDao;
	
	@RequestMapping(name = "mppcN", value = "/mppcN", method = RequestMethod.GET)
	public ModelAndView init(ModelMap model) {
		return new ModelAndView("mppcN");
	}
	
	@RequestMapping(name = "mppcN", value = "/mppcN", method = RequestMethod.POST)
	public ModelAndView notas(@RequestParam Map<String, String> allParam, ModelMap model) {
		
		Notas nota = new Notas();
		List<AlunoNota> alunos = new ArrayList<>();
		String botao = allParam.get("botao");
		String erro = "";
		
		try {
			if (botao.equalsIgnoreCase("listar")) {
				
				alunos = nDao.findNotas("mppc", "T");
				
			}else{
				
				String ra = allParam.get("ra");
				String d = allParam.get("disciplina");
				String prova = allParam.get("av");
				double n = Double.parseDouble(allParam.get("nota"));
				
				nota.setRaAluno(ra);
				nota.setCodDisciplina(d);
				nota.setCodAvaliacao(Integer.parseInt(prova));
				nota.setNota(n);
				nota = nDao.insertNota(nota);
				
				alunos = nDao.findNotas("mppc", "T");
			}
			
		} catch (Exception e) {
			erro = e.getMessage();
		} finally {
			model.addAttribute("nota", nota);
			model.addAttribute("alunos", alunos);
			model.addAttribute("erro", erro);
		}
		
		return new ModelAndView("mppcN");
	}
}
