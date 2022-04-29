//
//  ResumeServiceImpl.swift
//  ResumeMaker
//
//  Created by Narender Kumar on 29/04/2022.
//


import UIKit

class ResumeServiceImpl: ResumeService {
    private let profileImagePath = "profile.png"
    
    func get(id: String?) throws -> Resume? {
        let profileImage = PersistenceController.shared.get(path: profileImagePath)
        if let id = id {
            let entity = try PersistenceController.shared.get(ofType: ResumeEntity.self, forPrimaryKey: id)
            return entity?.toResume(profileImage: profileImage)
        } else {
            let entity = try PersistenceController.shared.get(ofType: ResumeEntity.self)
            return entity?.toResume(profileImage: profileImage)
        }
    }
    
    func save(resume: Resume) throws {
        let entity = resume.toResumeEntity()
        if let image = resume.profileImage {
            try PersistenceController.shared.add(image: image, path: profileImagePath)
        }
        try PersistenceController.shared.add(entity: entity)
    }
    
    func delete(workSummary: WorkSummary) throws {
        let key = workSummary.id
        guard let entity = try? PersistenceController.shared.get(
            ofType: WorkSummaryEntity.self,
            forPrimaryKey: key
        ) else { return }
        try PersistenceController.shared.delete(entity: entity)
    }
    
    func delete(skill: Skill) throws {
        let key = skill.id
        guard let entity = try? PersistenceController.shared.get(
            ofType: SkillEntity.self,
            forPrimaryKey: key
        ) else { return }
        try PersistenceController.shared.delete(entity: entity)
    }
    
    func delete(educationDetail: EducationDetail) throws {
        let key = educationDetail.id
        guard let entity = try? PersistenceController.shared.get(
            ofType: EducationDetailEntity.self,
            forPrimaryKey: key
        ) else { return }
        try PersistenceController.shared.delete(entity: entity)
    }
    
    func delete(projectDetail: ProjectDetail) throws {
        let key = projectDetail.id
        guard let entity = try? PersistenceController.shared.get(
            ofType: ProjectDetailEntity.self,
            forPrimaryKey: key
        ) else { return }
        try PersistenceController.shared.delete(entity: entity)
    }
}
