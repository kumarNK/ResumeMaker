//
//  EducationDetailEditorViewModel.swift
//  ResumeMaker
//
//  Created by Narender Kumar on 29/04/2022.
//


import Combine

class EducationDetailEditorViewModel {
    enum State {
        case idle
        case updated
    }
    
    var enableDoneButton: Bool {
        educationDetail.class != nil ||
        educationDetail.passingYear != nil ||
        educationDetail.percentageOrCGPA != nil
    }
    
    let title = "Education Detail"
    let state = CurrentValueSubject<State, Never>(.idle)
    var cancellables: Set<AnyCancellable> = []
    
    private(set) var educationDetail: EducationDetail {
        didSet {
            state.send(.updated)
        }
    }
    
    init(educationDetail: EducationDetail) {
        self.educationDetail = educationDetail
    }
    
    func set(class: String?) {
        educationDetail.class = `class`
    }
    
    func set(passingYear: String?) {
        educationDetail.passingYear = passingYear
    }
    
    func set(percentageOrCGPA: String?) {
        educationDetail.percentageOrCGPA = percentageOrCGPA
    }
}
