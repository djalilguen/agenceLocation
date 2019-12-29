/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package utils;

import static com.sun.org.apache.xalan.internal.lib.ExsltDatetime.date;
import static com.sun.org.apache.xalan.internal.lib.ExsltDatetime.date;
import dao.Client;
import dao.Contrat;
import dao.Login;
import dao.Modele;
import dao.Vehicule;
import java.math.BigDecimal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
//import java.util.Formatter;
import java.util.List;
import java.util.Objects;
import java.util.logging.Level;
import java.util.logging.Logger;
import net.sf.ehcache.hibernate.HibernateUtil;
import org.hibernate.Query;
//import org.hibernate.SessionFactory;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;

/**
 *
 * @author 1995089
 */
public class Utilitaire {

    static SessionFactory sessionF = null;
    static Session session = null;

    public static List<Object[]> getListModeles() {

        startTransaction();

        Query query = session.createQuery("select m.codeModel, m.nomModel, "
                + "m.marque, m.puissance,m.tarifJour, m.photo, m.nbplaces, "
                + "v.matricule, v.categorie, v.automatique from Vehicule v"
                + " inner join v.modele m");
        List<Object[]> listModeles;
        listModeles = query.list();
        session.getTransaction().commit();

        finishTransaction();
        return listModeles;
    }

    public static List<Object[]> filtreVehicules(String marque, String nomModel,
            String categorie, String transmission) {
        boolean boiteVitesse=true;
        if (marque == null || marque.equals("")) {
            marque = "";
        }
        if (nomModel == null || nomModel.equals("")) {
            nomModel = "";
        }
        if (categorie == null || categorie.equals("")) {
            categorie = "";
        }
        if (transmission == null || transmission.equals("")) {
            transmission = "";
        } else if (transmission.equalsIgnoreCase("automatique")) {
            boiteVitesse = true;
        } else {
            boiteVitesse = false;
        }
        String queryInit = "select m.codeModel, m.nomModel, "
                + "m.marque, m.puissance,m.tarifJour, m.photo, m.nbplaces, "
                + "v.matricule, v.categorie, v.automatique from Vehicule v "
                + "inner join v.modele m ";
        startTransaction();

        Query query = session.createQuery(queryInit);
        String queryWhere = "";
        String queryCat = "";
        String queryMarque = "";
        String queryTransmission = "";
        String queryModel = "";

        if (!"".equalsIgnoreCase(categorie) || !"".equalsIgnoreCase(marque)
                || !"".equalsIgnoreCase(nomModel)
                || !"".equalsIgnoreCase(transmission)) {
            queryWhere = " where ";
        }

        if (!"".equalsIgnoreCase(categorie)) {
            queryCat = " upper(v.categorie)=:categorie ";
            query = session.createQuery(queryInit + queryWhere + queryCat);
        }
        if (!"".equalsIgnoreCase(nomModel)) {
            if (!"".equalsIgnoreCase(categorie)) {
                queryModel = " and ";
            }
            queryModel = queryModel + " upper(m.nomModel)=:modele ";
            query = session.createQuery(queryInit + queryWhere + queryCat
                    + queryModel);
        }
        if (!"".equalsIgnoreCase(marque)) {
            if (!"".equalsIgnoreCase(categorie)
                    || !"".equalsIgnoreCase(nomModel)) {
                queryMarque = " and ";
            }
            queryMarque = queryMarque + " upper(m.marque)=:marque ";
            query = session.createQuery(queryInit + queryWhere + queryCat
                    + queryModel + queryMarque);
        }
        if (!"".equalsIgnoreCase(transmission)) {
            if (!"".equalsIgnoreCase(categorie)
                    || !"".equalsIgnoreCase(nomModel)
                    || !"".equalsIgnoreCase(marque)) {
                queryTransmission = " and ";
            }
            queryTransmission = queryTransmission
                    + " v.automatique=:transmission ";
            query = session.createQuery(queryInit + queryWhere + queryCat
                    + queryModel + queryMarque + queryTransmission);
        }
        
        if (!"".equalsIgnoreCase(queryCat)) {
            query.setParameter("categorie", categorie.toUpperCase());
        }
        if (!"".equalsIgnoreCase(queryModel)) {
            query.setParameter("modele", nomModel.toUpperCase());
        }
        if (!"".equalsIgnoreCase(queryMarque)) {
            query.setParameter("marque", marque.toUpperCase());
        }
        if (!"".equalsIgnoreCase(queryTransmission)) {
            query.setParameter("transmission", boiteVitesse);
        }

//        query = session.createQuery(queryInit + queryWhere + queryCat
//                + queryModel + queryMarque + queryTransmission);
        //  Query query;
//        if (!"".equalsIgnoreCase(categorie) && !"".equalsIgnoreCase(marque)
//                && !"".equalsIgnoreCase(nomModel)
//                && !"".equalsIgnoreCase(transmission)) {
//            query = session.createQuery("select m.codeModel, m.nomModel, "
//                    + "m.marque, m.puissance,m.tarifJour, m.photo, m.nbplaces, "
//                    + "v.matricule, v.categorie, v.automatique from Vehicule v "
//                    + "inner join v.modele m "
//                    + "where upper(m.marque)=:marque and upper(m.nomModel)="
//                    + ":nomModel and upper(v.categorie)=:categorie")
//                    .setParameter("marque", marque.toUpperCase()).
//                    setParameter("nomModel", nomModel.toUpperCase()).
//                    setParameter("categorie", categorie.toUpperCase());
//
//        } else if (!"".equalsIgnoreCase(categorie)
//                && !"".equalsIgnoreCase(marque)) {
//            query = session.createQuery("select m.codeModel, m.nomModel, "
//                    + "m.marque, m.puissance,m.tarifJour, m.photo, m.nbplaces, "
//                    + "v.matricule, v.categorie, v.automatique from Vehicule v "
//                    + "inner join v.modele m "
//                    + "where upper(m.marque)=:marque and "
//                    + "upper(v.categorie)=:categorie")
//                    .setParameter("marque", marque.toUpperCase()).
//                    setParameter("categorie", categorie.toUpperCase());
//        } else if (!"".equalsIgnoreCase(categorie)
//                && !"".equalsIgnoreCase(nomModel)) {
//            query = session.createQuery("select m.codeModel, m.nomModel, "
//                    + "m.marque, m.puissance,m.tarifJour, m.photo, m.nbplaces, "
//                    + "v.matricule, v.categorie, v.automatique from Vehicule v "
//                    + "inner join v.modele m "
//                    + "where upper(m.marque)=:marque and upper(m.nomModel)="
//                    + ":nomModel")
//                    .setParameter("marque", categorie.toUpperCase()).
//                    setParameter("nomModel", nomModel.toUpperCase());
//        } else if (!"".equalsIgnoreCase(marque)
//                && !"".equalsIgnoreCase(nomModel)) {
//            query = session.createQuery("select m.codeModel, m.nomModel, "
//                    + "m.marque, m.puissance,m.tarifJour, m.photo, m.nbplaces, "
//                    + "v.matricule, v.categorie, v.automatique from Vehicule v "
//                    + "inner join v.modele m "
//                    + "where upper(m.marque)=:marque and upper(m.nomModel)="
//                    + ":nomModel")
//                    .setParameter("marque", marque.toUpperCase()).
//                    setParameter("nomModel", nomModel.toUpperCase());
//        } else if (!"".equalsIgnoreCase(marque)) {
//            query = session.createQuery("select m.codeModel, m.nomModel, "
//                    + "m.marque, m.puissance,m.tarifJour, m.photo, m.nbplaces, "
//                    + "v.matricule, v.categorie, v.automatique from Vehicule v "
//                    + "inner join v.modele m "
//                    + "where upper(m.marque)=:marque")
//                    .setParameter("marque", marque.toUpperCase());
//        } else if (!"".equalsIgnoreCase(categorie)) {
//            query = session.createQuery("select m.codeModel, m.nomModel, "
//                    + "m.marque, m.puissance,m.tarifJour, m.photo, m.nbplaces, "
//                    + "v.matricule, v.categorie, v.automatique from Vehicule v "
//                    + "inner join v.modele m "
//                    + "where upper(v.categorie)=:categorie")
//                    .setParameter("categorie", categorie.toUpperCase());
//        } else if (!"".equalsIgnoreCase(nomModel)) {
//            query = session.createQuery("select m.codeModel, m.nomModel, "
//                    + "m.marque, m.puissance,m.tarifJour, m.photo, m.nbplaces, "
//                    + "v.matricule, v.categorie, v.automatique from Vehicule v "
//                    + "inner join v.modele m "
//                    + "where upper(m.nomModel)=:nomModel")
//                    .setParameter("nomModel", nomModel.toUpperCase());
//        } else {
//            query = session.createQuery("select m.codeModel, m.nomModel, "
//                    + "m.marque, m.puissance,m.tarifJour, m.photo, m.nbplaces, "
//                    + "v.matricule, v.categorie, v.automatique from Vehicule v "
//                    + "inner join v.modele m ");
//        }
        List<Object[]> listModVihFiltre = query.list();

        finishTransaction();

        if (!listModVihFiltre.isEmpty()) {
            List<Object[]> temp = new ArrayList<Object[]>(listModVihFiltre);
            // filter la marque
            if (marque != "") {

                listModVihFiltre.clear();
                for (Object[] line : temp) {
                    if (marque.equalsIgnoreCase((String) line[2])) {
                        listModVihFiltre.add(line);
                    }
                }
                // filter le model
                if (nomModel != "") {
                    temp = new ArrayList<Object[]>(listModVihFiltre);
                    listModVihFiltre.clear();
                    for (Object[] line : temp) {
                        if (nomModel.equalsIgnoreCase((String) line[1])) {
                            listModVihFiltre.add(line);
                        }
                    }

                }
            }

            // filter la categorie
            if (categorie != "") {
                temp = new ArrayList<Object[]>(listModVihFiltre);
                listModVihFiltre.clear();
                for (Object[] line : temp) {
                    if (categorie.equalsIgnoreCase((String) line[8])) {
                        listModVihFiltre.add(line);
                    }
                }

            }

        }

        return listModVihFiltre;
    }

    public static void startTransaction() {
        sessionF = new Configuration().configure("hibernate.cfg.xml").
                buildSessionFactory();
        //sessionF = controleur.HibernateUtil.getSessionFactory(); 
        // la cause du probleme de deconnexion
        session = sessionF.openSession();
        session.beginTransaction();
    }

    public static void finishTransaction() {
        session.close();
        sessionF.close();
    }

    public static List<Object[]> getModele(String matricule) {

        startTransaction();

        Query query = session.createQuery("select m.codeModel, m.nomModel, "
                + "m.marque, m.puissance,m.tarifJour, m.photo, m.nbplaces, "
                + "v.matricule, v.categorie, v.automatique from Vehicule v"
                + " inner join v.modele m  "
                + "where v.matricule=:matricule").setParameter("matricule",
                        matricule);

        List listModeles = query.list();
        session.getTransaction().commit();

        finishTransaction();
        return listModeles;
    }

    public static List<Client[]> getClients() {

        startTransaction();

//        Query query = session.createQuery("select numclient, nomClient, "
//                + "prenomClient, adresse,ville, codePostal, age, permis, "
//                + "courriel, telephone from Client  ");
        Query query = session.createQuery("from Client");
        List<Client[]> listClients;
        listClients = query.list();
        session.getTransaction().commit();

        finishTransaction();
        return listClients;
    }

    public static Client getClient(String email) {

        startTransaction();

        Query query = session.createQuery("from Client c "
                + "where c.courriel like :email").setParameter("email", email);

        List<Client> listClient = query.list();
        Client client = listClient.get(0);
        session.getTransaction().commit();

        finishTransaction();
        return client;
    }

    public static Vehicule getVehicule(String matricule) {

        startTransaction();

        Query query = session.createQuery("from Vehicule v "
                + "where v.matricule like :matricule").setParameter("matricule",
                        matricule);

        List<Vehicule> listVehicules = query.list();
        Vehicule vehicule = listVehicules.get(0);
        session.getTransaction().commit();

        finishTransaction();
        return vehicule;
    }

    public static Client enregistrerClient(String nomClient,
            String prenomClient, String adresse, String ville,
            String codePostal, int age, String permis, String courriel,
            String telephone) {
        boolean vide = rechercherLogin(courriel).isEmpty();
        Client client = null;
        if (vide) { // login non trouve

            int num = getClients().size() + 1;
            startTransaction();
            client = new Client(num, nomClient, prenomClient, adresse, ville,
                    codePostal, (short) age, permis, courriel, telephone);

            session.save(client);
            session.getTransaction().commit();
            finishTransaction();
        }

        return client; // client existe deja
    }

    public static int enregistrerLogin(String nomClient, String prenomClient,
            String adresse, String ville, String codePostal, int age,
            String permis, String courriel, String telephone, String password) {
        int numErr;
        Client client = enregistrerClient(nomClient, prenomClient, adresse,
                ville, codePostal, age, permis, courriel, telephone);
        startTransaction();
        if (client != null) { // login non trouve
            Login login = new Login(courriel, client, password);
            session.save(login);
            session.getTransaction().commit();
            numErr = 0;
        } else {
            numErr = 100;
        }
        finishTransaction();
        return numErr;
    }

    private static List<Object[]> rechercherLogin(String courriel) {
        startTransaction();
        Query query = session.createQuery("select username, password"
                + " from Login l "
                + "where l.username=:courriel").setParameter("courriel",
                        courriel);
        List<Object[]> listLogins;
        listLogins = query.list();
        finishTransaction();
        return (listLogins);
    }

    public static boolean verifierLogin(String courriel, String password) {
        List<Object[]> listLogins = rechercherLogin(courriel);
        if (listLogins.isEmpty()) {
            return false;
        } else {
            for (Object[] line : listLogins) {
                if (courriel.equalsIgnoreCase(line[0].toString())
                        && password.equals(line[1].toString())) {
                    return true;
                }
            }
            return false;
        }
    }

    public static List<Contrat[]> getContrats() {

        startTransaction();

        Query query = session.createQuery("from Contrat");
        List<Contrat[]> listContrats = query.list();
        session.getTransaction().commit();

        finishTransaction();
        return listContrats;
    }

    public static int enregistrerContrat(Client client,
            Vehicule vehicule, String dateDepart, String dateRetourSuppose) {
        int numErr;
        int num = getContrats().size() + 1;
        Date date1 = new Date();
        try {
            date1 = new SimpleDateFormat("yyyy-mm-dd").parse(dateDepart);
        } catch (ParseException ex) {
            Logger.getLogger(Utilitaire.class.getName()).log(Level.SEVERE, null,
                    ex);
        }
        Date date2 = new Date();
        try {
            date2 = new SimpleDateFormat("yyyy-mm-dd").parse(dateRetourSuppose);
        } catch (ParseException ex) {
            Logger.getLogger(Utilitaire.class.getName()).log(Level.SEVERE, null,
                    ex);
        }
        Contrat contrat = new Contrat(num, client, vehicule, date1, date2,
                date2, new Date(), new BigDecimal(0));
        startTransaction();
        if (contrat != null) {
            session.save(contrat);
            session.getTransaction().commit();
            numErr = 0;
        } else {
            numErr = 100;
        }

        finishTransaction();
        return numErr;
    }

}
