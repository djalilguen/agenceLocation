<%-- 
    Document   : catalogue
    Created on : 2019-09-12, 14:33:22
    Author     : 1995089
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
    <c:if test="${!(empty sessionScope.langage)}">
        <c:set var="loc" value="${sessionScope.langage}"/>
    </c:if>
    <fmt:setLocale  value="${loc}"  />
    <fmt:bundle basename="ressources_i18n.Messages">
        <head>
            <title><fmt:message key="titre.catalogue" /></title>
            <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
            <link href="css/grille.css" type="text/css" rel="stylesheet" />
            <link href="css/style.css" type="text/css" rel="stylesheet" />
            <link href="css/style_body.css" type="text/css" rel="stylesheet" />
            <link href="css/popup.css" rel="stylesheet" type="text/css"/>
            <script src="scripts/data.js"></script>
            <script src="scripts/js.js"></script>
            <script src="scripts/default.js"></script>
        </head>
        <body>

            <div class="conteneur">
                <!------------------------------------------------------------ div ENTETE ------------------------------------------------->
                <%@include file="entete.jspf" %>

                <!---------------------------------------------------------------- div BODY ------------------------------------------------>


                <aside class="centre" style="height:940px">
                    <div class = "search">
                        <p><fmt:message key="phrase.intro" /></p>
                        <label for="date"><fmt:message key="depart" /></label>
                        <input type="date" name="date" id="dateDeb" value="2019-12-08" />
                        <label for="date"><fmt:message key="arrivee" /></label>
                        <input type="date" name="date" id="dateFin" value="2019-12-08"/>
                        <input type="submit" value="<fmt:message key="rechercher" />" />
                        <%-- filtres --%>
                        <button onclick="document.getElementById('id01').style.display = 'block'" style="width:auto;">Filtrer</button>

                        <div id="id01" class="modal">
                            <span onclick="document.getElementById('id01').style.display = 'none'" class="close" title="Close Modal">&times;</span>
                            <form class="modal-content" action="Controleur">
                                <div class="container">
                                    <h1>Filtrer les résultats</h1>
                                    <hr>
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
                                      
                                    </select>
                                    <br><br>
                                    <div class="clearfix">
                                        <button type="button" onclick="document.getElementById('id01').style.display = 'none'" class="cancelbtn">Annuler</button>
                                        <button type="button" class="signupbtn" id="btnFiltrer">Filtrer</button>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                    <div class = "catalogue" style="height:800px"> 
                        <c:if test="${fn:length(requestScope.modeles) eq 0}">
                            <br><br><p><b>Pas de véhicule correspondant aux critères sélectionnés!!!</b></p>
                        </c:if> 
                        <c:if test="${fn:length(requestScope.modeles) gt 0}">
                            <c:forEach var="modele" items="${requestScope.modeles}">

                                <div class = "col-4">
                                    <div class = "annonce">
                                        <div class="detailPrix">
                                            <img src="images/cercleRouge.png" alt='' />
                                            <p class="pAnnonce">${modele[4]} $</p>
                                        </div>
                                        <div>   <!-- div pour image d entete -->
                                            <p class="pAnnonce">${modele[2]} ${modele[1]}</p>
                                            <p class="pAnnonce">
                                                <c:if test="${modele[9]==true}">
                                                    Automatique
                                                </c:if>
                                                <c:if test="${modele[9]!=true}">
                                                    Manuelle
                                                </c:if>
                                            </p>
                                        </div>
                                        <div class="cellule petit">   <!-- div pour image d entete -->
                                            <img class="imgAnnonce" src="${modele[5]}" alt='' />
                                        </div>
                                        <div class="menu btnVert">   <!-- div pour menu -->
                                            <p>
                                                <a class="detailsBtnAnnonce" href="Controleur?action=detailCar&paramDetail=${modele[7]}"><fmt:message key="detail" /></a>

                                            </p>
                                        </div>
                                        <div class="menu btnBlue">   <!-- div pour menu -->
                                            <p> 
                                                <a class="louerBtnAnnonce" href="Controleur?action=location&paramLouer=${modele[7]}"><fmt:message key="louer" /></a>
                                            </p>								
                                        </div>
                                    </div>
                                </div>  

                            </c:forEach> 
                        </c:if>

                    </div>
                </aside>
                <!-------------------------------------------------------------- div BAS DE PAGE ------------------------------------------->
                <%@include file="footer.jspf" %>
            </div>
            <script>
                /*afficher la date actuelle par défaut*/
                var aujourdhui = new Date();
                document.getElementById('dateDeb').valueAsDate = aujourdhui;
                document.getElementById('dateFin').valueAsDate = aujourdhui;

                /*Implémenter l'évènement onclick du bouton rechercher*/
                document.getElementById("btnFiltrer").onclick = function () {
                    var date1 = document.getElementById('dateDeb').valueAsDate;
                    var date2 = document.getElementById('dateFin').valueAsDate;
                    if (date2 < date1) {
                        alert('la date de début ne doit pas être postèrieure à la date de fin de location');
                        document.getElementById("dateDeb").valueAsDate = aujourdhui;
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
