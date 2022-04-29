//
//  Skill.swift
//  ResumeMaker
//
//  Created by Narender Kumar on 29/04/2022.
//


import Foundation
import RealmSwift

struct Skill {
    var id: String = UUID().uuidString
    var text: String?
}

extension Skill {
    func toSkillEntity() -> SkillEntity {
        let entity = SkillEntity()
        entity.id = id
        entity.text = text
        return entity
    }
}

extension Array where Element == Skill {
    func toSkillEntityList() -> [SkillEntity] {
        return map { skill in skill.toSkillEntity() }
    }
}
