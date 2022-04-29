//
//  ResumeService.swift
//  ResumeMaker
//
//  Created by Narender Kumar on 29/04/2022.
//


import UIKit

protocol ResumeService {
    func get(id: String?) throws -> Resume?
    func save(resume: Resume) throws
    func delete(workSummary: WorkSummary) throws
    func delete(skill: Skill) throws
    func delete(educationDetail: EducationDetail) throws
    func delete(projectDetail: ProjectDetail) throws
}
