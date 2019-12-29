/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controleur;

import static com.sun.org.apache.xalan.internal.lib.ExsltDatetime.date;
import static com.sun.org.apache.xalan.internal.lib.ExsltDatetime.date;
import dao.Client;
import dao.Modele;
import dao.Vehicule;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.jsp.JspPage;
import utils.Utilitaire;

/**
 *
 * @author 1995089
 */
public class Controleur extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        //--------------  set language -----------------------//
        HttpSession session = request.getSession();
        String username;
        String actualPage = "";
        if (session.getAttribute("username") == null) {
            username = null;
            session.setAttribute("username", username);
            //  request.setAttribute("username",username);
        }

        String langue = "";

        if (request.getParameter("langue") == null) {
            if (session.getAttribute("langage") == null) {
                Locale locale = request.getLocale();
                if (!"".equals(locale.getCountry())) {
                    langue = locale.getLanguage() + "_" + locale.getCountry();
                } else {
                    langue = locale.getLanguage() + "_CA";
                }

            } else {
                langue = (String) session.getAttribute("langage");
            }
        } else {
            if ("fr_CA".equalsIgnoreCase(request.getParameter("langue"))) {
                langue = "";
            } else {
                langue = "en_CA";
            }
        }
        session.setAttribute("langage", langue);

        //---------------  Action  -----------------------------//
        String action = request.getParameter("action");
        //  String email = (String) session.getAttribute("username");
        String paramLouer = request.getParameter("paramLouer");

        String paramDetail = request.getParameter("paramDetail");

        String jspPage = "/WEB-INF/default.jsp";

        if ((action == null) || (action.length() < 1)) {
            action = "default";
        }
        if ("catalogue".equalsIgnoreCase(action)) {
            String marque = request.getParameter("marque");
            String modele = request.getParameter("modele");
            String categorie = request.getParameter("categorie");
            String transmission = request.getParameter("transmission");
            
            actualPage = "/WEB-INF/catalogue.jsp";
            List<Object[]> modeles = Utilitaire.filtreVehicules(marque,
                    modele, categorie,transmission);
            request.setAttribute("modeles", modeles);
            jspPage = "/WEB-INF/catalogue.jsp";
            session.setAttribute("actualPage", jspPage);

        } else if ("default".equalsIgnoreCase(action)) {
            jspPage = actionDefault(request, session, actualPage);
        } else if ("detailCar".equals(action)) {
            action = action + "&paramDetail=" + paramDetail;
            List<Object[]> details = Utilitaire.getModele(paramDetail);
            session.setAttribute("paramD", paramDetail);
            request.setAttribute("details", details);
            jspPage = "/WEB-INF/detailCar.jsp";
            session.setAttribute("actualPage", jspPage);
        } else if ("location".equalsIgnoreCase(action)) {
            action = action + "&paramLouer=" + paramLouer;
            List<Object[]> locations = Utilitaire.getModele(paramLouer);
            session.setAttribute("paramL", paramLouer);
            request.setAttribute("locations", locations);
            Client clients = Utilitaire.
                    getClient((String) session.getAttribute("username"));
            session.setAttribute("clients", clients);
            Vehicule vehicules = Utilitaire.getVehicule(paramLouer);
            session.setAttribute("vehicules", vehicules);
            jspPage = "/WEB-INF/location.jsp";
            session.setAttribute("actualPage", jspPage);
        } else if ("contact".equalsIgnoreCase(action)) {
            jspPage = "/WEB-INF/contact.jsp";
            session.setAttribute("actualPage", jspPage);
        } else if ("connexion".equalsIgnoreCase(action)) {
            jspPage = "/WEB-INF/connexion.jsp";
        } else if ("creerCompte".equalsIgnoreCase(action)) {
            jspPage = "/WEB-INF/enregistrement.jsp";
        } else if ("enregistrerClient".equalsIgnoreCase(action)) {
            jspPage = enregistrerClient(request);
        } else if ("login".equalsIgnoreCase(action)) {
            jspPage = logInClient(request, session,
                    (String) session.getAttribute("actualPage"));

            if (jspPage.equalsIgnoreCase("/WEB-INF/detailCar.jsp")) {
                String paramD = (String) session.getAttribute("paramD");
                action = action + "&paramDetail=" + paramD;
                List<Object[]> details = Utilitaire.getModele(paramD);
                request.setAttribute("details", details);
                jspPage = "/WEB-INF/detailCar.jsp";
            } else if (jspPage.equalsIgnoreCase("/WEB-INF/location.jsp")) {
                String paramL = (String) session.getAttribute("paramL");
                action = action + "&paramLouer=" + paramL;
                List<Object[]> locations = Utilitaire.getModele(paramL);
                request.setAttribute("locations", locations);

                Client clients = Utilitaire.
                        getClient((String) session.getAttribute("username"));
                session.setAttribute("clients", clients);
                jspPage = "/WEB-INF/location.jsp";
            } else if (jspPage.equalsIgnoreCase("/WEB-INF/contact.jsp")) {
                action = "contact";
            } else if (jspPage.equalsIgnoreCase("/WEB-INF/catalogue.jsp")) {
                action = "catalogue";
            } else if (jspPage.equalsIgnoreCase("/WEB-INF/default.jsp")) {
                action = "default";
            }
        } else if ("disconnect".equalsIgnoreCase(action)) {
            username = null;
            session.setAttribute("username", username);
            session.invalidate();
            jspPage = "/WEB-INF/default.jsp";
        } else if ("saveContrat".equalsIgnoreCase(action)) {
            jspPage = enregistrerContrat(request, session);
        }
        request.setAttribute("action", action);

        dispatch(jspPage, request, response);

    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

    private void dispatch(String jspPage, HttpServletRequest request,
            HttpServletResponse response) throws ServletException, IOException {
        if (jspPage != null) {
            RequestDispatcher rd = request.getRequestDispatcher(jspPage);
            rd.forward(request, response);
        }
    }

    private String enregistrerClient(HttpServletRequest request) {

        String nomClient = request.getParameter("nom");
        String prenomClient = request.getParameter("prenom");
        String adresse1 = request.getParameter("adresse1");
        String adresse2 = request.getParameter("adresse2");
        String ville = request.getParameter("ville");
        String codePostal = request.getParameter("codePostal");
        String age = request.getParameter("age");
        String permis = request.getParameter("permis");
        String courriel = request.getParameter("courriel");
        String password = request.getParameter("password");
        int code = Utilitaire.enregistrerLogin(nomClient, prenomClient, adresse1
                + " " + adresse2, ville, codePostal, 0, permis, courriel, ville,
                password);
        if (code == 0) {
            return "/WEB-INF/connexion.jsp";
        } else {
            request.setAttribute("erreur", code);
            return "/WEB-INF/errors.jsp";
        }

    }

    private String enregistrerContrat(HttpServletRequest request,
            HttpSession session) {

        Client client = (Client) session.getAttribute("clients");
        Vehicule vehicule = (Vehicule) session.getAttribute("vehicules");
        String date1 = request.getParameter("date1");
        String date2 = request.getParameter("date2");
        int code = Utilitaire.enregistrerContrat(client, vehicule, date1, date2);
        if (code == 0) {
            return "/WEB-INF/catalogue.jsp";
        } else {
            request.setAttribute("erreur", code);
            return "/WEB-INF/errors.jsp";
        }

    }

    private String logInClient(HttpServletRequest request, HttpSession session,
            String actualPage) {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if (Utilitaire.verifierLogin(email, password)) {
            List<Object[]> modeles = Utilitaire.getListModeles();
            request.setAttribute("modeles", modeles);
            session.setAttribute("username", email);
            return actualPage;
        } else {
            session.setAttribute("courriel", email);
            return "/WEB-INF/connexion.jsp";
        }
    }

    private String actionDefault(HttpServletRequest request, HttpSession session,
            String actualPage) {
        String marque = "";// request.getParameter("marque");
        String nomModel = "";//request.getParameter("model");
        String categorie = "berline";// request.getParameter("categorie");

        String jspPage = "";
        //actualPage = "/WEB-INF/default.jsp";
        List<Object[]> modeles = null;//Utilitaire.filtreVehicules(marque, nomModel,
        //categorie);//.getListModeles();
        request.setAttribute("modeles", modeles);
        if (modeles == null) {
            jspPage = "/WEB-INF/default.jsp";
        } else {
            jspPage = "/WEB-INF/contact.jsp";
        }
        session.setAttribute("actualPage", jspPage);
        return jspPage;
    }
}
