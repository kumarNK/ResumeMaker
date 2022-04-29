//
//  EducationDetailEditorViewController.swift
//  ResumeMaker
//
//  Created by Narender Kumar on 29/04/2022.
//


import UIKit

protocol EducationDetailEditorViewControllerDelegate: AnyObject {
    func done(
        _ viewController: EducationDetailEditorViewController,
        educationDetail: EducationDetail
    )
}

class EducationDetailEditorViewController: UIViewController {
    private var cancelBarButtonItem: UIBarButtonItem!
    private var doneBarButtonItem: UIBarButtonItem!
    private let tableView = UITableView()
    
    weak var delegate: EducationDetailEditorViewControllerDelegate?
    
    private let viewModel: EducationDetailEditorViewModel
    
    init(viewModel: EducationDetailEditorViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addHierarchy()
        configureHierarchy()
        layoutHierarchy()
        bind()
    }
    
    private func addHierarchy() {
        view.addSubview(tableView)
    }
    
    private func configureHierarchy() {
        configureView()
        configureCancelBarButtonItem()
        configureDoneBarButtonItem()
        configureNavigationItem()
        configureTableView()
    }
    
    private func layoutHierarchy() {
        layoutTableView()
    }
    
    private func configureView() {
        view.backgroundColor = .systemBackground
    }
    
    private func configureCancelBarButtonItem() {
        let cancelAction = UIAction { [weak self] action in
            self?.dismiss(animated: true)
        }
        cancelBarButtonItem = UIBarButtonItem(
            systemItem: .cancel,
            primaryAction: cancelAction
        )
    }
    
    private func configureDoneBarButtonItem() {
        let doneAction = UIAction { [weak self] action in
            guard let self = self else { return }
            self.delegate?.done(self, educationDetail: self.viewModel.educationDetail)
            self.dismiss(animated: true)
        }
        doneBarButtonItem = UIBarButtonItem(
            systemItem: .done,
            primaryAction: doneAction
        )
    }
    
    private func configureNavigationItem() {
        navigationItem.title = viewModel.title
        navigationItem.leftBarButtonItem = cancelBarButtonItem
        navigationItem.rightBarButtonItem = doneBarButtonItem
    }
    
    private func configureTableView() {
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.keyboardDismissMode = .interactive
        tableView.keyboardLayoutGuide.followsUndockedKeyboard = true
    }
    
    private func layoutTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.keyboardLayoutGuide.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func bind() {
        viewModel.state
            .sink { [weak self] state in
                self?.render(state: state)
            }
            .store(in: &viewModel.cancellables)
    }
    
    private func render(state: EducationDetailEditorViewModel.State) {
        switch state {
        case .idle:
            doneBarButtonItem.isEnabled = viewModel.enableDoneButton
        case .updated:
            doneBarButtonItem.isEnabled = viewModel.enableDoneButton
        }
    }
}

// MARK: - UITableViewDataSource
extension EducationDetailEditorViewController: UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return 1
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = EducationDetailEditorCell()
        cell.delegate = self
        cell.educationDetail = viewModel.educationDetail
        return cell
    }
}

// MARK: - EducationDetailEditorCellDelegate
extension EducationDetailEditorViewController: EducationDetailEditorCellDelegate {
    func didChangeClass(
        _ tableViewCell: EducationDetailEditorCell,
        class: String?
    ) {
        viewModel.set(class: `class`)
    }
    
    func didChangePassingYear(
        _ tableViewCell: EducationDetailEditorCell,
        passingYear: String?
    ) {
        viewModel.set(passingYear: passingYear)
    }
    
    func didChangePercentageOrCGPA(
        _ tableViewCell: EducationDetailEditorCell,
        percentageOrCGPA: String?
    ) {
        viewModel.set(percentageOrCGPA: percentageOrCGPA)
    }
}
