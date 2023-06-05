package bd.p3.siga.controller;

import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.InputStream;
import java.sql.Connection;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.InputStreamResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.ResourceUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import bd.p3.siga.persistence.GenericDAO;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.JasperRunManager;
import net.sf.jasperreports.engine.util.JRLoader;

@Controller
public class RelatorioController {
	
	@Autowired
	GenericDAO gDao;
	
	@RequestMapping(name="relatorio", value="/relatorio", method= RequestMethod.GET)
	public ModelAndView init(ModelMap model) {
		return new ModelAndView("relatorio");
	}
	

	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(name="relatorio", value="/relatorio", method= RequestMethod.POST)
	public ResponseEntity geraRelatorio(@RequestParam Map<String, String> params) {
		String erro = "";
		String botao = params.get("botao");
		String sigla = params.get("sigla");
		String turno = params.get("turno");
		
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("sigla", sigla);
		param.put("turno", turno);
		
		byte[] bytes = null;
		
		InputStreamResource resource = null;
		HttpStatus status = null;
		HttpHeaders header = new HttpHeaders();
		
		try {
			if(botao.equalsIgnoreCase("gerar relatório")) {
				Connection conn = gDao.getConnection();
				File arquivo = ResourceUtils.getFile("classpath:relatorioNotas.jasper");
				JasperReport report = (JasperReport) JRLoader.loadObjectFromFile(arquivo.getAbsolutePath());
				bytes = JasperRunManager.runReportToPdf(report, param, conn);
			}
		} catch (Exception e) {
			erro = e.getMessage();
			status = HttpStatus.BAD_REQUEST;
		} finally {
			if (erro.equals("")) {
				InputStream inputStream = new ByteArrayInputStream(bytes);
				resource = new InputStreamResource(inputStream);
				header.setContentLength(bytes.length);
				header.setContentType(MediaType.APPLICATION_PDF);
				status = HttpStatus.OK;
			}
		}
		
		return new ResponseEntity(resource, header, status);
	}
}
