<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href='<c:url value="./resources/styles.css" />'>
<title>AOC - Tarde | Notas</title>
</head>
<body>
	<div>
        <jsp:include page="menu.jsp"/>
    </div>
    <br/>
	<div align="center">
		<h1>Notas Arquitetura e Organização de Computadores - Tarde</h1>
		<br/>
		<form action="aocTN" method="post">
			<table>
				<tr>
					<td>
						<input class="input" id="ra" name="ra" placeholder="RA">
					</td>
					<td>
						<input class="input" id="disciplina" name="disciplina" value="4203010">
					</td>
					<td>
						<select id="av" name="av">
							<option value= "0">Escolha o tipo de avaliação</option>
							<option value= "01">P1</option>
							<option value= "02">P2</option>
							<option value= "03">T</option>
						</select>
					</td>
					<td>
						<input class="input" id="nota" name="nota" placeholder="Nota">
					</td>
					<td>
						<input type="submit" id="botao" name="botao" value="Inserir">
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<input type="submit" id="botao" name="botao" value="Listar">
					</td>
				</tr>
			</table>
		</form>
	</div>
	<br />
	<br />
	<div align="center">
		<c:if test="${not empty erro }">
			<H2><c:out value="${erro }" /></H2>
		</c:if>
	</div>
	<div align="center">
		<c:if test="${not empty alunos }">
			<table class="table_notas">
				<thead>
					<tr>
						<th>RA</th>
						<th>Nome</th>
						<th>P1</th>
						<th>P2</th>
						<th>P3</th>
						<th>Média</th>
						<th>Situação</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="n" items="${alunos }">
						<tr>
							<td><c:out value="${n.ra }"/></td>
							<td><c:out value="${n.nome }"/></td>
							<td><c:out value="${n.nota1 }"/></td>
							<td><c:out value="${n.nota2 }"/></td>
							<td><c:out value="${n.nota3 }"/></td>
							<td><c:out value="${n.media }"/></td>
							<td><c:out value="${n.situacao }"/></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</c:if>
	</div>
</body>
</html>