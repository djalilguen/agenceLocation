
// table des vehicules disponible
var carsObj = '{"cars":[' +
'{"modele":"Honda","prixJ":"15","passagers":"5","transmission":"Automatique", "climatisation":"Oui","GPS":"Oui" },' +
'{"modele":"BMW","prixJ":"25","passagers":"5","transmission":"Automatique", "climatisation":"Oui","GPS":"Oui" },' +
'{"modele":"Mercedes","prixJ":"20","passagers":"5","transmission":"Manuelle", "climatisation":"Oui","GPS":"Oui" }]}';
var obj = JSON.parse(carsObj);
localStorage.setItem("carsObj", JSON.stringify(obj));








