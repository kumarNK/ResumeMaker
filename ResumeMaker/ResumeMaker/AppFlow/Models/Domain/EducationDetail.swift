//
//  EducationDetail.swift
//  ResumeMaker
//
//  Created by Narender Kumar on 29/04/2022.
//


import Foundation
import RealmSwift

struct EducationDetail {
    var id: String = UUID().uuidString
    var `class`: String?
    var passingYear: String?
    var percentageOrCGPA: String?
}

extension EducationDetail {
    func toEducationDetailEntity() -> EducationDetailEntity {
        let entity = EducationDetailEntity()
        entity.id = id
        entity.class = `class`
        entity.passingYear = passingYear
        entity.percentageOrCGPA = percentageOrCGPA
        return entity
    }
}

extension Array where Element == EducationDetail {
    func toEducationDetailEntityList() -> [EducationDetailEntity] {
        return map { educationDetail in educationDetail.toEducationDetailEntity() }
    }
}
