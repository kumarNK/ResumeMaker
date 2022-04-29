//
//  EducationDetailEditorScene.swift
//  ResumeMaker
//
//  Created by Narender Kumar on 29/04/2022.
//


import UIKit

enum EducationDetailEditorScene {
    static func create(
        delegate: EducationDetailEditorViewControllerDelegate?,
        educationDetail: EducationDetail
    ) -> UINavigationController {
        let viewModel = EducationDetailEditorViewModel(educationDetail: educationDetail)
        let viewController = EducationDetailEditorViewController(viewModel: viewModel)
        viewController.delegate = delegate
        let navigationController = UINavigationController(rootViewController: viewController)
        return navigationController
    }
}
