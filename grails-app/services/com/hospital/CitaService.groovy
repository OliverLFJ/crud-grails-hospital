package com.hospital

import grails.gorm.services.Service

@Service(Cita)
interface CitaService {

    Cita get(Serializable id)

    List<Cita> list(Map args)

    List<Cita> listCita()

    Long count()

    void delete(Serializable id)

    Cita save(Cita cita)

}