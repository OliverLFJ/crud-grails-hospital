<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <title>Actualizar Cita</title>
    </head>
    <body>
    <div id="content" role="main">
        <div class="pop-up-citas-create" id="popCreateCitas">
            <div id="contenedor-load-citas-create">
                <div class="contenedor-load-doctor">
                    <div class="contenedor-loader-doctor">
                        <div class="rueda-doctor"></div>
                    </div>
                </div>
            </div>
        </div>
        <div class="confirmation-citas-doctor" id="confirmation-citas-create" data-visibilidad="oculto">
            <div class="text-confirmation">
                <p id="confirmation-texto-cita">Cita Actualizada Correctamente</p>
            </div>
        </div>
    <h1 class="titulo">Actualizar Cita</h1>
        <div id="edit-cita" class="content scaffold-edit" role="main">
            <g:form resource="${this.cita}" method="POST">
                <input type="hidden" id="version" name="version" value="${cita?.id}" />
                <div class="form">
                    <div class="form-group">
                        <label for="fecha">Fecha:</label>
                        <input type="date" id="fecha" name="fecha"  value="${cita?.fecha}" class="form-control"/>
                    </div>
                    <div class="form-group">
                        <label for="hora">Hora:</label>
                        <g:set var="horaString" value="${cita?.hora}" />
                        <g:if test="${horaString}">
                            <g:set var="hora" value="${java.time.LocalTime.parse(horaString, java.time.format.DateTimeFormatter.ofPattern('hh:mm a'))}" />
                            <g:set var="formattedHora" value="${hora.format(java.time.format.DateTimeFormatter.ofPattern('HH:mm'))}" />
                        </g:if>
                        <input type="time" id="hora" name="hora" value="${formattedHora ?: ''}" class="form-control" />
                    </div>
                    <div class="form-group">
                        <label for="horaFinal">Hora Final:</label>
                        <g:set var="horaFinalString" value="${cita?.horaFinal}" />
                        <g:if test="${horaFinalString}">
                            <g:set var="horaFinal" value="${java.time.LocalTime.parse(horaFinalString, java.time.format.DateTimeFormatter.ofPattern('hh:mm a'))}" />
                            <g:set var="formattedHoraFinal" value="${horaFinal.format(java.time.format.DateTimeFormatter.ofPattern('HH:mm'))}" />
                        </g:if>
                        <input type="time" id="horaFinal" name="horaFinal" value="${formattedHoraFinal ?: ''}" class="form-control" />
                    </div>
                    <div class="form-group">
                        <label for="paciente">Paciente:</label>
                        <input type="text" id="paciente" name="paciente" value="${cita?.paciente}" class="form-control"/>
                    </div>
                    <div class="form-group">
                        <label for="doctor">Doctor:</label>
                        <g:select id="doctor" name="doctor.id" from="${doctorList}" optionKey="id" optionValue="nombre"
                                  value="${cita?.doctor?.id}" class="form-control"/>
                    </div>
                    <div class="form-group">
                        <label for="doctor">Hospital:</label>
                        <g:select id="hospital" name="hospital.id" from="${hospitalList}" optionKey="id" optionValue="nombre"
                                  value="${cita?.hospital?.id}" class="form-control"/>
                    </div>
                    <div class="buttons">
                        <div type="submit" name="create" class="save" onclick="actualizarCita()" data-metodo="actualizar">Actualizar</div>
                        <g:link class="cancelBotton" action="index">Cancelar</g:link>
                    </div>
                </div>
            </g:form>
        </div>
    </div>
    </body>
</html>
