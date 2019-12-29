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
                <div class="centre" style="color:white;">
                    <div class = "detail" style="background-color: darkblue; height: 400px; width: 800px; padding: 10px;">

                        <form name="registerForm" action="Controleur?action=enregistrerClient" method="post" id="regForm" >
                            <div class="col-12" >
                                <div class="divFrom">
                                    <label for="nom"><fmt:message key="nom" /> *</label>
                                    <input type="text" name="nom" id="nom" value=""/>
                                </div>
                                <div class="divFrom">
                                    <label for="prenom"><fmt:message key="prenom" /> *</label>
                                    <input type="text" name="prenom" id="prenom" value="" required />
                                </div>
                                <div class="divFrom">
                                    <label for="adresse1"><fmt:message key="adresse" /> 1 *</label>
                                    <input type="text" name="adresse1" id="adresse1" value="" required />
                                </div>
                                <div class="divFrom">
                                    <label for="adresse2"><fmt:message key="adresse" /> 2</label>
                                    <input type="adresse2" name="adresse2" id="adresse2" value="" />
                                </div>
                                <div class="divFrom">
                                    <label for="ville"><fmt:message key="ville" /> *</label>
                                    <input type="text" name="ville" id="ville" />
                                </div>
                                <div class="divFrom">
                                    <label for="codePostal"><fmt:message key="zip" /> *</label>
                                    <input type="text" name="codePostal" id="codePostal" value="" required />
                                </div>
                                <div class="divFrom">
                                    <label for="email"><fmt:message key="age" />  *</label>
                                    <input type="text" name="age" id="age" value="" />
                                </div>
                                <div class="divFrom">
                                    <label for="permis"><fmt:message key="permis" />  *</label>
                                    <input type="text" name="permis" id="permis" value=""  />
                                </div>
                                <div class="divFrom">
                                    <label for="courriel"><fmt:message key="email" />  *</label>
                                    <input type="mail" name="courriel" id="courriel" value=""/>
                                </div>
                                <div class="divFrom">
                                    <label for="courriel2"><fmt:message key="confirm.email" />  *</label>
                                    <input type="mail" name="courriel2" id="courriel2" value=""/>
                                </div>
                                <div class="divFrom">
                                    <label for="password"><fmt:message key="password" /> *</label>
                                    <input type="password" name="password" id="password" value="" />
                                </div>
                                <div class="divFrom">
                                    <label for="password2"><fmt:message key="confirm.password" /> *</label>
                                    <input type="password" name="password2" id="password2" value="" />
                                </div>

                            </div>
                            <%--  <input type="submit" value="Envoyer" name="submit" />   --%>

                            <div class="divRelative">
                                <div class="menu btnBlue" style="width: 150px; float: right;">   <!-- div pour menu -->
                                    <p> 

                                        <a class="louerBtnAnnonce" href="javascript:submitForm()"><fmt:message key="envoyer" /></a>
                                    </p>								
                                </div>
                            </div> 
                    </div>

                    </form>
                    <img class = "grande" src="images/mastheadNissan.jpg" alt='' />

                </div>
                <!-------------------------------------------------------------- div BAS DE PAGE ------------------------------------------->
                <%@include file="footer.jspf" %>
            </div>
            <script>
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
                    if (document.getElementById('courriel').value.match(mailformat) && document.getElementById('courriel2').value.match(mailformat)) {
                        return true;
                    } else {
                        return false;
                    }
                }

                function validateinputs()
                { var valide = true;
                    if (document.getElementById('nom').value.length < 3){
                    surligne('nom',true);
                    valide =false;}else{surligne('nom',false);}
                    if (document.getElementById('prenom').value.length < 3){
                        surligne('prenom',true);
                        valide =false;}else{surligne('prenom',false);}
                    if (document.getElementById('adresse1').value.length < 3){
                        surligne('adresse1',true);
                        valide =false;}else{surligne('adresse1',false);}
                    if (document.getElementById('ville').value.length < 3){
                        surligne('ville',true);
                        valide =false;}else{surligne('ville',false);}
                    if (document.getElementById('codePostal').value.length !== 6){
                        surligne('codePostal',true);
                        valide =false;}else{surligne('codePostal',false);}
                    if (document.getElementById('age').value.length < 2){
                        surligne('age',true);
                        valide =false;}else{surligne('age',false);}
                    if (document.getElementById('permis').value.length < 1){
                        surligne('permis',true);
                        valide =false;}else{surligne('permis',false);}
                    
                    if (document.getElementById('password').value !== document.getElementById('password2').value 
                            || document.getElementById('password').value.length <8 ){
                        surligne('password',true);
                        surligne('password2',true);
                        valide =false;}else{surligne('password',false); surligne('password2',false)}
                    /*if (document.getElementById('password').value.length <8){
                        surligne('password',true);
                        surligne('password2',true);
                        valide =false;}else{surligne('password',false); surligne('password2',false)} */
                    if (document.getElementById('courriel').value !== document.getElementById('courriel2').value){
                        surligne('courriel',true);
                        surligne('courriel2',true);
                        valide =false;}else{surligne('courriel',false); surligne('courriel2',false)}
                    if (!validateEmail()){
                        surligne('courriel',true);
                        surligne('courriel2',true);
                        valide =false;
                    }else{surligne('courriel',false); surligne('courriel2',false)}
                 
                    return valide;
                }

                function surligne(champ, erreur)
                {
                    if (erreur){
  
                       document.getElementById(champ).style.backgroundColor = "#fba";}
                    else{
                        document.getElementById(champ).style.backgroundColor = "";}
                }
            </script>
        </body>
    </fmt:bundle>
</html>
