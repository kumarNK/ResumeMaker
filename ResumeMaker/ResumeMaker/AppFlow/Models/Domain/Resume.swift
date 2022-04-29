//
//  Resume.swift
//  ResumeMaker
//
//  Created by Narender Kumar on 29/04/2022.
//


import Foundation
import UIKit

struct Resume {
    var id: String = UUID().uuidString
    var profileImage: UIImage?
    var name: String?
    var mobileNumber: String?
    var emailAddress: String?
    var residenceAddress: String?
    var careerObjective: String?
    var totalYearsOfExperience: String?
    var workSummaryList: [WorkSummary] = []
    var skillList: [Skill] = []
    var educationDetailList: [EducationDetail] = []
    var projectDetailList: [ProjectDetail] = []
}

extension Resume {
    func toResumeEntity() -> ResumeEntity {
        let entity = ResumeEntity()
        entity.id = id
        entity.name = name
        entity.mobileNumber = mobileNumber
        entity.emailAddress = emailAddress
        entity.residenceAddress = residenceAddress
        entity.careerObjective = careerObjective
        entity.totalYearsOfExperience = totalYearsOfExperience
        entity.workSummaryList.append(objectsIn: workSummaryList.toWorkSummaryEntityList())
        entity.skillList.append(objectsIn: skillList.toSkillEntityList())
        entity.educationDetailList.append(objectsIn: educationDetailList.toEducationDetailEntityList())
        entity.projectDetailList.append(objectsIn: projectDetailList.toProjectDetailEntityList())
        return entity
    }
}
