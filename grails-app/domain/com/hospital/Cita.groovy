package com.hospital


class Cita {
    Long id
    static mapping = {
        id column: 'id', generator: 'identity'
    }
    String fecha
    String hora
    String horaFinal
    String paciente
    Doctor doctor
    Hospital hospital
    static belongsTo = [doctor: Doctor, hospital: Hospital]
    static constraints = {
        fecha blank: false
        hora nullable: false
        horaFinal nullable: false
        paciente nullable: false
        doctor nullable: false
        hospital nullable: false
    }
}
