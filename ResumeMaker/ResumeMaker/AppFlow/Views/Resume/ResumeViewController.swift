//
//  ResumeViewController.swift
//  ResumeMaker
//
//  Created by Narender Kumar on 29/04/2022.
//


import UIKit

class ResumeViewController: UIViewController {
    private var exportPDFBarButtonItem: UIBarButtonItem!
    private var editBarButtonItem: UIBarButtonItem!
    private let createResumeButton = UIButton()
    private let tableView = UITableView()
    
    private let viewModel: ResumeViewModel
    private let router: RoutableCoordinator
    
    init(viewModel: ResumeViewModel, router: RoutableCoordinator) {
        self.viewModel = viewModel
        self.router = router
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
        viewModel.getResume(id: nil)
    }
    
    private func addHierarchy() {
        view.addSubview(createResumeButton)
        view.addSubview(tableView)
    }
    
    private func configureHierarchy() {
        configureView()
        configureExportPDFBarButtonItem()
        configureEditBarButtonItem()
        configureNavigationItem()
        configureCreateResumeButton()
        configureTableView()
    }
    
    private func layoutHierarchy() {
        layoutCreateResumeButton()
        layoutTableView()
    }
    
    private func configureView() {
        view.backgroundColor = .systemBackground
    }
    
    private func configureExportPDFBarButtonItem() {
        let exportPDFAction = UIAction { [weak self] action in
            guard let self = self else { return }
            guard let url = self.tableView.exportAsPDF(view: self.view, path: "Resume.pdf") else {
                self.showErrorAlert(error: .generic)
                return
            }
            let documentInteractionController = UIDocumentInteractionController(url: url)
            documentInteractionController.delegate = self
            documentInteractionController.presentPreview(animated: true)
        }

        exportPDFBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "doc.plaintext"),
            primaryAction: exportPDFAction
        )

    }
    
    private func configureEditBarButtonItem() {
        let editAction = UIAction { [weak self] action in
            guard let self = self else { return }
            guard let resume = self.viewModel.resume else { return }
            self.router.route(from: self, to: .resumeEditor(self, resume))
        }
        editBarButtonItem = UIBarButtonItem(
            systemItem: .edit,
            primaryAction: editAction
        )
    }
    
    private func configureNavigationItem() {
        navigationItem.title = viewModel.title
        navigationItem.backButtonDisplayMode = .minimal
    }
    
    private func configureCreateResumeButton() {
        var configuration = UIButton.Configuration.filled()
        configuration.title = "Make Resume!"
        configuration.buttonSize = .large
        createResumeButton.configuration = configuration
        createResumeButton.addTarget(self, action: #selector(makeResume(_:)), for: .touchUpInside)
    }
    
    @objc private func makeResume(_ button: UIButton) {
        router.route(from: self, to: .resumeEditor(self, Resume()))
    }
    
    private func layoutCreateResumeButton() {
        let inset: CGFloat = 20
        createResumeButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            createResumeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: inset),
            createResumeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -inset),
            createResumeButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func configureTableView() {
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(
            WorkSummaryCell.self,
            forCellReuseIdentifier: WorkSummaryCell.reuseIdentifier
        )
        tableView.register(
            TextCell.self,
            forCellReuseIdentifier: TextCell.reuseIdentifier
        )
        tableView.register(
            EducationDetailCell.self,
            forCellReuseIdentifier: EducationDetailCell.reuseIdentifier
        )
        tableView.register(
            ProjectDetailCell.self,
            forCellReuseIdentifier: ProjectDetailCell.reuseIdentifier
        )
    }
    
    private func layoutTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
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
    
    private func render(state: ResumeViewModel.State) {
        switch state {
        case .idle:
            createResumeButton.isHidden = true
            tableView.isHidden = true
        case let .failed(error):
            showErrorAlert(error: error)
        case .succeeded:
            if viewModel.resume != nil {
                navigationItem.leftBarButtonItem = exportPDFBarButtonItem
                navigationItem.rightBarButtonItem = editBarButtonItem
            }
            createResumeButton.isHidden = viewModel.hideCreateResumeButton
            tableView.isHidden = viewModel.hideTableView
            tableView.reloadData()
        }
    }
}

// MARK: - ResumeEditorViewControllerDelegate
extension ResumeViewController: ResumeEditorViewControllerDelegate {
    func done(
        _ viewController: ResumeEditorViewController,
        resume: Resume
    ) {
        viewModel.getResume(id: resume.id)
    }
}

// MARK: - UITableViewDataSource
extension ResumeViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections
    }
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return viewModel.numberOfRows(in: section)
    }
    
    func tableView(
        _ tableView: UITableView,
        titleForHeaderInSection section: Int
    ) -> String? {
        return viewModel.titleForHeader(in: section)
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        guard let section = ResumeViewModel.Section(rawValue: indexPath.section) else {
            return UITableViewCell()
        }
        switch section {
        case .profileImage:
            let cell = ProfileImageCell()
            cell.image = viewModel.resume?.profileImage
            return cell
        case .name:
            let cell = TextCell()
            cell.text = viewModel.resume?.name
            return cell
        case .mobileNumber:
            let cell = TextCell()
            cell.text = viewModel.resume?.mobileNumber
            return cell
        case .emailAddress:
            let cell = TextCell()
            cell.text = viewModel.resume?.emailAddress
            return cell
        case .residenceAddress:
            let cell = TextCell()
            cell.text = viewModel.resume?.residenceAddress
            return cell
        case .careerObjective:
            let cell = TextCell()
            cell.text = viewModel.resume?.careerObjective
            return cell
        case .totalYearsOfExperience:
            let cell = TextCell()
            cell.text = viewModel.resume?.totalYearsOfExperience
            return cell
        case .workSummary:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: WorkSummaryCell.reuseIdentifier,
                for: indexPath
            ) as! WorkSummaryCell
            cell.workSummary = viewModel.resume?.workSummaryList[indexPath.row]
            return cell
        case .skill:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: TextCell.reuseIdentifier,
                for: indexPath
            ) as! TextCell
            let skill = viewModel.resume?.skillList[indexPath.row]
            cell.text = skill?.text
            return cell
        case .educationDetail:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: EducationDetailCell.reuseIdentifier,
                for: indexPath
            ) as! EducationDetailCell
            cell.educationDetail = viewModel.resume?.educationDetailList[indexPath.row]
            return cell
        case .projectDetail:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: ProjectDetailCell.reuseIdentifier,
                for: indexPath
            ) as! ProjectDetailCell
            cell.projectDetail = viewModel.resume?.projectDetailList[indexPath.row]
            return cell
        }
    }
}

// MARK: - UIDocumentInteractionControllerDelegate
extension ResumeViewController: UIDocumentInteractionControllerDelegate {
    func documentInteractionControllerViewControllerForPreview(
        _ controller: UIDocumentInteractionController
    ) -> UIViewController {
       return self
    }
}
