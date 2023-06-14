package com.hospital

class Hospital {
    Long id
    static mapping = {
        id column: 'id', generator: 'identity'
    }
    String nombre
    String direccion
    int pisos
    static constraints = {
        nombre blank: false
        direccion blank: false
        pisos blank: false
    }
}
