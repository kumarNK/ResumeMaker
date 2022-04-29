//
//  ProjectDetailEntity.swift
//  ResumeMaker
//
//  Created by Narender Kumar on 29/04/2022.
//


import RealmSwift

class ProjectDetailEntity: Object {
    @Persisted(primaryKey: true) var id: String
    @Persisted var projectName: String?
    @Persisted var teamSize: String?
    @Persisted var projectSummary: String?
    @Persisted var technologyUsed: String?
    @Persisted var role: String?
}

extension ProjectDetailEntity {
    func toProjectDetail() -> ProjectDetail {
        return ProjectDetail(
            id: id,
            projectName: projectName,
            teamSize: teamSize,
            projectSummary: projectSummary,
            technologyUsed: technologyUsed,
            role: role
        )
    }
}

extension List where Element == ProjectDetailEntity {
    func toProjectDetailList() -> [ProjectDetail] {
        return map { entity in entity.toProjectDetail() }
    }
}
