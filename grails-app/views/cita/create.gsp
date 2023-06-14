<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main" />
    <title>Registrar Cita</title>
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
            <p id="confirmation-texto-cita">Cita Registrada Correctamente</p>
        </div>
    </div>
    <h1 class="titulo">Registrar Cita</h1>
    <div id="create-cita" class="content scaffold-create" role="main">
        <g:form resource="${this.cita}" method="POST">
            <div class="form">
                <div class="form-group">
                    <label for="fecha">Fecha:</label>
                    <input required type="date" id="fecha" name="fecha" value="${cita?.fecha}" class="form-control"/>
                </div>
                <div class="form-group">
                    <label for="hora">Hora Inicio:</label>
                    <input required type="time" id="hora" name="hora" value="${cita?.hora}" class="form-control"/>
                </div>
                <div class="form-group">
                    <label for="horaFinal">Hora Final:</label>
                    <input required type="time" id="horaFinal" name="horaFinal" value="${cita?.horaFinal}" class="form-control"/>
                </div>
                <div class="form-group">
                    <label for="paciente">Paciente:</label>
                    <input autocomplete="off" required type="text" id="paciente" name="paciente" value="${cita?.paciente}" class="form-control"/>
                </div>
                <div class="form-group">
                    <label for="doctor">Doctor:</label>
                    <g:select id="doctor" name="doctor.id" from="${doctorList}" optionKey="id" optionValue="nombre"
                              value="${cita?.doctor?.id}" class="form-control"/>
                </div>
                <div class="form-group">
                    <label for="hospital">Hospital:</label>
                    <g:select id="hospital" name="hospital.id" from="${hospitalList}" optionKey="id" optionValue="nombre"
                              value="${cita?.hospital?.id}" class="form-control"/>
                </div>
                <div class="buttons">
                    <div type="submit" name="create" class="save" onclick="crearCita()">Crear</div>
                    <g:link class="cancelBotton" action="index">Cancelar</g:link>
                </div>
            </div>
        </g:form>
    </div>
</div>
</body>
</html>
