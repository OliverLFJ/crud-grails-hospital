
var jsonData;
var citaPop = document.getElementById('citaPopUp')
var fechaPop = document.getElementById('fechaPopUp')
var pacientePop = document.getElementById('pacientePopUp')
var popUpCita = document.getElementById('popDelete')
var confirmationDiv = document.getElementById('confirmation-Cita')
var contentPopCita = document.getElementById('container-pop')
var loaderCita = document.getElementById('contenedor-load')
var idCancelCita=0
var popUpCrearCita = document.getElementById('popCreateCitas')
var loaderCitaCreate = document.getElementById('contenedor-load-citas-create')
var popUpContentCita = document.getElementById('confirmation-citas-create')
var contenidoMensaje = document.getElementById('confirmation-texto-cita')
var contenidoMensajeSecond = document.getElementById('probando')

function openPopDelete(id){
    $.ajax({
        url: '/cita/show/'+id,
        method: 'GET',
        dataType: 'json',
        success: function(data) {
            jsonData = data;
            llenarPop()
        }
    });
        contentPopCita.style.display = 'inline-grid'
        popUpCita.style.visibility="visible"
        popUpCita.style.transition = "all 0.3s ease-in-out"
        popUpCita.style.opacity = 1
        popUpCita.style.zIndex = 4
}
function llenarPop() {
    citaPop.innerHTML = citaPop.innerHTML + " " + jsonData.id;
    fechaPop.innerHTML = fechaPop.innerHTML + " " + jsonData.fecha;
    pacientePop.innerHTML = pacientePop.innerHTML + " " + jsonData.paciente;
    idCancelCita=jsonData.id
}
function closePopDelete(){
    popUpCita.style.visibility="hidden"
    popUpCita.style.transition = "all 0.3s ease-in-out"
    popUpCita.style.opacity = 0
    setTimeout(function() {
        citaPop.innerHTML = "CITA:";
        fechaPop.innerHTML = "FECHA";
        pacientePop.innerHTML = "PACIENTE:";
    }, 500);
}
function cancelCita(){
    contentPopCita.style.display = 'none'
    loaderCita.style.display = 'inline-grid'
    $.ajax({
        url: '/cita/delete/'+idCancelCita,
        method: 'DELETE',
        success: function(response) {
            if (response.status === 'success') {
                setTimeout(function() {
                loaderCita.style.display = 'none'
                confirmationDiv.style.opacity = 1
                confirmationDiv.style.transition = "all 0.3s ease-in-out"
                confirmationDiv.style.zIndex=15
                    setTimeout(function() {
                        window.location.href = response.redirectUrl;
                    }, 2000);
                }, 2000);
            }
            if (response.status === 'errorFecha') {
                setTimeout(function() {
                    loaderCita.style.display = 'none'
                    confirmationDiv.style.opacity = 1
                    confirmationDiv.style.transition = "all 0.3s ease-in-out"
                    confirmationDiv.style.zIndex=15
                    confirmationDiv.style.backgroundColor='red'
                    contenidoMensajeSecond.innerHTML='La fecha de la cita esta activa para el dia de hoy'
                    setTimeout(function() {
                        window.location.href = response.redirectUrl;
                    }, 3000);
                }, 2000);
            }
        }
    });
}

// Crear Cita
function crearCita(){

    var cita = {
        fecha: document.getElementById('fecha').value,
        hora: document.getElementById('hora').value,
        horaFinal: document.getElementById('horaFinal').value,
        paciente: document.getElementById('paciente').value,
        doctor: document.getElementById('doctor').value,
        hospital: document.getElementById('hospital').value
    };

    setTimeout(function() {
        popUpCrearCita.style.display='inline-flex'
        popUpCrearCita.style.opacity=1
        popUpCrearCita.style.transition = 'all 0.5s ease-in-out';
            setTimeout(function() {
                var request = $.ajax({
                    url: '/cita/save',
                    method: 'POST',
                    data: cita
                });
                request.done(function(response) {
                    if (response.status === 'success') {
                        setTimeout(function() {
                            loaderCitaCreate.style.display = 'none';
                            popUpContentCita.style.display = 'inline-flex';
                            popUpContentCita.style.opacity = 1
                            setTimeout(function() {
                               window.location.href = response.redirectUrl;
                            }, 2000);
                        }, 2000);
                    }else if (response.status === 'error1') {
                        setTimeout(function() {
                            loaderCitaCreate.style.display = 'none';
                            popUpContentCita.style.display = 'inline-flex';
                            popUpContentCita.style.opacity = 1
                            popUpContentCita.style.backgroundColor = 'orange'
                            contenidoMensaje.innerHTML = "No se puede registrar una cita a la misma hora en el mismo consultorio";
                            setTimeout(function() {
                                window.location.href = response.redirectUrl;
                            }, 3500);
                        }, 1000);
                    }else if (response.status === 'error2') {
                        setTimeout(function() {
                            loaderCitaCreate.style.display = 'none';
                            popUpContentCita.style.display = 'inline-flex';
                            popUpContentCita.style.opacity = 1
                            popUpContentCita.style.backgroundColor = 'orange'
                            contenidoMensaje.innerHTML = "No se puede registrar una cita a la misma hora para el mismo doctor";
                            setTimeout(function() {
                                window.location.href = response.redirectUrl;
                            }, 3500);
                        }, 1000);
                    }else if (response.status === 'error3') {
                        setTimeout(function() {
                            loaderCitaCreate.style.display = 'none';
                            popUpContentCita.style.display = 'inline-flex';
                            popUpContentCita.style.opacity = 1
                            popUpContentCita.style.backgroundColor = 'orange'
                            contenidoMensaje.innerHTML = "No se puede registrar una cita antes de dos horas a otra cita";
                            setTimeout(function() {
                                window.location.href = response.redirectUrl;
                            }, 4000);
                        }, 1000);
                    }else if (response.status === 'error4') {
                        setTimeout(function() {
                            loaderCitaCreate.style.display = 'none';
                            popUpContentCita.style.display = 'inline-flex';
                            popUpContentCita.style.opacity = 1
                            popUpContentCita.style.backgroundColor = 'orange'
                            contenidoMensaje.innerHTML = "La hora final no puede ser menor que la hora inicial";
                            setTimeout(function() {
                                window.location.href = response.redirectUrl;
                            }, 4000);
                        }, 1000);
                    }else if (response.status === 'error5') {
                        setTimeout(function() {
                            loaderCitaCreate.style.display = 'none';
                            popUpContentCita.style.display = 'inline-flex';
                            popUpContentCita.style.opacity = 1
                            popUpContentCita.style.backgroundColor = 'orange'
                            contenidoMensaje.innerHTML = "El Doctor no puede tener mas de 8 citas al dia";
                            setTimeout(function() {
                                window.location.href = response.redirectUrl;
                            }, 4000);
                        }, 1000);
                    }
                });

                request.fail(function(xhr, status, error) {
                    console.log('Error:', error);
                });
            }, 2000);
    }, 100);
}

function actualizarCita(){
    var id = document.getElementById('version').value
    var cita2 = {
        fecha: document.getElementById('fecha').value,
        hora: document.getElementById('hora').value,
        horaFinal: document.getElementById('horaFinal').value,
        paciente: document.getElementById('paciente').value,
        doctor: document.getElementById('doctor').value,
        hospital: document.getElementById('hospital').value
    };
    setTimeout(function() {
        popUpCrearCita.style.display='inline-flex'
        popUpCrearCita.style.opacity=1
        popUpCrearCita.style.transition = 'all 0.5s ease-in-out';
            setTimeout(function() {
                var request = $.ajax({
                    url: '/cita/update/'+ id,
                    method: 'PUT',
                    data: cita2
                });
                request.done(function(response) {
                    if (response.status === 'success') {
                        setTimeout(function() {
                            loaderCitaCreate.style.display = 'none';
                            popUpContentCita.style.display = 'inline-flex';
                            popUpContentCita.style.opacity = 1
                            setTimeout(function() {
                                window.location.href = response.redirectUrl;
                            }, 2000);
                        }, 2000);
                    }else if (response.status === 'error1') {
                        setTimeout(function() {
                            loaderCitaCreate.style.display = 'none';
                            popUpContentCita.style.display = 'inline-flex';
                            popUpContentCita.style.opacity = 1
                            popUpContentCita.style.backgroundColor = 'orange'
                            contenidoMensaje.innerHTML = "No se puede registrar una cita a la misma hora en el mismo consultorio";
                            setTimeout(function() {
                                window.location.href = response.redirectUrl;
                            }, 3500);
                        }, 1000);
                    }else if (response.status === 'error2') {
                        setTimeout(function() {
                            loaderCitaCreate.style.display = 'none';
                            popUpContentCita.style.display = 'inline-flex';
                            popUpContentCita.style.opacity = 1
                            popUpContentCita.style.backgroundColor = 'orange'
                            contenidoMensaje.innerHTML = "No se puede registrar una cita a la misma hora para el mismo doctor";
                            setTimeout(function() {
                                window.location.href = response.redirectUrl;
                            }, 3500);
                        }, 1000);
                    }else if (response.status === 'error3') {
                        setTimeout(function() {
                            loaderCitaCreate.style.display = 'none';
                            popUpContentCita.style.display = 'inline-flex';
                            popUpContentCita.style.opacity = 1
                            popUpContentCita.style.backgroundColor = 'orange'
                            contenidoMensaje.innerHTML = "No se puede registrar una cita antes de dos horas a otra cita";
                            setTimeout(function() {
                                window.location.href = response.redirectUrl;
                            }, 4000);
                        }, 1000);
                    }else if (response.status === 'error4') {
                        setTimeout(function() {
                            loaderCitaCreate.style.display = 'none';
                            popUpContentCita.style.display = 'inline-flex';
                            popUpContentCita.style.opacity = 1
                            popUpContentCita.style.backgroundColor = 'orange'
                            contenidoMensaje.innerHTML = "La hora final no puede ser menor que la hora inicial";
                            setTimeout(function() {
                                window.location.href = response.redirectUrl;
                            }, 4000);
                        }, 1000);
                    }
                });
                request.fail(function(xhr, status, error) {
                    console.log('Error:', error);
                });
            }, 2000);
    }, 100);
}

function filtrarCitas() {
    const fecha = document.getElementById('fechaFiltro').value;
    const hospital = document.getElementById('hospitalFiltro').value;
    const doctor = document.getElementById('doctorFiltro').value;
    window.location.href = `/cita/index?fecha=${fecha}&hospital=${hospital}&doctor=${doctor}`;
}
const urlParams = new URLSearchParams(window.location.search);
const fechaParam = urlParams.get('fecha');
const hospitalParam = urlParams.get('hospital');
const doctorParam = urlParams.get('doctor');
if (fechaParam) {
    document.getElementById('fechaFiltro').value = fechaParam;
}
if (hospitalParam) {
    document.getElementById('hospitalFiltro').value = hospitalParam;
}
if (doctorParam) {
    document.getElementById('doctorFiltro').value = doctorParam;
}
