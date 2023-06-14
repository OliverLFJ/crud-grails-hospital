<!doctype html>
<html lang="en" class="no-js">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <title>
    <g:layoutTitle default="Consultorio"/>
    </title>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <asset:stylesheet src="application.css"/>

    <g:layoutHead/>
</head>

<body>
<div class="container">
    <nav class="navbar" role="navigation">
        <div class="logo-container">
            <a class="home" href="${createLink(uri: '/')}">CONSULTORIO</a>
        </div>

        <div class="list-option">
            <ul>
                <li><g:link class="link-style" controller="cita" action="index" redirect="true">CITAS</g:link></li>
                <li><g:link class="link-style" controller="doctor" action="index" redirect="true">DOCTORES</g:link></li>
                <li><g:link class="link-style" controller="hospital" action="index" redirect="true">HOSPITALES</g:link></li>
            </ul>
        </div>
    </nav>

    <div class="main-container">
        <g:layoutBody/>
    </div>
</div>
<asset:javascript src="application.js"/>
<asset:javascript src="doctorScripts.js.js"/>
<asset:javascript src="hospitalScripts.js.js.js"/>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

</body>
</html>
