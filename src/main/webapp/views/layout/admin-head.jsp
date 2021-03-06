<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<spring:url value="/resources/css/admin.css" var="adminCss" />
<spring:url value="/resources/css/app.css" var="appCss" />
<spring:url value="/resources/js/app.js" var="appJs" />

<link href="${adminCss}"rel="stylesheet">
<link href="${appCss}" rel="stylesheet">

<script src="${appJs}"></script>

<c:set var="basePath" value="${pageContext.request.contextPath}">
</c:set>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">