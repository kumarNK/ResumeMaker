//
//  SkillEntity.swift
//  ResumeMaker
//
//  Created by Narender Kumar on 29/04/2022.
//


import RealmSwift

class SkillEntity: Object {
    @Persisted(primaryKey: true) var id: String
    @Persisted var text: String?
}

extension SkillEntity {
    func toSkill() -> Skill {
        return Skill(
            id: id,
            text: text
        )
    }
}

extension List where Element == SkillEntity {
    func toSkillList() -> [Skill] {
        return map { entity in entity.toSkill() }
    }
}

