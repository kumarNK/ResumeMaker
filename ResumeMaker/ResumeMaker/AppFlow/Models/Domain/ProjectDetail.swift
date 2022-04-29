//
//  ProjectDetail.swift
//  ResumeMaker
//
//  Created by Narender Kumar on 29/04/2022.
//


import Foundation
import RealmSwift

struct ProjectDetail {
    var id: String = UUID().uuidString
    var projectName: String?
    var teamSize: String?
    var projectSummary: String?
    var technologyUsed: String?
    var role: String?
}

extension ProjectDetail {
    func toProjectDetailEntity() -> ProjectDetailEntity {
        let entity = ProjectDetailEntity()
        entity.id = id
        entity.projectName = projectName
        entity.teamSize = teamSize
        entity.projectSummary = projectSummary
        entity.technologyUsed = technologyUsed
        entity.role = role
        return entity
    }
}

extension Array where Element == ProjectDetail {
    func toProjectDetailEntityList() -> [ProjectDetailEntity] {
        return map { projectDetail in projectDetail.toProjectDetailEntity() }
    }
}
