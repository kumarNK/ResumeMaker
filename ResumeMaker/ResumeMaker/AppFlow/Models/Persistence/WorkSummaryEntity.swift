//
//  WorkSummaryEntity.swift
//  ResumeMaker
//
//  Created by Narender Kumar on 29/04/2022.
//


import RealmSwift

class WorkSummaryEntity: Object {
    @Persisted(primaryKey: true) var id: String
    @Persisted var companyName: String?
    @Persisted var duration: String?
}

extension WorkSummaryEntity {
    func toWorkSummary() -> WorkSummary {
        return WorkSummary(
            id: id,
            companyName: companyName,
            duration: duration
        )
    }
}

extension List where Element == WorkSummaryEntity {
    func toWorkSummaryList() -> [WorkSummary] {
        return map { entity in entity.toWorkSummary() }
    }
}
