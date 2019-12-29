//alert("js.js");
window.onload=function(){
	var monobjet_json = localStorage.getItem("carsObj");
	var monobjet = JSON.parse(monobjet_json);
	var img;
	var prix;
	
	var ePrix = document.getElementsByClassName("pAnnonce");
	var eImg = document.getElementsByClassName("imgAnnonce");
	var eDetails = document.getElementsByClassName("detailsAnnonce");
	
	for (var i = 0; i < eImg.length; i+= 1) {
		img=monobjet.cars[i].modele+ ".png";
		eImg[i].src = "images/cars/"+img; // image du vehicule
		//eImg[i].setAttribute("onclick", "details(this.name);")
		prix=monobjet.cars[i].prixJ+ " $"; // prix journalier
		ePrix[i].innerHTML = prix;
		eDetails[i].setAttribute("onclick", "afficherDetails(i);")
		
	}
}

function afficherDetails(i){
	//alert("detailsAnnonce");
}







