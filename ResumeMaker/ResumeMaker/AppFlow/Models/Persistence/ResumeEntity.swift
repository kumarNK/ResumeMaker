//
//  ResumeEntity.swift
//  ResumeMaker
//
//  Created by Narender Kumar on 29/04/2022.
//


import RealmSwift
import UIKit

class ResumeEntity: Object {
    @Persisted(primaryKey: true) var id: String
    @Persisted var name: String?
    @Persisted var mobileNumber: String?
    @Persisted var emailAddress: String?
    @Persisted var residenceAddress: String?
    @Persisted var careerObjective: String?
    @Persisted var totalYearsOfExperience: String?
    @Persisted var workSummaryList: List<WorkSummaryEntity>
    @Persisted var skillList: List<SkillEntity>
    @Persisted var educationDetailList: List<EducationDetailEntity>
    @Persisted var projectDetailList: List<ProjectDetailEntity>
}

extension ResumeEntity {
    func toResume(profileImage: UIImage?) -> Resume {
        return Resume(
            id: id,
            profileImage: profileImage,
            name: name,
            mobileNumber: mobileNumber,
            emailAddress: emailAddress,
            residenceAddress: residenceAddress,
            careerObjective: careerObjective,
            totalYearsOfExperience: totalYearsOfExperience,
            workSummaryList: workSummaryList.toWorkSummaryList(),
            skillList: skillList.toSkillList(),
            educationDetailList: educationDetailList.toEducationDetailList(),
            projectDetailList: projectDetailList.toProjectDetailList()
        )
    }
}
