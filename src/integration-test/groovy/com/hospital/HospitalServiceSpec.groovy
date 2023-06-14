package com.hospital

import grails.testing.mixin.integration.Integration
import grails.gorm.transactions.Rollback
import spock.lang.Specification
import org.hibernate.SessionFactory

@Integration
@Rollback
class HospitalServiceSpec extends Specification {

    HospitalService hospitalService
    SessionFactory sessionFactory

    private Long setupData() {
        // TODO: Populate valid domain instances and return a valid ID
        //new Hospital(...).save(flush: true, failOnError: true)
        //new Hospital(...).save(flush: true, failOnError: true)
        //Hospital hospital = new Hospital(...).save(flush: true, failOnError: true)
        //new Hospital(...).save(flush: true, failOnError: true)
        //new Hospital(...).save(flush: true, failOnError: true)
        assert false, "TODO: Provide a setupData() implementation for this generated test suite"
        //hospital.id
    }

    void "test get"() {
        setupData()

        expect:
        hospitalService.get(1) != null
    }

    void "test list"() {
        setupData()

        when:
        List<Hospital> hospitalList = hospitalService.list(max: 2, offset: 2)

        then:
        hospitalList.size() == 2
        assert false, "TODO: Verify the correct instances are returned"
    }

    void "test count"() {
        setupData()

        expect:
        hospitalService.count() == 5
    }

    void "test delete"() {
        Long hospitalId = setupData()

        expect:
        hospitalService.count() == 5

        when:
        hospitalService.delete(hospitalId)
        sessionFactory.currentSession.flush()

        then:
        hospitalService.count() == 4
    }

    void "test save"() {
        when:
        assert false, "TODO: Provide a valid instance to save"
        Hospital hospital = new Hospital()
        hospitalService.save(hospital)

        then:
        hospital.id != null
    }
}
