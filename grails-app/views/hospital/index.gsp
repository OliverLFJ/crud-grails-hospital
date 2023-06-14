<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>Hospitales</title>
</head>

<body>
<h1 class="titulo">Lista de Hospitales</h1>

<div id="content" role="main">
    <div class="container-main">
        <section class="row">
            <div class="nav" role="navigation">
                <g:link class="addButton" action="create">Agregar Hospital</g:link>
            </div>
        </section>
        <section class="lista">
            <div id="list-hospital" role="main">
                <table class="table-hospital">
                    <thead>
                    <tr>
                        <th>#</th>
                        <th>Nombre</th>
                        <th>Dirección</th>
                        <th>Pisos</th>
                        <th>Acciones</th>
                    </tr>
                    </thead>
                    <tbody>
                    <g:each in="${hospitalList}" var="hospital" status="i">
                        <tr class="${(i % 2 == 0) ? 'row-blue' : 'row-blueStrong'}">
                            <td>${hospital.id}</td>
                            <td>${hospital.nombre}</td>
                            <td>${hospital.direccion}</td>
                            <td>${hospital.pisos}</td>
                            <td><g:form resource="${hospital}" method="DELETE">
                                <div class="buttons">
                                    <g:link class="edit" action="edit" resource="${hospital}">Editar</g:link>
                                    <div class="delete-button" type="submit" onclick="openPopDeleteHospital(${hospital.id})">Eliminar</div>
                                    <div class="pop-up-hospital" id="popDeleteHospital">
                                        <div class="container-pop-hospital" id="container-pop-hospital">
                                            <div class="body-pop-hospital">
                                                <h2>¿Estás seguro de eliminar el hospital?</h2>
                                                <h5 id="idPopUpHospital">HOSPITAL:</h5>
                                                <h5 id="nombrePopUpHospital">NOMBRE:</h5>
                                                <h5 id="direccionPopUpHospital">DIRECCIÓN:</h5>
                                                <p>Una vez eliminado el hospital ya no se podrá recuperar</p>
                                            </div>
                                            <div class="buttons-pop-hospital">
                                                <div class="siButton-hospital" onclick="cancelHospital()">
                                                    Sí
                                                </div>
                                                <div class="noButton-hospital" onclick="closePopDeleteHospital()">
                                                    No
                                                </div>
                                            </div>
                                        </div>
                                        <div id="contenedor-load-hospital">
                                            <div class="contenedor-load-hospital">
                                                <div class="contenedor-loader-hospital">
                                                    <div class="rueda-hospital"></div>
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
                <g:if test="${hospitalCount > params.int('max')}">
                    <div class="pagination">
                        <g:paginate total="${hospitalCount ?: 0}"/>
                    </div>
                </g:if>
            </div>
        </section>
    </div>
</div>
<div class="confirmation-cancel-hospital" id="confirmation-hospital" data-visibilidad="oculto">
    <div class="text-confirmation">
        <p>Hospital Eliminado Correctamente</p>
    </div>
</div>
</body>
</html>