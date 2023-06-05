<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href='<c:url value="./resources/styles.css" />'>
<title>Relatório de Notas</title>
</head>
<body>
	<div>
        <jsp:include page="menu.jsp"/>
    </div>
    <br/>
	<div align="center">
		<h1>Gere os relatórios de notas aqui</h1>
		<br/>
		<form action="relatorio" method="post" target="_blank">
			<table>
				<tr>
					<td>
						<select id="sigla" name="sigla">
							<option value= "0">Escolha a matéria</option>
							<option value="AOC">AOC</option>
							<option value="LABH">Lab Hardware</option>
							<option value="BD">Banco de Dados</option>
							<option value="SOI">SO I</option>
							<option value="LBD">Lab BD</option>
							<option value="MPPC">MPPC</option>
						</select>
					</td>
					<td>
						<select id="turno" name="turno">
							<option value= "0">Escolha o turno</option>
							<option value= "T">Tarde</option>
							<option value= "N">Noite</option>
						</select>
					</td>
					<td>
						<input type="submit" id="botao" name="botao" value="Gerar Relatório">
					</td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>