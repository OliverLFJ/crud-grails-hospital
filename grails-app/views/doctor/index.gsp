<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>Doctores</title>
    <asset:link rel="stylesheet" href="application.css"/>
</head>

<body>
<h1 class="titulo">Lista Doctores</h1>

<div id="content" role="main">
    <div class="container-main">
        <section class="row">
            <div class="nav" role="navigation">
                <ul>
                    <li><g:link class="addButton" action="create">Agregar Doctor</g:link></li>
                </ul>
            </div>
        </section>
        <section class="lista">
            <div id="list-doctor" role="main">
                <table class="table-doctor">
                    <thead>
                    <tr>
                        <th>#</th>
                        <th>Nombre</th>
                        <th>Especialidad</th>
                        <th>Acciones</th>
                    </tr>
                    </thead>
                    <tbody>
                    <g:each in="${doctorList}" var="doctor" status="i">
                        <tr class="${(i % 2 == 0) ? 'row-blue' : 'row-blueStrong'}">
                            <td>${doctor.id}</td>
                            <td>${doctor.nombre} ${doctor.apellidoP} ${doctor.apellidoM}</td>
                            <td>${doctor.especialidad}</td>
                            <td><g:form resource="${doctor}">
                                <div class="buttons">
                                    <g:link class="edit" action="edit" resource="${doctor}">Editar</g:link>
                                    <div class="delete-button" type="submit" onclick="openPopDeleteDoctor(${doctor.id})">Eliminar</div>
                                    <div class="pop-up-doctor" id="popDeleteDoctor">
                                        <div class="container-pop-doctor" id="container-pop-doctor">
                                            <div class="body-pop-doctor">
                                                <h2>¿Estás seguro de eliminar el doctor?</h2>
                                                <h5 id="idPopUpDoctor">DOCTOR:</h5>
                                                <h5 id="nombrePopUpDoctor">NOMBRE:</h5>
                                                <h5 id="especialidadPopUpDoctor">ESPECIALIDAD:</h5>
                                                <p>Una vez cancelada la cita ya no se podrá recuperar</p>
                                            </div>
                                            <div class="buttons-pop-doctor">
                                                <div class="siButton-doctor" onclick="cancelDoctor()">
                                                    Sí
                                                </div>
                                                <div class="noButton-doctor" onclick="closePopDeleteDoctor()">
                                                    No
                                                </div>
                                            </div>
                                        </div>
                                        <div id="contenedor-load-doctor">
                                            <div class="contenedor-load-doctor">
                                                <div class="contenedor-loader-doctor">
                                                    <div class="rueda-doctor"></div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </g:form></td>
                        </tr>
                    </g:each>
                    </tbody>
                </table>
                <g:if test="${doctorCount > params.int('max')}">
                    <div class="pagination">
                        <g:paginate total="${doctorCount ?: 0}"/>
                    </div>
                </g:if>
            </div>
        </section>
    </div>
</div>
<div class="confirmation-cancel-doctor" id="confirmation-doctor" data-visibilidad="oculto">
    <div class="text-confirmation">
        <p>Doctor Eliminado Correctamente</p>
    </div>
</div>
</body>
</html>