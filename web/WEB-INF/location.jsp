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
            <title><fmt:message key="titre.location" /></title>
            <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
            <link href="css/grille.css" type="text/css" rel="stylesheet" />
            <link href="css/style.css" type="text/css" rel="stylesheet" />
            <link href="css/style_body.css" type="text/css" rel="stylesheet" />
            <script src="scripts/data.js"></script>
            <script src="scripts/js.js"></script>
            <script src="scripts/default.js"></script>
            <script src="scripts/details.js"></script>
        </head>
        <body>
            <div class="conteneur">
                <!------------------------------------------------------------ div ENTETE ------------------------------------------------->
                <%@include file="entete.jspf" %>

                <!---------------------------------------------------------------- div BODY ------------------------------------------------>
                <div class="centre">
                    <div class = "detail">
                        <form name="registerForm" action="Controleur?action=saveContrat" method="post" id="regForm" >
                            <c:forEach var="location" items="${requestScope.locations}">
                                <div class="detailPrix">
                                    <img src="images/cercleRouge.png" alt='' />
                                    <p class="pAnnonce" id="prixJ">${location[4]} $</p>
                                </div>
                                <div class="cellule petit">   <!-- div pour image d entete -->
                                    <img id ="selectedCar" src="${location[5]}" alt='' />
                                </div>
                                <div class="description_car">   <!-- div pour la description de la voiture -->
                                    <label for="date"><fmt:message key="depart" /></label>&nbsp;&nbsp;&nbsp;
                                    <input type="date" name="date1" id="date1" value="2019-12-08" />&nbsp;&nbsp;&nbsp;
                                    <label for="date"><fmt:message key="arrivee" /></label>&nbsp;&nbsp;&nbsp;
                                    <input type="date" name="date2" id="date2" /></br></br>
                                    <div class="col-4">
                                        <label for="nom"><fmt:message key="montant" /> </label></br></br></br>
                                        <label for="nom"><fmt:message key="nom" /> </label></br></br></br></br>
                                        <label for="prenom"><fmt:message key="prenom" /> </label></br></br></br>
                                        <label for="telephone"><fmt:message key="tel" /> </label></br></br></br></br>
                                        <label for="email"><fmt:message key="email" /> </label>

                                    </div>
                                    <div class="col-8">
                                        <input readonly type="text" name="h_m" id="montant" /></br></br></br>
                                        <c:if test="${sessionScope.username == null}">
                                            <input type="text" name="h_m" id="nom" value=""/></br></br></br>
                                            <input type="text" name="prenom" id="prenom" value=""/></br></br></br>
                                            <input type="tel" name="telephone" id="telephone" value=""/></br></br></br>
                                            <input type="mail" placeholder="<fmt:message key="email.exemple" />" name="email" id="email" value="" />	
                                        </c:if>
                                        <c:if test="${sessionScope.username != null}">    

                                            <input type="text" name="h_m" id="nom" value="${sessionScope.clients.nomClient}" /></br></br></br>
                                            <input type="text" name="prenom" id="prenom" value="${sessionScope.clients.prenomClient}" /></br></br></br>
                                            <input type="tel" name="telephone" id="telephone" value="${sessionScope.clients.telephone}" /></br></br></br>
                                            <input type="mail" placeholder="<fmt:message key="email.exemple" />" name="email" id="email" value="${sessionScope.username}" />

                                        </c:if>
                                    </div>
                                    </br>


                                </div>

                                <div class="divRelative">

                                    <div class="menu">   <!-- div pour menu -->
                                        <c:if test="${sessionScope.username == null}">
                                            <a class="louerBtnAnnonce" href="Controleur?action=connexion"><fmt:message key="save" /></a>
                                        </c:if>
                                        <c:if test="${sessionScope.username != null}">
                                            <p> <a id = "btnSave" href="javascript:submitForm()"><fmt:message key="save" /></a></p>
                                            </c:if>



                                    </div>
                                </div>
                            </c:forEach>
                    </div>

                    <img class = "grande" src="images/mastheadNissan.jpg" alt='' />
                    </form>
                </div>
                <!-------------------------------------------------------------- div BAS DE PAGE ------------------------------------------->
                <%@include file="footer.jspf" %>
            </div>
            <script>
                /*afficher la date actuelle par défaut*/
                window.onload = function () {
                    aujourdhui = new Date();
                    document.getElementById('date1').valueAsDate = aujourdhui;
                    document.getElementById('date2').valueAsDate = aujourdhui;
                    calculerMontant();
                }
                /*var monobjet_json = localStorage.getItem("carsObj");
                 var monobjet = JSON.parse(monobjet_json);
                 
                 var carsReservedObj = localStorage.getItem('carsReservedObj') ? JSON.parse(localStorage.getItem('carsReservedObj')) : [];
                 
                 
                 var carSelected_json = localStorage.getItem("carSelected");
                 var index = JSON.parse(carSelected_json);
                 
                 var montantJ = monobjet.cars[index].prixJ;*/

                document.getElementById('date1').onchange = calculerMontant;
                document.getElementById('date2').onchange = calculerMontant;
                //document.getElementById('selectedCar').src = "images/cars/" + monobjet.cars[index].modele + ".png";
                //document.getElementsByClassName("pAnnonce")[0].innerHTML = monobjet.cars[index].prixJ + " $";

                //Implémenter la fonction qui calcule le montant total par rapport aux nombres de jours de location
                function calculerMontant() {
                    date1 = document.getElementById('date1').valueAsDate;
                    date2 = document.getElementById('date2').valueAsDate;

                    if (date2 < date1) {
                        alert('la date de début ne doit pas être postèrieure à la date de fin de location');
                        document.getElementById('date1').valueAsDate = aujourdhui;
                        document.getElementById('date2').valueAsDate = aujourdhui;
                    } else {
                        function dateDiff(date1, date2) {
                            var diff = {}                           // Initialisation du retour

                            var temp = date2 - date1;

                            temp = Math.floor(temp / 1000);             // Nombre de secondes entre les 2 dates
                            diff.sec = temp % 60;                    // Extraction du nombre de secondes

                            temp = Math.floor((temp - diff.sec) / 60);    // Nombre de minutes (partie entière)
                            diff.min = temp % 60;                    // Extraction du nombre de minutes

                            temp = Math.floor((temp - diff.min) / 60);    // Nombre d'heures (entières)
                            diff.hour = temp % 24;      			// Extraction du nombre d'heures

                            temp = Math.floor((temp - diff.hour) / 24);   // Nombre de jours restants
                            diff.day = temp;


                            return diff
                        }
                        var jours = (dateDiff(date1, date2).day) + 1;
                        document.getElementById('montant').value = parseInt(jours) * parseInt(document.getElementById("prixJ").innerHTML) + ' $';
                    }
                }
                ///////////////////////////////////////////////Création de l'objet Réservation/////////////////////////////////////////

                function submitForm() {
                    if (validateinputs()) {
                        document.getElementById("regForm").submit();
                    } else {
                        alert("Veuillez valider les champs ");
                    }

                }
                function validateEmail()
                {
                    var mailformat = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;
                    if (document.getElementById('email').value.match(mailformat)) {
                        return true;
                    } else {
                        return false;
                    }
                }

                function validateinputs()
                {
                    var valide = true;
                    if (document.getElementById('nom').value.length < 3) {
                        surligne('nom', true);
                        valide = false;
                    } else {
                        surligne('nom', false);
                    }
                    if (document.getElementById('prenom').value.length < 3) {
                        surligne('prenom', true);
                        valide = false;
                    } else {
                        surligne('prenom', false);
                    }

                    /*if (document.getElementById('password').value.length <8){
                     surligne('password',true);
                     surligne('password2',true);
                     valide =false;}else{surligne('password',false); surligne('password2',false)} */
                    if (!validateEmail()) {
                        surligne('email', true);
                        valide = false;
                    } else {
                        surligne('email', false);
                    }

                    return valide;
                }

                function surligne(champ, erreur)
                {
                    if (erreur) {
                        document.getElementById(champ).style.backgroundColor = "#fba";
                    } else {
                        document.getElementById(champ).style.backgroundColor = "";
                    }
                }


                /*document.getElementById("btnSave").onclick = function () {
                 var nomClient = document.getElementById("nom").value;
                 var prenomClient = document.getElementById("prenom").value;
                 var telClient = document.getElementById("telephone").value;
                 var emailClient = document.getElementById("email").value;
                 date1 = document.getElementById("date1").valueAsDate;
                 date2 = document.getElementById("date2").valueAsDate;
                 var montantTotal = document.getElementById("montant").value;
                 
                 
                 if (nomClient == '' || prenomClient == '' || emailClient == '' || telClient == '') {
                 alert('Vous devez remplir tous les champs');
                 } else {
                 
                 if (isReserved() == false) {
                 
                 var carsObj = {"nom": nomClient, "prenom": prenomClient, "telephone": telClient, "courriel": emailClient
                 , "dateDebut": date1, "dateFin": date2, "montant": montantTotal, "voiture": index};
                 
                 carsReservedObj.push(carsObj);
                 
                 localStorage.setItem("carsReservedObj", JSON.stringify(carsReservedObj));
                 
                 alert('Réservation enregistrée');
                 document.getElementById("btnSave").href = 'catalogue.jsp';
                 } 
                 }*/


                function isReserved() { //pour vérifier si le véhicule est réservé
                    for (i = 0; i < carsReservedObj.length; i++) {

                        if (index == carsReservedObj[i].voiture) {
                            if ((date1 >= Date.parse(carsReservedObj[i].dateDebut) && (date1 <= Date.parse(carsReservedObj[i].dateFin)))) {
                                alert('La voiture est déja réservée pour la période que vous sollicitez');
                                return true;
                            }
                            if (date1 < Date.parse(carsReservedObj[i].dateDebut) && ((date2 >= Date.parse(carsReservedObj[i].dateDebut) && (date2 <= Date.parse(carsReservedObj[i].dateFin))))) {
                                alert('La voiture est déja réservée pour la période que vous sollicitez');
                                return true;
                            }
                        }
                    }
                    return false;
                }
            </script>
        </body>
    </fmt:bundle>
</html>