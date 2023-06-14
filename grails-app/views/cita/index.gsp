<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>Citas</title>
    <asset:link rel="stylesheet" href="application.css"/>
</head>

<body>
<h1 class="titulo">Lista de Citas</h1>
<div id="content" role="main">
    <div class="container-main">
        <section class="row">
            <div class="nav" role="navigation">
                <ul>
                    <li><g:link class="addButton" action="create">Agregar Cita</g:link></li>
                </ul>
            </div>
        </section>
        <section class="filtros">
            <g:form class="filtros" method="GET" action="${createLink(controller: 'cita', action: 'index')}">
                <div class="filtro">
                <label for="fechaFiltro">Fecha:</label>
                    <input type="date" id="fechaFiltro" name="fechaFiltro" value="${params.fecha}"/>
            </div>
            <div class="filtro">
                <label for="hospitalFiltro">Hospital:</label>
                    <g:select id="hospitalFiltro" class="selectFiltro" name="hospitalFiltro" from="${hospitalList}" optionKey="id" optionValue="nombre"
                              value="${params.hospital}" noSelection="['':'Todos']" />
            </div>
            <div class="filtro">
                <label for="doctorFiltro">Doctor:</label>
                    <g:select id="doctorFiltro" class="selectFiltro" name="doctorFiltro" from="${doctorList}" optionKey="id" optionValue="nombre"
                              value="${params.doctor}" noSelection="['':'Todos']" />
            </div>
                <div class="submitButtonFiltrar" onclick="filtrarCitas()">Filtrar</div>
                <g:link class="submitButtonFiltrar" action="index">Reiniciar</g:link>
            </g:form>
        </section>
        <section class="lista">
            <div id="list-cita" role="main">
                <table>
                    <thead>
                    <tr>
                        <th>#</th>
                        <th>Paciente</th>
                        <th>Fecha</th>
                        <th>Hora</th>
                        <th>Hora Final</th>
                        <th>Hospital</th>
                        <th>Doctor</th>
                        <th>Acciones</th>
                    </tr>
                    </thead>
                    <tbody>
                    <g:each in="${citaList}" var="cita" status="i">
                        <tr class="${(i % 2 == 0) ? 'row-blue' : 'row-blueStrong'}">
                            <td>${cita.id}</td>
                            <td>${cita.paciente}</td>
                            <td>${cita.fecha}</td>
                            <td>${cita.hora}</td>
                            <td>${cita.horaFinal}</td>
                            <td>${cita.hospital.nombre}</td>
                            <td>${cita.doctor.nombre}</td>
                            <td><g:form resource="${cita}">
                                <div class="buttons">
                                    <g:link class="edit" action="edit" resource="${cita}">Editar</g:link>
                                    <div class="delete-button" type="submit" onclick="openPopDelete(${cita.id})">Cancelar</div>
                                    <div class="pop-up" id="popDelete">
                                        <div class="container-pop" id="container-pop">
                                            <div class="body-pop">
                                                <h2>¿Estás seguro de cancelar la cita?</h2>
                                                <h5 id="citaPopUp">CITA:</h5>
                                                <h5 id="fechaPopUp">FECHA:</h5>
                                                <h5 id="pacientePopUp">PACIENTE:</h5>
                                                <p>Una vez cancelada la cita ya no se podrá recuperar</p>
                                            </div>
                                            <div class="buttons-pop">
                                                <div class="siButton" onclick="cancelCita()">
                                                    Sí
                                                </div>
                                                <div class="noButton" onclick="closePopDelete()">
                                                    No
                                                </div>
                                            </div>
                                        </div>
                                        <div id="contenedor-load">
                                            <div class="contenedor-load">
                                                <div class="contenedor-loader">
                                                    <div class="rueda"></div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </g:form>
                            </td>
                        </tr>
                    </g:each>
                    </tbody>
                </table>
                <g:if test="${citaCount > params.int('max')}">
                    <div class="pagination">
                        <g:paginate total="${citaCount ?: 0}"/>
                    </div>
                </g:if>
            </div>
        </section>
    </div>
</div>
<div class="confirmation-cancel" id="confirmation-Cita" data-visibilidad="oculto">
    <div class="text-confirmation" id="texto-cita-crear">
        <p id="probando">Cita cancelada correctamente</p>
    </div>
</div>
</body>
</html>