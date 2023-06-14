package com.hospital

import grails.gorm.services.Service

@Service(Doctor)
interface DoctorService {

    Doctor get(Serializable id)

    List<Doctor> list(Map args)

    List<Doctor> listDoctor()

    Long count()

    void delete(Serializable id)

    Doctor save(Doctor doctor)

}