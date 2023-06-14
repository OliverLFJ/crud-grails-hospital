<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <title>Actualizar Doctor</title>
    </head>
    <body>
    <div id="content" role="main">
        <div class="pop-up-doctor-create" id="popCreateDoctor">
            <div id="contenedor-load-doctor-create">
                <div class="contenedor-load-doctor">
                    <div class="contenedor-loader-doctor">
                        <div class="rueda-doctor"></div>
                    </div>
                </div>
            </div>
        </div>
        <div class="confirmation-create-doctor" id="confirmation-doctor-create" data-visibilidad="oculto">
            <div class="text-confirmation">
                <p>Doctor Registrado Correctamente</p>
            </div>
        </div>
    <h1 class="titulo">Actualizar Doctor</h1>
        <div id="edit-doctor" class="content scaffold-edit" role="main">
            <g:form resource="${this.doctor}">
                <input type="hidden" id="version" name="version" value="${this.doctor?.id}" />
                    <div class="form">
                        <div class="form-group">
                            <label for="nombre">Nombre:</label>
                            <input type="text" id="nombre" name="nombre" value="${doctor?.nombre}" class="form-control"/>
                        </div>
                        <div class="form-group">
                            <label for="apellidoP">Apellido Paterno:</label>
                            <input type="text" id="apellidoP" name="apellidoP" value="${doctor?.apellidoP}" class="form-control"/>
                        </div>
                        <div class="form-group">
                            <label for="apellidoM">Apellido Materno:</label>
                            <input type="text" id="apellidoM" name="apellidoM" value="${doctor?.apellidoM}" class="form-control"/>
                        </div>
                        <div class="form-group">
                            <label for="especialidad">Especialidad:</label>
                            <input type="text" id="especialidad" name="especialidad" value="${doctor?.especialidad}" class="form-control"/>
                        </div>
                        <div class="buttons">
                            <div type="submit" name="create" class="save" onclick="actualizarDoctor()">Actualizar</div>
                            <g:link class="cancelBotton" action="index">Cancelar</g:link>
                        </div>
                    </div>
                </div>
            </g:form>
        </div>
    </body>
</html>
