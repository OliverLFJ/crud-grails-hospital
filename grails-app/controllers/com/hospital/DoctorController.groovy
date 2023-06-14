package com.hospital

import grails.converters.JSON
import grails.validation.ValidationException

class DoctorController {

    DoctorService doctorService
    HospitalService hospitalService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        def doctorList = doctorService.list(params).sort { it.id }
        def doctorCount = doctorService.count()
        respond doctorList, model: [doctorCount: doctorCount]
    }

    def show(Long id) {
        respond doctorService.get(id)
    }

    def create() {
        def hospitalList = hospitalService.listHospital()
        respond new Doctor(params), model: [hospitalList:hospitalList]
    }

    def save(Doctor doctor) {
        try {
            doctorService.save(doctor)
        } catch (ValidationException e) {
            respond doctor.errors, view:'create'
            return
        }
        render ([status: 'success', redirectUrl: '/doctor/index'] as JSON)
    }

    def edit(Long id) {
        def hospitalList = hospitalService.listHospital()
        respond doctorService.get(id), model: [hospitalList:hospitalList]
    }

    def update(Long id,Doctor doctor) {
        def doctorServiceXD = doctorService.listDoctor()
        def doctorEncontrada = doctorServiceXD.find { doctores -> doctores.id == id }
        if(doctorEncontrada){
            doctorEncontrada.nombre = doctor.nombre;
            doctorEncontrada.apellidoP = doctor.apellidoP;
            doctorEncontrada.apellidoM = doctor.apellidoM;
            doctorEncontrada.especialidad = doctor.especialidad;
        }

        doctorService.save(doctorEncontrada)
        render ([status: 'success', redirectUrl: '/doctor/index'] as JSON)
    }

    def delete(Long id) {
        doctorService.delete(id)
        render ([status: 'success', redirectUrl: '/doctor/index'] as JSON)
    }
}
