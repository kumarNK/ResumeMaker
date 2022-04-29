//
//  ProjectDetailEditorScene.swift
//  ResumeMaker
//
//  Created by Narender Kumar on 29/04/2022.
//


import UIKit

enum ProjectDetailEditorScene {
    static func create(
        delegate: ProjectDetailEditorViewControllerDelegate?,
        projectDetail: ProjectDetail
    ) -> UINavigationController {
        let viewModel = ProjectDetailEditorViewModel(projectDetail: projectDetail)
        let viewController = ProjectDetailEditorViewController(viewModel: viewModel)
        viewController.delegate = delegate
        let navigationController = UINavigationController(rootViewController: viewController)
        return navigationController
    }
}
