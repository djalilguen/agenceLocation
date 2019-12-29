<%-- 
    Document   : detail_car
    Created on : 2019-09-12, 14:35:45
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
            <title><fmt:message key="titre.detail" /></title>
            <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
            <link href="css/grille.css" type="text/css" rel="stylesheet" />
            <link href="css/style.css" type="text/css" rel="stylesheet" />
            <link href="css/style_body.css" type="text/css" rel="stylesheet" />
            <script src="scripts/js.js"></script>
        </head>
        <body>
            <div class="conteneur">
                <!------------------------------------------------------------ div ENTETE ------------------------------------------------->
                <%@include file="entete.jspf" %>

                <!---------------------------------------------------------------- div BODY ------------------------------------------------>
                <div class="centre">
                    <div class = "detail">
                        <c:forEach var="modele" items="${requestScope.details}">
                            <div class="detailPrix">
                                <img src="images/cercleRouge.png" alt='' />
                                <p class="pAnnonce">${modele[4]}$</p>
                            </div>
                            <div class="cellule petit">   <!-- div pour image d entete -->
                                <img  id ="selectedCar" src="${modele[5]}" alt='' />
                            </div>
                            <div class="description_car">   <!-- div pour la description de la voiture -->

                                <div class="col-4">
                                    <label for="Modèle"><fmt:message key="modele" /> : </label></br></br>
                                    <label for="nom" ><fmt:message key="marque" /> : </label></br></br></br>
                                    <label for="prenom"><fmt:message key="transmission" /> : </label></br></br>
                                    <label for="email"><fmt:message key="power" /> : </label></br></br>
                                    <label for="objet"><fmt:message key="places" /> : </label></br></br></br>

                                </div>
                                <div class="col-8">
                                    <label for="Modèle" id="modele">${modele[1]}</label></br></br>
                                    <label for="marques" id="marque">${modele[2]} </label></br></br></br>
                                    <label for="transmission" id="transmission">
                                        <c:if test="${modele[9]==true}">
                                                Automatique
                                            </c:if>
                                            <c:if test="${modele[9]==false}">
                                                Manuelle
                                            </c:if>
                                    </label></br></br>
                                    <label for="puissance" id="puissance">${modele[3]} litres</label></br></br>
                                    <label for="places" id="places">${modele[6]} places</label></br></br></br>
                                </div>

                            </div>

                            <div class="divRelative">

                                <div class="menu">   <!-- div pour menu -->
                                    <c:if test="${sessionScope.username == null}">
                                        <a href="Controleur?action=connexion"><fmt:message key="louer" /></a>
                                    </c:if>
                                    <c:if test="${sessionScope.username != null}">
                                        <p> <a href="Controleur?action=location&paramLouer=${modele[7]}"><fmt:message key="louer" /></a></p>
                                    </c:if>
                                    
                                    <p> <a href="Controleur?action=catalogue"><fmt:message key="retour" /></a></p>

                                </div>
                            </div>
                        </c:forEach>
                    </div>

                    <img class = "grande" src="images/mastheadNissan.jpg" alt='' />

                </div>
                <!-------------------------------------------------------------- div BAS DE PAGE ------------------------------------------->
                <%@include file="footer.jspf" %>
            </div>
            <script>
                var monobjet_json = localStorage.getItem("carsObj");
                var monobjet = JSON.parse(monobjet_json);

                var carSelected_json = localStorage.getItem("carSelected");
                var index = JSON.parse(carSelected_json);

                document.getElementById("selectedCar").src = "images/cars/" + monobjet.cars[index].modele + ".png";
                document.getElementsByClassName("pAnnonce")[0].innerHTML = monobjet.cars[index].prixJ + " $";
                document.getElementById("passagers").textContent = monobjet.cars[index].passagers;
                document.getElementById("transmission").textContent = monobjet.cars[index].transmission;
                document.getElementById("climatisation").textContent = monobjet.cars[index].climatisation;
                document.getElementById("GPS").textContent = monobjet.cars[index].GPS;
                document.getElementById("modele").textContent = monobjet.cars[index].modele;

            </script>
        </body>
    </fmt:bundle>
</html>
