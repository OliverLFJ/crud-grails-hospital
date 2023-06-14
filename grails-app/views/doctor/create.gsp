<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <title>Registrar Doctor></title>
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
    <h1 class="titulo">Registrar Doctor</h1>
        <div id="create-doctor" class="content scaffold-create" role="main">
            <g:form resource="${this.doctor}" method="POST">
                <div class="form">
                    <div class="form-group">
                        <label for="nombre">Nombre:</label>
                        <input autocomplete="off" type="text" id="nombre" name="nombre" value="${doctor?.nombre}" class="form-control"/>
                    </div>
                    <div class="form-group">
                        <label for="apellidoP">Apellido Paterno:</label>
                        <input autocomplete="off" type="text" id="apellidoP" name="apellidoP" value="${doctor?.apellidoP}" class="form-control"/>
                    </div>
                    <div class="form-group">
                        <label for="apellidoM">Apellido Materno:</label>
                        <input autocomplete="off" type="text" id="apellidoM" name="apellidoM" value="${doctor?.apellidoM}" class="form-control"/>
                    </div>
                    <div class="form-group">
                        <label for="especialidad">Especialidad:</label>
                        <input autocomplete="off" type="text" id="especialidad" name="especialidad" value="${doctor?.especialidad}" class="form-control"/>
                    </div>
                    <div class="buttons">
                        <div type="submit" name="create" class="save" onclick="crearDoctor()">Crear</div>
                        <g:link class="cancelBotton" action="index">Cancelar</g:link>
                    </div>
                </div>
            </g:form>
        </div>
    </div>
    </body>
</html>
