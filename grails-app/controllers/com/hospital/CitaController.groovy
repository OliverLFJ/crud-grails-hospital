package com.hospital

import grails.converters.JSON

import java.text.SimpleDateFormat
import java.time.LocalDate
import java.time.LocalTime
import java.time.format.DateTimeFormatter

class CitaController {

    CitaService citaService
    DoctorService doctorService
    HospitalService hospitalService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {

        params.max = Math.min(max ?: 10, 100)
        def citaList = citaService.list(params).sort { it.id }
        def citaCount = citaService.count()
        def doctorList = doctorService.listDoctor()
        def hospitalList = hospitalService.listHospital()


        def fecha = params.fecha?.trim()
        def hospital = params.hospital?.isNumber() ? params.hospital.toLong() : null
        def doctor = params.doctor?.isNumber() ? params.doctor.toLong() : null


        if (fecha || hospital || doctor) {
            citaList = citaList.findAll { cita ->
                def fechaMatch = fecha ? cita.fecha == fecha : true
                def hospitalMatch = hospital ? cita.hospital?.id == hospital : true
                def doctorMatch = doctor ? cita.doctor?.id == doctor : true
                fechaMatch && hospitalMatch && doctorMatch
            }.sort { it.id }
        }

        respond citaList, model: [citaCount: citaCount, doctorList: doctorList, hospitalList: hospitalList]

    }

    def show(Long id) {
        respond citaService.get(id)
    }

    def create() {
        def doctorList = doctorService.listDoctor()
        def hospitalList = hospitalService.listHospital()

        respond new Cita(params), model: [doctorList: doctorList, hospitalList: hospitalList]
    }

    def save(Cita cita) {
        def horaIni = LocalTime.parse(cita.hora, DateTimeFormatter.ofPattern("HH:mm"))
        def horaInicial = horaIni.format(DateTimeFormatter.ofPattern("hh:mm a"))
        def horaFin = LocalTime.parse(cita.horaFinal, DateTimeFormatter.ofPattern("HH:mm"))
        def horaFinal = horaFin.format(DateTimeFormatter.ofPattern("hh:mm a"))
        def citaEncontradaHospital = citaService.listCita().find { it.fecha == cita.fecha && it.hospital == cita.hospital && it.hora == horaInicial && it.horaFinal == horaFinal}
        def citaEncontradaDoctor = citaService.listCita().find { it.fecha == cita.fecha && it.doctor == cita.doctor && it.hora == horaInicial && it.horaFinal == horaFinal}
        def citaEncontradaCitaPaciente = citaService.listCita().findAll { it.fecha == cita.fecha && it.hospital == cita.hospital}
        def consultorioActual = citaService.listCita().find { it.hospital == cita.hospital && it.fecha == cita.fecha}
        def citaEncontradaCitaDoctorCitasAlDia = citaService.listCita().findAll { it.doctor == cita.doctor && it.fecha == cita.fecha }.size()
        def horaCita
        Cita newCita = new Cita()
        def horaValidarIniGet = LocalTime.parse(cita.hora, DateTimeFormatter.ofPattern("HH:mm"))
        def horaValidarStringGet = horaValidarIniGet.format(DateTimeFormatter.ofPattern("HH:mm"))
        def horaValidarFinGet = LocalTime.parse(cita.horaFinal, DateTimeFormatter.ofPattern("HH:mm"))
        def horaValidarFinStringGet = horaValidarFinGet.format(DateTimeFormatter.ofPattern("HH:mm"))
        if (citaEncontradaDoctor) {
            render ([status: 'error2', redirectUrl: '/cita/index'] as JSON)
        }else if(horaValidarStringGet >= horaValidarFinStringGet){
            render ([status: 'error4', redirectUrl: '/cita/index'] as JSON)
        }else if(!citaEncontradaHospital && citaEncontradaCitaPaciente){
            def horasConDosHorasExtras = citaEncontradaCitaPaciente.collect { citaHora ->
                def hora = LocalTime.parse(citaHora.horaFinal, DateTimeFormatter.ofPattern("hh:mm a"))
                def horaNueva = hora.plusHours(2)
                horaNueva.format(DateTimeFormatter.ofPattern("HH:mm")).split(" ")[0]
            }
            def citasHorasIniciales = citaEncontradaCitaPaciente.collect { citaHoraInicial ->
                def horaInicial1 = LocalTime.parse(citaHoraInicial.hora, DateTimeFormatter.ofPattern("hh:mm a"))
                horaInicial1.format(DateTimeFormatter.ofPattern("HH:mm")).split(" ")[0]
            }

            def horaValidar = LocalTime.parse(cita.hora, DateTimeFormatter.ofPattern("HH:mm"))
            def horaValidarString = horaValidar.format(DateTimeFormatter.ofPattern("HH:mm"))
            def horaValidarFin = LocalTime.parse(cita.horaFinal, DateTimeFormatter.ofPattern("HH:mm"))
            def horaValidarFinString = horaValidarFin.format(DateTimeFormatter.ofPattern("HH:mm"))
            println (citasHorasIniciales)
            if (horasConDosHorasExtras.any { it == horaValidarString} || citasHorasIniciales.any { it == horaValidarFinString}) {
                render ([status: 'error3', redirectUrl: '/cita/index'] as JSON)
            } else {
                def horaMinimaPermitida = horasConDosHorasExtras.max()
                def horaMinimaPermitidaa = LocalTime.parse(horaMinimaPermitida, DateTimeFormatter.ofPattern("HH:mm"))
                if (   horaValidar.isBefore(horaMinimaPermitidaa) ) {
                    render ([status: 'error3', redirectUrl: '/cita/index'] as JSON)
                } else {
                    newCita.fecha = cita.fecha
                    newCita.hora = horaInicial
                    newCita.horaFinal = horaFinal
                    newCita.paciente = cita.paciente
                    newCita.hospital = cita.hospital
                    newCita.doctor = cita.doctor
                    citaService.save(newCita)
                    render ([status: 'success', redirectUrl: '/cita/index'] as JSON)
                }
            }


        }else if(citaEncontradaCitaDoctorCitasAlDia==7){
            render ([status: 'error5', redirectUrl: '/cita/index'] as JSON)
        }else if (citaEncontradaHospital) {
            render ([status: 'error1', redirectUrl: '/cita/index'] as JSON)
        } else {
            newCita.fecha = cita.fecha
            newCita.hora = horaInicial
            newCita.horaFinal = horaFinal
            newCita.paciente = cita.paciente
            newCita.hospital = cita.hospital
            newCita.doctor = cita.doctor
            citaService.save(newCita)
            render ([status: 'success', redirectUrl: '/cita/index'] as JSON)
        }
    }

    def edit(Long id) {
        def doctorList = doctorService.listDoctor()
        def hospitalList = hospitalService.listHospital()
        respond citaService.get(id),model: [doctorList: doctorList, hospitalList: hospitalList]
    }

    def update(Long id, Cita cita) {
        def citaServiceXD = citaService.listCita()
        def citaEncontrada = citaServiceXD.find { citas -> citas.id == id }
        def horaIni = LocalTime.parse(cita.hora, DateTimeFormatter.ofPattern("HH:mm"))
        def horaInicial = horaIni.format(DateTimeFormatter.ofPattern("hh:mm a"))
        def horaFin = LocalTime.parse(cita.horaFinal, DateTimeFormatter.ofPattern("HH:mm"))
        def horaFinal = horaFin.format(DateTimeFormatter.ofPattern("hh:mm a"))
        def citaEncontradaHospital = citaService.listCita().find { it.fecha == cita.fecha && it.hospital == cita.hospital && it.hora == horaInicial && it.horaFinal == horaFinal}
        def citaEncontradaDoctor = citaService.listCita().find { it.fecha == cita.fecha && it.doctor == cita.doctor && it.hora == horaInicial && it.horaFinal == horaFinal}
        def citaEncontradaCitaPaciente = citaService.listCita().find { it.fecha == cita.fecha  && it.id != id}
        def citaEncontradaCitaDoctorCitasAlDia = citaService.listCita().findAll { it.doctor == cita.doctor && it.fecha == cita.fecha }.size()
        def consultorioActual = citaService.listCita().find { it.hospital == cita.hospital && it.fecha == cita.fecha}

        def horaValidarIniGet = LocalTime.parse(cita.hora, DateTimeFormatter.ofPattern("HH:mm"))
        def horaValidarStringGet = horaValidarIniGet.format(DateTimeFormatter.ofPattern("HH:mm"))
        def horaValidarFinGet = LocalTime.parse(cita.horaFinal, DateTimeFormatter.ofPattern("HH:mm"))
        def horaValidarFinStringGet = horaValidarFinGet.format(DateTimeFormatter.ofPattern("HH:mm"))


            if (citaEncontradaDoctor) {
                render ([status: 'error2', redirectUrl: '/cita/index'] as JSON)
            }else if(citaEncontradaCitaPaciente){
                def horasConDosHorasExtras = citaEncontradaCitaPaciente.collect { citaHora ->
                    def hora = LocalTime.parse(citaHora.horaFinal, DateTimeFormatter.ofPattern("hh:mm a"))
                    def horaNueva = hora.plusHours(2)
                    horaNueva.format(DateTimeFormatter.ofPattern("HH:mm")).split(" ")[0]
                }
                def citasHorasIniciales = citaEncontradaCitaPaciente.collect { citaHoraInicial ->
                    def horaInicial1 = LocalTime.parse(citaHoraInicial.hora, DateTimeFormatter.ofPattern("hh:mm a"))
                    horaInicial1.format(DateTimeFormatter.ofPattern("HH:mm")).split(" ")[0]
                }

                def horaValidar = LocalTime.parse(cita.hora, DateTimeFormatter.ofPattern("HH:mm"))
                def horaValidarString = horaValidar.format(DateTimeFormatter.ofPattern("HH:mm"))
                def horaValidarFin = LocalTime.parse(cita.horaFinal, DateTimeFormatter.ofPattern("HH:mm"))
                def horaValidarFinString = horaValidarFin.format(DateTimeFormatter.ofPattern("HH:mm"))
                println (citasHorasIniciales)
                if (horasConDosHorasExtras.any { it == horaValidarString} || citasHorasIniciales.any { it == horaValidarFinString}) {
                    render ([status: 'error3', redirectUrl: '/cita/index'] as JSON)
                } else {
                    def horaMinimaPermitida = horasConDosHorasExtras.max()
                    def horaMinimaPermitidaa = LocalTime.parse(horaMinimaPermitida, DateTimeFormatter.ofPattern("HH:mm"))
                    if (   horaValidar.isBefore(horaMinimaPermitidaa) ) {
                        render ([status: 'error3', redirectUrl: '/cita/index'] as JSON)
                    } else {
                        citaEncontrada.paciente = cita.paciente;
                        citaEncontrada.fecha = cita.fecha;
                        citaEncontrada.hora = horaInicial
                        citaEncontrada.horaFinal = horaFinal
                        citaEncontrada.doctor = cita.doctor;
                        citaEncontrada.hospital = cita.hospital;
                        citaService.save(citaEncontrada)
                        render ([status: 'success', redirectUrl: '/cita/index'] as JSON)
                    }
                }
                }else if(citaEncontradaCitaDoctorCitasAlDia==7){
                    render ([status: 'error5', redirectUrl: '/cita/index'] as JSON)
                    }else if(horaValidarStringGet >= horaValidarFinStringGet){
                        render ([status: 'error4', redirectUrl: '/cita/index'] as JSON)
                    }else if (citaEncontradaHospital) {
                        render ([status: 'error1', redirectUrl: '/cita/index'] as JSON)
                    } else {
                        citaEncontrada.paciente = cita.paciente;
                        citaEncontrada.fecha = cita.fecha;
                        citaEncontrada.hora = horaInicial
                        citaEncontrada.horaFinal = horaFinal
                        citaEncontrada.doctor = cita.doctor;
                        citaEncontrada.hospital = cita.hospital;
                        citaService.save(citaEncontrada)
                        render ([status: 'success', redirectUrl: '/cita/index'] as JSON)
                    }
    }

    def delete(Long id) {
        LocalDate fechaActual = LocalDate.now()
        DateTimeFormatter formatoActual = DateTimeFormatter.ofPattern("dd/MM/yyyy")
        String fechaActualFormateada = fechaActual.format(formatoActual)
        Cita fechaDesdeCita = citaService.listCita().find { it.id == id}
        String fechaObtenida = fechaDesdeCita.fecha
        DateTimeFormatter formatoCita = DateTimeFormatter.ofPattern("yyyy-MM-dd")
        LocalDate fechaCita = LocalDate.parse(fechaObtenida, formatoCita)
        LocalDate fechaActualFormateadaParsed = LocalDate.parse(fechaActualFormateada, formatoActual)
        if (fechaActualFormateadaParsed.isAfter(fechaCita)) {
            citaService.delete(id)
            render ([status: 'success', redirectUrl: '/cita/index'] as JSON)
        } else if (fechaActualFormateadaParsed.isBefore(fechaCita)) {
            citaService.delete(id)
            render ([status: 'success', redirectUrl: '/cita/index'] as JSON)
        } else {
            render ([status: 'errorFecha', redirectUrl: '/cita/index'] as JSON)
        }
    }
}
