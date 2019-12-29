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
            <title><fmt:message key="titre.connect" /></title>
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
                    <div class = "detail" style="background-color: darkblue; height: 200px; width: 600px;">
                        <div style="margin: 10px; padding: 10px;">   <!-- div pour la description de la voiture -->
                            <form name="connectionForm" action="Controleur?action=login" method="post" id="conForm" >
                                <div class="col-4">
                                    <label for="email"> <fmt:message key="email" /> :</label></br></br>
                                    <label for="password"><fmt:message key="password" /> : </label></br></br></br>
                                    <p><fmt:message key="question.compte" /></p>
                                    <a style = "color:white" href="Controleur?action=creerCompte" ><fmt:message key="creer.compte" /></a>
                                </div>
                                <div class="col-8">
                                    <input type="mail" placeholder="<fmt:message key="email.exemple" />" name="email" id="email" /></br></br>
                                    <input type="password" name="password" id="password" style="height: 30px; width: 240px;"/>	</br></br></br>
                                </div>

                        </div>
                        <div class="divRelative">
                            <div class="menu btnBlue" style="width: 150px; float: right;">   <!-- div pour menu -->
                                <p> 
                                    <a class="louerBtnAnnonce" href="javascript:submitForm()"><fmt:message key="connect" /></a>
                                </p>								
                            </div>
                        </div>
                        </form>
                    </div>

                    <img class = "grande" src="images/mastheadNissan.jpg" alt='' />

                </div>
                <!-------------------------------------------------------------- div BAS DE PAGE ------------------------------------------->
                <%@include file="footer.jspf" %>
            </div>
            <script>
                // script pour la connection du client
                function submitForm() {
                      if (validateinputs()) {
                        document.getElementById("conForm").submit();
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
                { var valide = true;
                    
                    if (document.getElementById('password').value.length <8 ){
                         valide =true;}
                    
                    if (!validateEmail()){
                        surligne('email',true);
                        valide =false;
                    }             
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
