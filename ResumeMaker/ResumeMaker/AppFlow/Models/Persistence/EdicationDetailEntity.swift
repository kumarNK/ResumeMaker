//
//  EdicationDetailEntity.swift
//  ResumeMaker
//
//  Created by Narender Kumar on 29/04/2022.
//


import RealmSwift

class EducationDetailEntity: Object {
    @Persisted(primaryKey: true) var id: String
    @Persisted var `class`: String?
    @Persisted var passingYear: String?
    @Persisted var percentageOrCGPA: String?
}

extension EducationDetailEntity {
    func toEducationDetail() -> EducationDetail {
        return EducationDetail(
            id: id,
            class: `class`,
            passingYear: passingYear,
            percentageOrCGPA: percentageOrCGPA
        )
    }
}

extension List where Element == EducationDetailEntity {
    func toEducationDetailList() -> [EducationDetail] {
        return map { entity in entity.toEducationDetail() }
    }
}
