--création de la table client
CREATE TABLE client (
  numClient number(7) CONSTRAINT client_numclient_pk PRIMARY KEY,
  nom_client varchar2(30) NOT NULL,
  prenom_client varchar2(30) NOT NULL,
  adresse varchar2(100) NOT NULL,
  ville varchar2(20)NOT NULL,
  code_postal varchar2(6) NOT NULL,
  age number(3) NOT NULL,
  permis varchar2(20)NOT NULL,
  telephone varchar2(10) NOT NULL,
  courriel varchar2(50) NOT NULL
) ;

--création de la table contact
CREATE TABLE contact (
  num_contact number(5) CONSTRAINT contact_numContact_pk PRIMARY KEY,
  message varchar2(140) NOT NULL,
  dateMessage date NOT NULL,
  sujet varchar2(50) NOT NULL,
  numClient number(7) NOT NULL CONSTRAINT contact_noclient_fk REFERENCES client(numClient)
); 

--création de la table modele
CREATE TABLE modele (
  code_model number(3) CONSTRAINT modele_codeModel_pk PRIMARY KEY,
  nom_model varchar2(20) NOT NULL,
  marque varchar2(20) NOT NULL,
  puissance number(2,1) NOT NULL,
  tarif_jour number(5,2) NOT NULL,
  photo varchar2(100) NOT NULL
);

--création de la table véhicule
CREATE TABLE vehicule (
  matricule varchar2(10) CONSTRAINT vehicule_matricule_pk PRIMARY KEY,
  code_model number(3) NOT NULL CONSTRAINT vehicule_codeModel_fk REFERENCES modele(code_model),
  categorie varchar2(20) NOT NULL,
  nbPlaces number(2) NOT NULL,
  automatique number(1) NOT NULL CONSTRAINT vehicule_auto_ck CHECK(automatique BETWEEN 0 AND 1)
);

--création de la table contrat
CREATE TABLE contrat (
  num_contrat number(7) CONSTRAINT contrat_numContrat_pk PRIMARY KEY ,
  date_depart date NOT NULL,
  date_retour_suppose date NOT NULL,
  date_retour_effective date NOT NULL,
  date_contrat date NOT NULL,
  caution number(5,2) NOT NULL,
  numClient number(3) NOT NULL CONSTRAINT contrat_noclient_fk REFERENCES client(numClient),
  matricule varchar2(10) NOT NULL CONSTRAINT contrat_matricule_fk REFERENCES vehicule(matricule)
);
CREATE SEQUENCE client_noclient_seq
INCREMENT BY 1 NOCACHE NOCYCLE ;

--insertion dans la table modele
INSERT INTO modele (code_model, nom_model, marque, puissance, tarif_jour, photo) VALUES
(1, 'civic', 'honda', 2.0, 30.00, 'TPA11\\web\\images\\cars\\civic.png');
INSERT INTO modele (code_model, nom_model, marque, puissance, tarif_jour, photo) VALUES
(2, 'crv', 'honda', 2.5, 50.00, 'TPA11\\web\\images\\cars\\crv.png');
INSERT INTO modele (code_model, nom_model, marque, puissance, tarif_jour, photo) VALUES
(3, 'rogue', 'nissan', 3.2, 55.00, 'TPA11\\web\\images\\cars\\rogue.png');

--insertion dans la table véhicule
INSERT INTO vehicule (matricule, code_model, categorie, nbPlaces, automatique) VALUES
('civ1234hon', 1, 'berline', 5, 1);
INSERT INTO vehicule (matricule, code_model, categorie, nbPlaces, automatique) VALUES
('civ5678hon', 1, 'berline', 5, 0);
INSERT INTO vehicule (matricule, code_model, categorie, nbPlaces, automatique) VALUES
('crv1234hon', 2, 'vus', 5, 1);
INSERT INTO vehicule (matricule, code_model, categorie, nbPlaces, automatique) VALUES
('crv5678hon', 2, 'vus', 5, 0);
INSERT INTO vehicule (matricule, code_model, categorie, nbPlaces, automatique) VALUES
('rog1234nis', 3, '4x4', 7, 1);
INSERT INTO vehicule (matricule, code_model, categorie, nbPlaces, automatique) VALUES
('rog5678nis', 3, '4x4', 7, 0);