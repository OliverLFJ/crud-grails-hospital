<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <title>Registrar Hospital</title>
    </head>
    <body>
    <div id="content" role="main">
        <div class="pop-up-hospital-create" id="popCreateHospital">
            <div id="contenedor-load-hospital-create">
                <div class="contenedor-load-hospital">
                    <div class="contenedor-loader-hospital">
                        <div class="rueda-hospital"></div>
                    </div>
                </div>
            </div>
        </div>
        <div class="confirmation-create-hospital" id="confirmation-hospital-create" data-visibilidad="oculto">
            <div class="text-confirmation" >
                <p>Hospital Registrado Correctamente</p>
            </div>
        </div>
        <h1 class="titulo">Registrar Hospital</h1>
        <div id="create-hospital" role="main">
            <g:form resource="${this.hospital}" method="POST">
                <div class="form">
                    <div class="form-group">
                        <label for="nombre">Nombre:</label>
                        <input autocomplete="off" required type="text" id="nombre" name="nombre" value="${hospital?.nombre}" class="form-control"/>
                    </div>
                    <div class="form-group">
                        <label for="direccion">Dirección:</label>
                        <input autocomplete="off" required type="text" id="direccion" name="direccion" value="${hospital?.direccion}" class="form-control"/>
                    </div>
                    <div class="form-group">
                        <label for="pisos">Pisos:</label>
                        <input autocomplete="off" required type="number" id="pisos" name="pisos" value="${hospital?.pisos}" class="form-control"/>
                    </div>
                    <div class="buttons">
                        <div type="submit" name="create" class="save" onclick="crearHospital()">Crear</div>
                        <g:link class="cancelBotton" action="index">Cancelar</g:link>
                    </div>
                </div>
            </g:form>
        </div>
    </div>
    </body>
</html>
