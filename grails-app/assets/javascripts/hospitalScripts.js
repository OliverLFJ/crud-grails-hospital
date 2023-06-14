
//FUNCIONES BORRAR HOSPITAL
var jsonData;
var hospitalPopHospital = document.getElementById('idPopUpHospital')
var popUpNombreHospital = document.getElementById('nombrePopUpHospital')
var popUpDireccion = document.getElementById('direccionPopUpHospital')
var contentPopHospital = document.getElementById('container-pop-hospital')
var confirmationDivHospital = document.getElementById('confirmation-hospital')
var popUpHospital = document.getElementById('popDeleteHospital')
var loaderHospital = document.getElementById('contenedor-load-hospital')

var idCancelHospital=0
function openPopDeleteHospital(id){
    $.ajax({
        url: '/hospital/show/'+id,
        method: 'GET',
        dataType: 'json',
        success: function(data) {
            jsonData = data;
            llenarPopHospital()
        }
    });
    contentPopHospital.style.display = 'inline-grid'
    popUpHospital.style.visibility="visible"
    popUpHospital.style.transition = "all 0.3s ease-in-out"
    popUpHospital.style.opacity = 1
    popUpHospital.style.zIndex = 4
}
function llenarPopHospital() {
    hospitalPopHospital.innerHTML = hospitalPopHospital.innerHTML + " " + jsonData.id;
    popUpDireccion.innerHTML = popUpDireccion.innerHTML + " " + jsonData.direccion;
    popUpNombreHospital.innerHTML = popUpNombreHospital.innerHTML + " " + jsonData.nombre;
    idCancelHospital=jsonData.id
}
function closePopDeleteHospital(){
    popUpHospital.style.visibility="hidden"
    popUpHospital.style.transition = "all 0.3s ease-in-out"
    popUpHospital.style.opacity = 0
    setTimeout(function() {
        hospitalPopHospital.innerHTML = "ID:";
        popUpDireccion.innerHTML = "DIRECCION:";
        popUpNombreHospital.innerHTML = "NOMBRE:";
    }, 500);
}
function cancelHospital(){
    contentPopHospital.style.display = 'none'
    loaderHospital.style.display = 'inline-grid'
    setTimeout(function() {
        loaderHospital.style.display = 'none'
        confirmationDivHospital.style.opacity = 1
        confirmationDivHospital.style.transition = "all 0.3s ease-in-out"
        confirmationDivHospital.style.zIndex=15
    }, 2000);
    setTimeout(function() {
        $.ajax({
            url: '/hospital/delete/'+idCancelHospital,
            method: 'DELETE',
            success: function(response) {
                if (response.status === 'success') {
                    window.location.href = response.redirectUrl;
                }
            }
        });
    }, 4000);
}


//Crear Hospital

var popUpCrearHospital = document.getElementById('popCreateHospital')
var loaderHospitalCreate = document.getElementById('confirmation-hospital-create')
var popUpContentCreate = document.getElementById('contenedor-load-hospital-create')


function crearHospital(){
    var hospital = {
        nombre: document.getElementById('nombre').value,
        direccion: document.getElementById('direccion').value,
        pisos: document.getElementById('pisos').value
    };
    setTimeout(function() {
        popUpCrearHospital.style.display = 'inline-flex';
        popUpCrearHospital.style.opacity = 1;
        popUpCrearHospital.style.transition = 'all 0.5s ease-in-out';
        setTimeout(function() {
            popUpContentCreate.style.display = 'none';
            loaderHospitalCreate.style.display = 'inline-flex';
            setTimeout(function() {
                var request = $.ajax({
                    url: '/hospital/save',
                    method: 'POST',
                    data: hospital
                });
                request.done(function(response) {
                    if (response.status === 'success') {
                        window.location.href = response.redirectUrl;
                    }
                });
                request.fail(function(xhr, status, error) {
                    console.log('Error:', error);
                });
            }, 2000);
        }, 2000);
    }, 100);
}

function actualizarHospital(){
    var id = document.getElementById('version').value
    var hospital2 = {
        nombre: document.getElementById('nombre').value,
        direccion: document.getElementById('direccion').value,
        pisos: document.getElementById('pisos').value
    };
    setTimeout(function() {
        popUpCrearHospital.style.display = 'inline-flex';
        popUpCrearHospital.style.opacity = 1;
        popUpCrearHospital.style.transition = 'all 0.5s ease-in-out';
        setTimeout(function() {
            popUpContentCreate.style.display = 'none';
            loaderHospitalCreate.style.display = 'inline-flex';
            setTimeout(function() {
                var request = $.ajax({
                    url: '/hospital/update/'+ id,
                    method: 'PUT',
                    data: hospital2
                });
                request.done(function(response) {
                    if (response.status === 'success') {
                        window.location.href = response.redirectUrl;
                    }
                });
                request.fail(function(xhr, status, error) {
                    console.log('Error:', error);
                });
            }, 2000);
        }, 2000);
    }, 100);
}