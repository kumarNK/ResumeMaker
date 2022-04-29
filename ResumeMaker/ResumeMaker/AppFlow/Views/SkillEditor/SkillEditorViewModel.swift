//
//  SkillEditorViewModel.swift
//  ResumeMaker
//
//  Created by Narender Kumar on 29/04/2022.
//


import Combine

class SkillEditorViewModel {
    enum State {
        case idle
        case updated
    }
    
    var enableDoneButton: Bool {
        skill.text != nil
    }
    
    let title = "Skill"
    let state = CurrentValueSubject<State, Never>(.idle)
    var cancellables: Set<AnyCancellable> = []
    
    private(set) var skill: Skill {
        didSet {
            state.send(.updated)
        }
    }
    
    init(skill: Skill) {
        self.skill = skill
    }
    
    func set(text: String?) {
        self.skill.text = text
    }
}
