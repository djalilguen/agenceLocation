function showHide(id) {
    var NameDiv = document.getElementById(id);
    if (NameDiv.style.display === 'none') {
        NameDiv.style.display = 'block';
    } else {
        NameDiv.style.display = 'none';
    }
}
