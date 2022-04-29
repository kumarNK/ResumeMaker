//
//  WorkSummaryEditorViewModel.swift
//  ResumeMaker
//
//  Created by Narender Kumar on 29/04/2022.
//


import Combine

class WorkSummaryEditorViewModel {
    enum State {
        case idle
        case updated
    }
    
    var enableDoneButton: Bool {
        workSummary.companyName != nil ||
        workSummary.duration != nil
    }
    
    let title = "Work Summary"
    let state = CurrentValueSubject<State, Never>(.idle)
    var cancellables: Set<AnyCancellable> = []
    
    private(set) var workSummary: WorkSummary {
        didSet {
            state.send(.updated)
        }
    }
    
    init(workSummary: WorkSummary) {
        self.workSummary = workSummary
    }
    
    func set(companyName: String?) {
        workSummary.companyName = companyName
    }
    
    func set(duration: String?) {
        workSummary.duration = duration
    }
}
