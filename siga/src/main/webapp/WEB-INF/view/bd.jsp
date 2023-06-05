<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet" type="text/css" href='<c:url value="./resources/styles.css" />'>
<title>Banco de Dados</title>
</head>
<body>
	<div>
        <jsp:include page="menu.jsp"/>
    </div>
    <br/>
	<h1>Fazer controle de:</h1>
	<div align="center">
		<a class="btn" href="bdN">Notas</a>
		<a class="btn" href="labhF">Faltas</a>
	</div>
</body>
</html>