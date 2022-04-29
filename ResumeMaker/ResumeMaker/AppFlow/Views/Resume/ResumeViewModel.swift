//
//  ResumeViewModel.swift
//  ResumeMaker
//
//  Created by Narender Kumar on 29/04/2022.
//


import Combine

class ResumeViewModel {
    enum State {
        case idle
        case failed(AppError)
        case succeeded
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
        case skill
        case educationDetail
        case projectDetail
        
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
                self = .skill
            case 9:
                self = .educationDetail
            case 10:
                self = .projectDetail
            default:
                return nil
            }
        }
    }
    
    var hideCreateResumeButton: Bool {
        resume != nil
    }
    var hideTableView: Bool {
        resume == nil
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
            return resume?.residenceAddress == nil ? 0 : 1
        case .careerObjective:
            return resume?.careerObjective == nil ? 0 : 1
        case .totalYearsOfExperience:
            return resume?.totalYearsOfExperience == nil ? 0 : 1
        case .workSummary:
            return resume?.workSummaryList.count ?? 0
        case .skill:
            return resume?.skillList.count ?? 0
        case .educationDetail:
            return resume?.educationDetailList.count ?? 0
        case .projectDetail:
            return resume?.projectDetailList.count ?? 0
        }
    }
    
    func titleForHeader(in section: Int) -> String? {
        guard let section = Section(rawValue: section) else { return nil }
        switch section {
        case .profileImage:
            return nil
        case .name:
            return "Name"
        case .mobileNumber:
            return "Mobile"
        case .emailAddress:
            return "Email Address"
        case .residenceAddress:
            return resume?.residenceAddress == nil ? nil : "Address"
        case .careerObjective:
            return resume?.careerObjective == nil ? nil : "Career Objective"
        case .totalYearsOfExperience:
            return resume?.totalYearsOfExperience == nil ? nil : "Total Years of Experience"
        case .workSummary:
            guard let resume = resume else { return nil }
            return resume.workSummaryList.isEmpty ? nil : "Work Summary"
        case .skill:
            guard let resume = resume else { return nil }
            return resume.skillList.isEmpty ? nil : "Skills"
        case .educationDetail:
            guard let resume = resume else { return nil }
            return resume.educationDetailList.isEmpty ? nil : "Education Details"
        case .projectDetail:
            guard let resume = resume else { return nil }
            return resume.projectDetailList.isEmpty ? nil : "Project Details"
        }
    }
    
    let title = "Resume Maker"
    let state = CurrentValueSubject<State, Never>(.idle)
    var cancellables: Set<AnyCancellable> = []
    
    private(set) var resume: Resume?
    
    private let resumeService: ResumeService
    
    init(resumeService: ResumeService) {
        self.resumeService = resumeService
    }
    
    func getResume(id: String?) {
        do {
            resume = try resumeService.get(id: id)
            state.send(.succeeded)
        } catch {
            state.send(.failed(error.toAppError()))
        }
    }
}
