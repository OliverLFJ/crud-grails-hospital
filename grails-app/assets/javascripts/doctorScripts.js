
//FUNCIONES BORRAR DOCTOR
var jsonData;
var citaPopDoctor = document.getElementById('idPopUpDoctor')
var popUpEspecialidad = document.getElementById('especialidadPopUpDoctor')
var popUpNombre = document.getElementById('nombrePopUpDoctor')
var contentPopDoctor = document.getElementById('container-pop-doctor')
var confirmationDivDoctor = document.getElementById('confirmation-doctor')
var popUpDoctor = document.getElementById('popDeleteDoctor')
var loaderDoctor = document.getElementById('contenedor-load-doctor')

var idCancelDoctor=0
function openPopDeleteDoctor(id){
    $.ajax({
        url: '/doctor/show/'+id,
        method: 'GET',
        dataType: 'json',
        success: function(data) {
            jsonData = data;
            llenarPopDoctor()
        }
    });
    contentPopDoctor.style.display = 'inline-grid'
    popUpDoctor.style.visibility="visible"
    popUpDoctor.style.transition = "all 0.3s ease-in-out"
    popUpDoctor.style.opacity = 1
    popUpDoctor.style.zIndex = 4
}
function llenarPopDoctor() {
    citaPopDoctor.innerHTML = citaPopDoctor.innerHTML + " " + jsonData.id;
    popUpEspecialidad.innerHTML = popUpEspecialidad.innerHTML + " " + jsonData.especialidad;
    popUpNombre.innerHTML = popUpNombre.innerHTML + " " + jsonData.nombre;
    idCancelDoctor=jsonData.id
}
function closePopDeleteDoctor(){
    popUpDoctor.style.visibility="hidden"
    popUpDoctor.style.transition = "all 0.3s ease-in-out"
    popUpDoctor.style.opacity = 0
    setTimeout(function() {
        citaPopDoctor.innerHTML = "ID:";
        popUpEspecialidad.innerHTML = "ESPECIALIDAD:";
        popUpNombre.innerHTML = "NOMBRE:";
    }, 500);
}
function cancelDoctor(){
    contentPopDoctor.style.display = 'none'
    loaderDoctor.style.display = 'inline-grid'
    setTimeout(function() {
        loaderDoctor.style.display = 'none'
        confirmationDivDoctor.style.opacity = 1
        confirmationDivDoctor.style.transition = "all 0.3s ease-in-out"
        confirmationDivDoctor.style.zIndex=15
    }, 2000);
    setTimeout(function() {
        $.ajax({
            url: '/doctor/delete/'+idCancelDoctor,
            method: 'DELETE',
            success: function(response) {
                if (response.status === 'success') {
                    window.location.href = response.redirectUrl;
                }
            }
        });
    }, 4000);
}



//Crear Doctor

var popUpCrearDoctor = document.getElementById('popCreateDoctor')
var loaderDoctorCreate = document.getElementById('confirmation-doctor-create')
var popUpContentCreateDoctor = document.getElementById('contenedor-load-doctor-create')


function crearDoctor(){
    var doctor = {
        nombre: document.getElementById('nombre').value,
        apellidoM: document.getElementById('apellidoM').value,
        apellidoP: document.getElementById('apellidoP').value,
        especialidad: document.getElementById('especialidad').value
    };
    setTimeout(function() {
        popUpCrearDoctor.style.display = 'inline-flex';
        popUpCrearDoctor.style.opacity = 1;
        popUpCrearDoctor.style.transition = 'all 0.5s ease-in-out';
        setTimeout(function() {
            popUpContentCreateDoctor.style.display = 'none';
            loaderDoctorCreate.style.display = 'inline-flex';
            setTimeout(function() {
                var request = $.ajax({
                    url: '/doctor/save',
                    method: 'POST',
                    data: doctor
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


function actualizarDoctor(){
    var id = document.getElementById('version').value
    var doctor2 = {
        nombre: document.getElementById('nombre').value,
        apellidoM: document.getElementById('apellidoM').value,
        apellidoP: document.getElementById('apellidoP').value,
        especialidad: document.getElementById('especialidad').value
    };
    setTimeout(function() {
        popUpCrearDoctor.style.display = 'inline-flex';
        popUpCrearDoctor.style.opacity = 1;
        popUpCrearDoctor.style.transition = 'all 0.5s ease-in-out';
        setTimeout(function() {
            popUpContentCreateDoctor.style.display = 'none';
            loaderDoctorCreate.style.display = 'inline-flex';
            setTimeout(function() {
                var request = $.ajax({
                    url: '/doctor/update/'+ id,
                    method: 'PUT',
                    data: doctor2
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