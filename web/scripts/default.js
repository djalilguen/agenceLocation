window.onload=function(){
	getItems('marque', marques);
        getItems('model', modeles);
        getItems('categorie', categories);
        getItems('transmission',transmissions)
}

// les marques des vehicules 

var transmissions = {
    '':'',
    Automatique: 'Automatique',
    Manuelle: 'Manuelle'
};

var marques = {
    '':'',
    Honda: 'Honda',
    Nissan: 'Nissan'
};

var modeles = {
    '':'',
    Civic: 'Civic',
    CRV: 'CRV',
    Rogue:'Rogue'
};
var categories = {
    Berline: 'Berline',
    VUS: 'VUS',
    '4X4':'4X4'
};
function getItems(champ,object) {
    var select = document.getElementById(champ);
    for (index in object) {
        select.options[select.options.length] = new Option(index, object[index]);
    }
}
