//
//  WorkSummaryEditorScene.swift
//  ResumeMaker
//
//  Created by Narender Kumar on 29/04/2022.
//


import UIKit

enum WorkSummaryEditorScene {
    static func create(
        delegate: WorkSummaryEditorViewControllerDelegate?,
        workSummary: WorkSummary
    ) -> UINavigationController {
        let viewModel = WorkSummaryEditorViewModel(workSummary: workSummary)
        let viewController = WorkSummaryEditorViewController(viewModel: viewModel)
        viewController.delegate = delegate
        let navigationController = UINavigationController(rootViewController: viewController)
        return navigationController
    }
}
