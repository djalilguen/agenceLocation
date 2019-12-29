<%-- 
    Document   : index
    Created on : 2019-09-12, 13:31:33
    Author     : 1995089
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
    <c:set var="loc" value="" />
    <c:if test="${!(empty sessionScope.langage)}">
        <c:set var="loc" value="${sessionScope.langage}"/>
    </c:if>
    <fmt:setLocale  value="${loc}"  />
    <fmt:bundle basename="ressources_i18n.Messages">
        <head>
            <title><fmt:message key="titre.default" /></title>
            <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
            <link href="css/grille.css" type="text/css" rel="stylesheet" />
            <link href="css/style.css" type="text/css" rel="stylesheet" />
            <link href="css/style_body.css" type="text/css" rel="stylesheet" />
            <link href="css/popup.css" rel="stylesheet" type="text/css"/>
            <script src="scripts/js.js"></script>
            <script src="scripts/default.js"></script>
            <script></script>
        </head>
        <body>
            <div class="conteneur">
                <!------------------------------------------------------------ div ENTETE ------------------------------------------------->
                <%@include file="entete.jspf" %>

                <!---------------------------------------------------------------- div BODY ------------------------------------------------>
                <div class="centre" >
  <div class = "search" >
                        <p><fmt:message key="phrase.intro" /></p>
                        <br>
                        <label for="date"><fmt:message key="depart" /></label>
                        <input type="date" name="date" id="dateDebut" value="2019-12-08" />
                        <label for="date"><fmt:message key="arrivee" /></label>
                        <input type="date" name="date" id="dateFin" value="2019-12-08"/>
                        <p><a href="#" onclick="showHide('filtre');"><fmt:message key="filtre" />>></a> </p>
                        <div class = "filtre" id="filtre">
                            <p> <fmt:message key="filtre.result" /></p>
                            <br>
                            <%-- filtrer par marque --%>
                            <label for="marque"><fmt:message key="marque" /> :</label>
                            <select name="marque" id="marque" value="">
                                 
                            </select>
                                 <%-- filtrer par model --%>
                            <label for="model"><fmt:message key="modele" /> :</label>
                            <select name="model" id="model" value="">
                                
                            </select>
                                <%-- filtrer par categorie --%>
                            <label for="cat"><fmt:message key="categorie" /> :</label>
                            <select name="categorie" id="categorie" value="">
                                 <option value=""> </option>
                            </select>
                                <%-- filtrer par categorie22222 --%>
                            <label for="cat"><fmt:message key="transmission" /> :</label>
                            <select name="transmission" id="transmission" value="">
                                <c:forEach var="modele" items="${requestScope.modeles}">
                                    <option value="${modele[2]}"> ${modele[2]}</option>

                                </c:forEach>
                            </select>
               
                        </div>
                        <input type="submit" value="<fmt:message key="rechercher" />" id ="btnSearch" />

                    </div>


                    <img class = "grande" src="images/mastheadNissan.jpg" alt='' />

                </div>
                <!-------------------------------------------------------------- div BAS DE PAGE ------------------------------------------->
                <%@include file="footer.jspf" %>
            </div>
            <script>
                /*afficher la date actuelle par défaut*/
                var aujourdhui = new Date();
                document.getElementById('dateDebut').valueAsDate = aujourdhui;
                document.getElementById('dateFin').valueAsDate = aujourdhui;

                /*Implémenter l'évènement onclick du bouton rechercher*/
                document.getElementById("btnSearch").onclick = function () {
                    var date1 = document.getElementById('dateDebut').valueAsDate;
                    var date2 = document.getElementById('dateFin').valueAsDate;
                    if (date2 < date1) {
                        alert('la date de début ne doit pas être postèrieure à la date de fin de location');
                        document.getElementById("dateDebut").valueAsDate = aujourdhui;
                        document.getElementById("dateFin").valueAsDate = aujourdhui;
                    } else {
                        window.location = 'Controleur?action=catalogue&marque=' + document.getElementById('marque').value
                                + "&categorie=" + document.getElementById('categorie').value + "&modele=" + document.getElementById('model').value
                                + "&transmission=" + document.getElementById('transmission').value;
                    }

                }


            </script>
        </body>
    </fmt:bundle>
</html>

