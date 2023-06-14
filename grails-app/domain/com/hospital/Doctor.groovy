package com.hospital

class Doctor {
    Long id
    static mapping = {
        id column: 'id', generator: 'identity'
    }
    String nombre
    String apellidoP
    String apellidoM
    String especialidad
    static constraints = {
        nombre blank: false
        apellidoP blank: false
        apellidoM blank: false
        especialidad nullable: false
    }
}
