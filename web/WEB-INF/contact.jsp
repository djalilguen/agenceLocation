<%-- 
    Document   : form-contact
    Created on : 2019-09-12, 14:37:43
    Author     : 1995089
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <c:if test="${!(empty sessionScope.langage)}">
        <c:set var="loc" value="${sessionScope.langage}"/>
    </c:if>
    <fmt:setLocale  value="${loc}"  />
    <fmt:bundle basename="ressources_i18n.Messages">
    <head>
        <title><fmt:message key="titre.contact" /></title>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
        <link href="css/grille.css" type="text/css" rel="stylesheet" />
            <link href="css/style.css" type="text/css" rel="stylesheet" />
            <link href="css/style_body.css" type="text/css" rel="stylesheet" />
            <script src="scripts/data.js"></script>	
        <script src="scripts/js.js"></script>
    </head>
    <body>
        <div class="conteneur">
            <!------------------------------------------------------------ div ENTETE ------------------------------------------------->
            <%@include file="entete.jspf" %>

            <!---------------------------------------------------------------- div BODY ------------------------------------------------>
            <div class="centre">
                <div class = "detail">
                    <div class="cellule petit">   <!-- div pour image d entete -->
                        <img id ="icone" src="images/contactez-nous.png" alt='' />
                    </div>
                    <div class="description_car">   <!-- div pour la description de la voiture -->

                        <div class="col-4">
                            <label for="nom"><fmt:message key="nom" /> </label></br></br></br>
                            <label for="prenom"><fmt:message key="prenom" /> </label></br></br>
                            <label for="email"><fmt:message key="email" /> </label></br></br>
                            <label for="objet"><fmt:message key="objet" /> </label></br></br></br>
                            <label for="descriptiont"><fmt:message key="description" /> </label>
                        </div>
                        <div class="col-8">


                            <input type="text" name="h_m" id="nom"/></br></br>
                            <input type="text" name="prenom" id="prenom"/></br></br>
                            <input type="mail" placeholder="<fmt:message key="email.exemple" />" name="email" id="email" />	</br></br>
                            <input type="text" name="objet" id="objet"/></br></br>
                            <TEXTAREA name="description" id="description" rows=4 cols=35 placeholder="<fmt:message key="taille.msg" />"></TEXTAREA>
						
					</div>
					</br>
					
					
				</div>
				
			<div class="divRelative">
				
				<div class="menu">   <!-- div pour menu -->
					<p> <a href="#" id="btnSend"><fmt:message key="envoyer" /></a></p>
					
				</div>
			</div>
		
			</div>
			
				<img class = "grande" src="images/mastheadNissan.jpg" alt='' />
			
		</div>
		<!-------------------------------------------------------------- div BAS DE PAGE ------------------------------------------->
            <%@include file="footer.jspf" %>
	</div>
	<script>

            var messageObj = localStorage.getItem('messageObj') ? JSON.parse(localStorage.getItem('messageObj')) : [];

            //Implémenter l'évènement onclick du bouton Envoyer message
            document.getElementById("btnSend").onclick = function () {
                var nomClient = document.getElementById("nom").value;
                var prenomClient = document.getElementById("prenom").value;
                var objClient = document.getElementById("objet").value;
                var emailClient = document.getElementById("email").value;
                var description = document.getElementById("description").value;

                if (nomClient == '' || prenomClient == '' || emailClient == '' || objClient == '') {
                    alert('Vous devez remplir tous les champs');
                } else {

                    var msgObj = {"nom": nomClient, "prenom": prenomClient, "objet": objClient, "courriel": emailClient, "description": description};

                    messageObj.push(msgObj);

                    localStorage.setItem("messageObj", JSON.stringify(messageObj));

                    alert('Message envoyé');
                    document.getElementById("btnSend").href = 'index.jsp';

                }
            }
        </script>
</body>
</fmt:bundle>
</html>
