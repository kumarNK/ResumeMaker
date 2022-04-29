//
//  WorkSummary.swift
//  ResumeMaker
//
//  Created by Narender Kumar on 29/04/2022.
//


import Foundation
import RealmSwift

struct WorkSummary {
    var id: String = UUID().uuidString
    var companyName: String?
    var duration: String?
}

extension WorkSummary {
    func toWorkSummaryEntity() -> WorkSummaryEntity {
        let entity = WorkSummaryEntity()
        entity.id = id
        entity.companyName = companyName
        entity.duration = duration
        return entity
    }
}

extension Array where Element == WorkSummary {
    func toWorkSummaryEntityList() -> [WorkSummaryEntity] {
        return map { workSummary in workSummary.toWorkSummaryEntity() }
    }
}
