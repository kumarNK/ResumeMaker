//
//  RoutableCoordinator.swift
//  ResumeMaker
//
//  Created by Narender Kumar on 29/04/22.
//

import UIKit

class RoutableCoordinator {
    enum Destination {
        case resumeEditor(ResumeEditorViewControllerDelegate?, Resume)
        case imagePicker((UIImagePickerControllerDelegate & UINavigationControllerDelegate)?)
        case workSummaryEditor(WorkSummaryEditorViewControllerDelegate?, WorkSummary)
        case skillEditor(SkillEditorViewControllerDelegate?, Skill)
        case educationDetailEditor(EducationDetailEditorViewControllerDelegate?, EducationDetail)
        case projectDetailEditor(ProjectDetailEditorViewControllerDelegate?, ProjectDetail)
        case confirmationAlert(String, UIAlertAction)
    }

    func route(
        from sourceViewController: UIViewController,
        to destination: Destination
    ) {
        switch destination {
        case let .resumeEditor(delegate, resume):
            let destinationViewController = ResumeEditorScene.create(
                delegate: delegate,
                resume: resume
            )
            destinationViewController.modalPresentationStyle = .fullScreen
            sourceViewController.present(destinationViewController, animated: true)
        case let .imagePicker(delegate):
            let destinationViewController = UIImagePickerController()
            destinationViewController.delegate = delegate
            destinationViewController.sourceType = .photoLibrary
            destinationViewController.allowsEditing = true
            destinationViewController.modalPresentationStyle = .fullScreen
            sourceViewController.present(destinationViewController, animated: true)
        case let .workSummaryEditor(delegate, workSummary):
            let destinationViewController = WorkSummaryEditorScene.create(
                delegate: delegate,
                workSummary: workSummary
            )
            destinationViewController.modalPresentationStyle = .fullScreen
            sourceViewController.present(destinationViewController, animated: true)
        case let .skillEditor(delegate, skill):
            let destinationViewController = SkillEditorScene.create(
                delegate: delegate,
                skill: skill
            )
            destinationViewController.modalPresentationStyle = .fullScreen
            sourceViewController.present(destinationViewController, animated: true)
        case let .educationDetailEditor(delegate, educationDetail):
            let destinationViewController = EducationDetailEditorScene.create(
                delegate: delegate,
                educationDetail: educationDetail
            )
            destinationViewController.modalPresentationStyle = .fullScreen
            sourceViewController.present(destinationViewController, animated: true)
        case let .projectDetailEditor(delegate, projectDetail):
            let destinationViewController = ProjectDetailEditorScene.create(
                delegate: delegate,
                projectDetail: projectDetail
            )
            destinationViewController.modalPresentationStyle = .fullScreen
            sourceViewController.present(destinationViewController, animated: true)
        case let .confirmationAlert(item, action):
            let message = "This \(item.lowercased()) will be deleted. This action cannot be undone."
            let destinationViewController = UIAlertController(
                title: nil,
                message: message,
                preferredStyle: .actionSheet
            )
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
            destinationViewController.addAction(action)
            destinationViewController.addAction(cancelAction)
            sourceViewController.present(destinationViewController, animated: true)
        }
    }
}

