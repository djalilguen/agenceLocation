<%-- 
    Document   : errors
    Created on : 2019-09-23, 22:46:36
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%-- <%@include file="entete.jspf" %> --%>
        <h1>Code erreur = ${requestScope.erreur}</h1>
        <%-- <%@include file="footer.jspf" %> --%>
    </body>
</html>
