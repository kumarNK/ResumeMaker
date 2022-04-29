//
//  ResumeScene.swift
//  ResumeMaker
//
//  Created by Narender Kumar on 29/04/2022.
//


import UIKit

enum AppCoodinatior {
    static func runAppFlow() -> UINavigationController {
        let resumeService = ResumeServiceImpl()
        let viewModel = ResumeViewModel(resumeService: resumeService)
        let router = RoutableCoordinator()
        let viewController = ResumeViewController(viewModel: viewModel, router: router)
        let navigationController = UINavigationController(rootViewController: viewController)
        return navigationController
    }
}
