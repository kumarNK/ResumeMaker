//
//  ResumeEditorViewModel.swift
//  ResumeMaker
//
//  Created by Narender Kumar on 29/04/2022.
//


import Combine
import UIKit

class ResumeEditorViewModel {
    enum State {
        case idle
        case failed(AppError)
        case updated
        case done
    }
    
    enum Section: Int, CaseIterable {
        case profileImage
        case name
        case mobileNumber
        case emailAddress
        case residenceAddress
        case careerObjective
        case totalYearsOfExperience
        case workSummary
        case addWorkSummary
        case skill
        case addSkill
        case educationDetail
        case addEducationDetail
        case projectDetail
        case addProjectDetail
        
        init?(rawValue: Int) {
            switch rawValue {
            case 0:
                self = .profileImage
            case 1:
                self = .name
            case 2:
                self = .mobileNumber
            case 3:
                self = .emailAddress
            case 4:
                self = .residenceAddress
            case 5:
                self = .careerObjective
            case 6:
                self = .totalYearsOfExperience
            case 7:
                self = .workSummary
            case 8:
                self = .addWorkSummary
            case 9:
                self = .skill
            case 10:
                self = .addSkill
            case 11:
                self = .educationDetail
            case 12:
                self = .addEducationDetail
            case 13:
                self = .projectDetail
            case 14:
                self = .addProjectDetail
            default:
                return nil
            }
        }
    }
    
    var enableDoneButton: Bool {
        guard let name = resume.name else { return false }
        guard let mobileNumber = resume.mobileNumber else { return false }
        guard let emailAddress = resume.emailAddress else { return false }
        return !name.isEmpty && mobileNumber.isValidMobileNumber && emailAddress.isValidEmailAddress
    }
    
    var numberOfSections: Int {
        Section.allCases.count
    }
    
    func numberOfRows(in section: Int) -> Int {
        guard let section = Section(rawValue: section) else { return 0 }
        switch section {
        case .profileImage:
            return 1
        case .name:
            return 1
        case .mobileNumber:
            return 1
        case .emailAddress:
            return 1
        case .residenceAddress:
            return 1
        case .careerObjective:
            return 1
        case .totalYearsOfExperience:
            return 1
        case .workSummary:
            return resume.workSummaryList.count
        case .addWorkSummary:
            return 1
        case .skill:
            return resume.skillList.count
        case .addSkill:
            return 1
        case .educationDetail:
            return resume.educationDetailList.count
        case .addEducationDetail:
            return 1
        case .projectDetail:
            return resume.projectDetailList.count
        case .addProjectDetail:
            return 1
        }
    }
    
    func titleForHeader(in section: Int) -> String? {
        guard let section = Section(rawValue: section) else { return nil }
        switch section {
        case .profileImage:
            return nil
        case .name:
            return "Name *"
        case .mobileNumber:
            return "Mobile Number *"
        case .emailAddress:
            return "Email Address *"
        case .residenceAddress:
            return "Residence Address"
        case .careerObjective:
            return "Career Objective"
        case .totalYearsOfExperience:
            return "Total Years of Experience"
        case .workSummary:
            return "Work Summary"
        case .addWorkSummary:
            return nil
        case .skill:
            return "Skills"
        case .addSkill:
            return nil
        case .educationDetail:
            return "Education Details"
        case .addEducationDetail:
            return nil
        case .projectDetail:
            return "Project Details"
        case .addProjectDetail:
            return nil
        }
    }
    
    let title = "Resume"
    let state = CurrentValueSubject<State, Never>(.idle)
    var cancellables: Set<AnyCancellable> = []
    
    private(set) var resume: Resume {
        didSet {
            state.send(.updated)
        }
    }
    
    private let resumeService: ResumeService
    
    init(resume: Resume, resumeService: ResumeService) {
        self.resume = resume
        self.resumeService = resumeService
    }
    
    func done() {
        do {
            try resumeService.save(resume: resume)
            state.send(.done)
        } catch {
            state.send(.failed(error.toAppError()))
        }
    }
    
    func set(profileImage: UIImage?) {
        resume.profileImage = profileImage
    }
    
    func set(name: String?) {
        resume.name = name
    }
    
    func set(mobileNumber: String?) {
        resume.mobileNumber = mobileNumber
    }
    
    func set(emailAddress: String?) {
        resume.emailAddress = emailAddress
    }
    
    func set(residenceAddress: String?) {
        resume.residenceAddress = residenceAddress
    }
    
    func set(careerObjective: String?) {
        resume.careerObjective = careerObjective
    }
    
    func set(totalYearsOfExperience: String?) {
        resume.totalYearsOfExperience = totalYearsOfExperience
    }
    
    func set(workSummary: WorkSummary) {
        if let index = resume.workSummaryList.firstIndex(where: { $0.id == workSummary.id }) {
            resume.workSummaryList[index] = workSummary
        } else {
            resume.workSummaryList.append(workSummary)
        }
    }
    
    func delete(workSummary: WorkSummary) {
        guard let index = resume.workSummaryList.firstIndex(where: { $0.id == workSummary.id }) else {
            return
        }
        resume.workSummaryList.remove(at: index)
        do {
            try resumeService.delete(workSummary: workSummary)
        } catch {
            state.send(.failed(error.toAppError()))
        }
    }
    
    func set(skill: Skill) {
        if let index = resume.skillList.firstIndex(where: { $0.id == skill.id }) {
            resume.skillList[index] = skill
        } else {
            resume.skillList.append(skill)
        }
    }
    
    func delete(skill: Skill) {
        guard let index = resume.skillList.firstIndex(where: { $0.id == skill.id }) else {
            return
        }
        resume.skillList.remove(at: index)
        do {
            try resumeService.delete(skill: skill)
        } catch {
            state.send(.failed(error.toAppError()))
        }
    }
    
    func set(educationDetail: EducationDetail) {
        if let index = resume.educationDetailList.firstIndex(where: { $0.id == educationDetail.id }) {
            resume.educationDetailList[index] = educationDetail
        } else {
            resume.educationDetailList.append(educationDetail)
        }
    }
    
    func delete(educationDetail: EducationDetail) {
        guard let index = resume.educationDetailList.firstIndex(where: { $0.id == educationDetail.id }) else {
            return
        }
        resume.educationDetailList.remove(at: index)
        do {
            try resumeService.delete(educationDetail: educationDetail)
        } catch {
            state.send(.failed(error.toAppError()))
        }
    }
    
    func set(projectDetail: ProjectDetail) {
        if let index = resume.projectDetailList.firstIndex(where: { $0.id == projectDetail.id }) {
            resume.projectDetailList[index] = projectDetail
        } else {
            resume.projectDetailList.append(projectDetail)
        }
    }
    
    func delete(projectDetail: ProjectDetail) {
        guard let index = resume.projectDetailList.firstIndex(where: { $0.id == projectDetail.id }) else {
            return
        }
        resume.projectDetailList.remove(at: index)
        do {
            try resumeService.delete(projectDetail: projectDetail)
        } catch {
            state.send(.failed(error.toAppError()))
        }
    }
}
