<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet" type="text/css" href='<c:url value="./resources/styles.css" />'>
<title>Sistemas Operacionais I</title>
</head>
<body>
	<div>
        <jsp:include page="menu.jsp"/>
    </div>
    <br/>
	<h1>Escolha o Turno</h1>
	<div align="center">
		<a class="btn" href="soT">Tarde</a>
		<a class="btn" href="soN">Noite</a>
	</div>
</body>
</html>