<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <title>Actualizar Doctor</title>
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
            <div class="text-confirmation">
                <p>Hospital Actualizado Correctamente</p>
            </div>
        </div>
    <h1 class="titulo">Actualizar Hospital</h1>
        <div id="edit-hospital" class="content scaffold-edit" role="main">
            <g:form resource="${this.hospital}" method="PUT">
                <input type="hidden" id="version" name="version" value="${this.hospital?.id}" />
                <div class="form">
                    <div class="form-group">
                        <label for="nombre">Nombre:</label>
                        <input type="text" id="nombre" name="nombre" value="${hospital?.nombre}" class="form-control"/>
                    </div>
                    <div class="form-group">
                        <label for="direccion">Dirección:</label>
                        <input type="text" id="direccion" name="direccion" value="${hospital?.direccion}" class="form-control"/>
                    </div>
                    <div class="form-group">
                        <label for="pisos">Pisos:</label>
                        <input type="number" id="pisos" name="pisos" value="${hospital?.pisos}" class="form-control"/>
                    </div>
                    <div class="buttons">
                        <div type="submit" name="create" class="save" onclick="actualizarHospital()">Actualizar</div>
                        <g:link class="cancelBotton" action="index">Cancelar</g:link>
                    </div>
                </div>
            </g:form>
        </div>
    </div>
    </body>
</html>
