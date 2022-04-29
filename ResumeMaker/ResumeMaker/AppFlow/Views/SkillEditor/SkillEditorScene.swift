//
//  SkillEditorScene.swift
//  ResumeMaker
//
//  Created by Narender Kumar on 29/04/2022.
//


import UIKit

enum SkillEditorScene {
    static func create(
        delegate: SkillEditorViewControllerDelegate?,
        skill: Skill
    ) -> UINavigationController {
        let viewModel = SkillEditorViewModel(skill: skill)
        let viewController = SkillEditorViewController(viewModel: viewModel)
        viewController.delegate = delegate
        let navigationController = UINavigationController(rootViewController: viewController)
        return navigationController
    }
}
