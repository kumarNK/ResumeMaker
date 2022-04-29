//
//  ResumeEditorScene.swift
//  ResumeMaker
//
//  Created by Narender Kumar on 29/04/2022.
//


import UIKit

enum ResumeEditorScene {
    static func create(
        delegate: ResumeEditorViewControllerDelegate?,
        resume: Resume
    ) -> UINavigationController {
        let resumeService = ResumeServiceImpl()
        let viewModel = ResumeEditorViewModel(resume: resume, resumeService: resumeService)
        let router = RoutableCoordinator()
        let viewController = ResumeEditorViewController(viewModel: viewModel, router: router)
        viewController.delegate = delegate
        let navigationController = UINavigationController(rootViewController: viewController)
        return navigationController
    }
}
