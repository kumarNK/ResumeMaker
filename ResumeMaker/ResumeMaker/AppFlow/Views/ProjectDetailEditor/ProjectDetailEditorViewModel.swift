//
//  ProjectDetailEditorViewModel.swift
//  ResumeMaker
//
//  Created by Narender Kumar on 29/04/2022.
//


import Combine

class ProjectDetailEditorViewModel {
    enum State {
        case idle
        case updated
    }
    
    var enableDoneButton: Bool {
        projectDetail.projectName != nil ||
        projectDetail.teamSize != nil ||
        projectDetail.projectSummary != nil ||
        projectDetail.technologyUsed != nil ||
        projectDetail.role != nil
    }
    
    let title = "Project Detail"
    let state = CurrentValueSubject<State, Never>(.idle)
    var cancellables: Set<AnyCancellable> = []
    
    private(set) var projectDetail: ProjectDetail {
        didSet {
            state.send(.updated)
        }
    }
    
    init(projectDetail: ProjectDetail) {
        self.projectDetail = projectDetail
    }
    
    func set(projectName: String?) {
        projectDetail.projectName = projectName
    }
    
    func set(teamSize: String?) {
        projectDetail.teamSize = teamSize
    }
    
    func set(projectSummary: String?) {
        projectDetail.projectSummary = projectSummary
    }
    
    func set(technologyUsed: String?) {
        projectDetail.technologyUsed = technologyUsed
    }
    
    func set(role: String?) {
        projectDetail.role = role
    }
}
