<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet" type="text/css" href='<c:url value="./resources/styles.css" />'>
<title>AOC Noite</title>
</head>
<body>
	<div>
        <jsp:include page="menu.jsp"/>
    </div>
    <br/>
	<h1>Fazer controle de:</h1>
	<div>
		<a href="aocNN">Notas</a>
		<a href="aocNF">Faltas</a>
	</div>
</body>
</html>