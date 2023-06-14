package com.hospital

import grails.converters.JSON
import grails.validation.ValidationException

class HospitalController {

    HospitalService hospitalService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        def hospitalList = hospitalService.list(params).sort { it.id }
        def hospitalCount = hospitalService.count()
        respond hospitalList, model: [hospitalCount: hospitalCount]
    }

    def show(Long id) {
        respond hospitalService.get(id)
    }

    def create() {
        respond new Hospital(params)
    }

    def save(Hospital hospital) {
        try {
            hospitalService.save(hospital)
        } catch (ValidationException e) {
            respond hospital.errors, view:'create'
            return
        }
        render ([status: 'success', redirectUrl: '/hospital/index'] as JSON)
    }

    def edit(Long id) {
        respond hospitalService.get(id)
    }

    def update(Long id,Hospital hospital) {
        def hospitalServiceXD = hospitalService.listHospital()
        def hospitalEncontrada = hospitalServiceXD.find { hospitales -> hospitales.id == id }
        if(hospitalEncontrada){
            hospitalEncontrada.nombre = hospital.nombre;
            hospitalEncontrada.direccion = hospital.direccion;
            hospitalEncontrada.pisos = hospital.pisos;
        }
        hospitalService.save(hospitalEncontrada)
        render ([status: 'success', redirectUrl: '/hospital/index'] as JSON)
    }

    def delete(Long id) {
        hospitalService.delete(id)
        render ([status: 'success', redirectUrl: '/hospital/index'] as JSON)
    }
}
