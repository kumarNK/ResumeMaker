//
//  ResumeEditorViewController.swift
//  ResumeMaker
//
//  Created by Narender Kumar on 29/04/2022.
//


import UIKit

protocol ResumeEditorViewControllerDelegate: AnyObject {
    func done(
        _ viewController: ResumeEditorViewController,
        resume: Resume
    )
}

class ResumeEditorViewController: UIViewController {
    private var cancelBarButtonItem: UIBarButtonItem!
    private var doneBarButtonItem: UIBarButtonItem!
    private let tableView = UITableView()
    
    weak var delegate: ResumeEditorViewControllerDelegate?
    
    private let viewModel: ResumeEditorViewModel
    private let router: RoutableCoordinator
    
    init(viewModel: ResumeEditorViewModel, router: RoutableCoordinator) {
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
            self?.viewModel.done()
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
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.keyboardDismissMode = .interactive
        tableView.keyboardLayoutGuide.followsUndockedKeyboard = true
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
    
    private func render(state: ResumeEditorViewModel.State) {
        switch state {
        case .idle:
            doneBarButtonItem.isEnabled = viewModel.enableDoneButton
        case let .failed(error):
            showErrorAlert(error: error)
        case .updated:
            doneBarButtonItem.isEnabled = viewModel.enableDoneButton
        case .done:
            delegate?.done(self, resume: viewModel.resume)
            dismiss(animated: true)
        }
    }
}

// MARK: - UITableViewDataSource
extension ResumeEditorViewController: UITableViewDataSource {
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
        guard let section = ResumeEditorViewModel.Section(rawValue: indexPath.section) else {
            return UITableViewCell()
        }
        switch section {
        case .profileImage:
            let cell = ProfileImageEditorCell()
            cell.delegate = self
            cell.image = viewModel.resume.profileImage
            return cell
        case .name:
            let cell = NameEditorCell()
            cell.delegate = self
            cell.name = viewModel.resume.name
            return cell
        case .mobileNumber:
            let cell = MobileNumberEditorCell()
            cell.delegate = self
            cell.mobileNumber = viewModel.resume.mobileNumber
            return cell
        case .emailAddress:
            let cell = EmailAddressEditorCell()
            cell.delegate = self
            cell.emailAddress = viewModel.resume.emailAddress
            return cell
        case .residenceAddress:
            let cell = ResidenceAddressEditorCell()
            cell.delegate = self
            cell.residenceAddress = viewModel.resume.residenceAddress
            return cell
        case .careerObjective:
            let cell = CareerObjectiveEditorCell()
            cell.delegate = self
            cell.careerObjective = viewModel.resume.careerObjective
            return cell
        case .totalYearsOfExperience:
            let cell = TotalYearsOfExperienceEditorCell()
            cell.delegate = self
            cell.totalYearsOfExperience = viewModel.resume.totalYearsOfExperience
            return cell
        case .workSummary:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: WorkSummaryCell.reuseIdentifier,
                for: indexPath
            ) as! WorkSummaryCell
            cell.workSummary = viewModel.resume.workSummaryList[indexPath.row]
            return cell
        case .addWorkSummary:
            let cell = ButtonCell()
            var configuration = UIButton.Configuration.filled()
            configuration.title = "Add Work Summary"
            configuration.buttonSize = .large
            cell.button.configuration = configuration
            cell.action = { [weak self] in
                guard let self = self else { return }
                self.router.route(from: self, to: .workSummaryEditor(self, WorkSummary()))
            }
            return cell
        case .skill:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: TextCell.reuseIdentifier,
                for: indexPath
            ) as! TextCell
            let skill = viewModel.resume.skillList[indexPath.row]
            cell.text = skill.text
            return cell
        case .addSkill:
            let cell = ButtonCell()
            var configuration = UIButton.Configuration.filled()
            configuration.title = "Add Skill"
            configuration.buttonSize = .large
            cell.button.configuration = configuration
            cell.action = { [weak self] in
                guard let self = self else { return }
                self.router.route(from: self, to: .skillEditor(self, Skill()))
            }
            return cell
        case .educationDetail:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: EducationDetailCell.reuseIdentifier,
                for: indexPath
            ) as! EducationDetailCell
            cell.educationDetail = viewModel.resume.educationDetailList[indexPath.row]
            return cell
        case .addEducationDetail:
            let cell = ButtonCell()
            var configuration = UIButton.Configuration.filled()
            configuration.title = "Add Education Detail"
            configuration.buttonSize = .large
            cell.button.configuration = configuration
            cell.action = { [weak self] in
                guard let self = self else { return }
                self.router.route(from: self, to: .educationDetailEditor(self, EducationDetail()))
            }
            return cell
        case .projectDetail:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: ProjectDetailCell.reuseIdentifier,
                for: indexPath
            ) as! ProjectDetailCell
            cell.projectDetail = viewModel.resume.projectDetailList[indexPath.row]
            return cell
        case .addProjectDetail:
            let cell = ButtonCell()
            var configuration = UIButton.Configuration.filled()
            configuration.title = "Add Project Detail"
            configuration.buttonSize = .large
            cell.button.configuration = configuration
            cell.action = { [weak self] in
                guard let self = self else { return }
                self.router.route(from: self, to: .projectDetailEditor(self, ProjectDetail()))
            }
            return cell
        }
    }
}

// MARK: - UITableViewDelegate
extension ResumeEditorViewController: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        guard let section = ResumeEditorViewModel.Section(rawValue: indexPath.section) else {
            return
        }
        switch section {
        case .profileImage:
            break
        case .name:
            break
        case .mobileNumber:
            break
        case .emailAddress:
            break
        case .residenceAddress:
            break
        case .careerObjective:
            break
        case .totalYearsOfExperience:
            break
        case .workSummary:
            let workSummary = viewModel.resume.workSummaryList[indexPath.row]
            router.route(from: self, to: .workSummaryEditor(self, workSummary))
        case .addWorkSummary:
            break
        case .skill:
            let skill = viewModel.resume.skillList[indexPath.row]
            router.route(from: self, to: .skillEditor(self, skill))
        case .addSkill:
            break
        case .educationDetail:
            let educationDetail = viewModel.resume.educationDetailList[indexPath.row]
            router.route(from: self, to: .educationDetailEditor(self, educationDetail))
        case .addEducationDetail:
            break
        case .projectDetail:
            let projectDetail = viewModel.resume.projectDetailList[indexPath.row]
            router.route(from: self, to: .projectDetailEditor(self, projectDetail))
        case .addProjectDetail:
            break
        }
    }
    
    func tableView(
        _ tableView: UITableView,
        commit editingStyle: UITableViewCell.EditingStyle,
        forRowAt indexPath: IndexPath
    ) {
        guard editingStyle == .delete else { return }
        guard let section = ResumeEditorViewModel.Section(rawValue: indexPath.section) else {
            return
        }
        switch section {
        case .profileImage:
            break
        case .name:
            break
        case .mobileNumber:
            break
        case .emailAddress:
            break
        case .residenceAddress:
            break
        case .careerObjective:
            break
        case .totalYearsOfExperience:
            break
        case .workSummary:
            let title = "Delete Work Summary"
            let deleteAction = UIAlertAction(title: title, style: .destructive) { [weak self] action in
                guard let self = self else { return }
                let workSummary = self.viewModel.resume.workSummaryList[indexPath.row]
                self.viewModel.delete(workSummary: workSummary)
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
            router.route(from: self, to: .confirmationAlert("Work Summary", deleteAction))
        case .addWorkSummary:
            break
        case .skill:
            let title = "Delete Skill"
            let deleteAction = UIAlertAction(title: title, style: .destructive) { [weak self] action in
                guard let self = self else { return }
                let skill = self.viewModel.resume.skillList[indexPath.row]
                self.viewModel.delete(skill: skill)
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
            router.route(from: self, to: .confirmationAlert("Skill", deleteAction))
        case .addSkill:
            break
        case .educationDetail:
            let title = "Delete Education Detail"
            let deleteAction = UIAlertAction(title: title, style: .destructive) { [weak self] action in
                guard let self = self else { return }
                let educationDetail = self.viewModel.resume.educationDetailList[indexPath.row]
                self.viewModel.delete(educationDetail: educationDetail)
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
            router.route(from: self, to: .confirmationAlert("Education Detail", deleteAction))
        case .addEducationDetail:
            break
        case .projectDetail:
            let title = "Delete Project Detail"
            let deleteAction = UIAlertAction(title: title, style: .destructive) { [weak self] action in
                guard let self = self else { return }
                let projectDetail = self.viewModel.resume.projectDetailList[indexPath.row]
                self.viewModel.delete(projectDetail: projectDetail)
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
            router.route(from: self, to: .confirmationAlert("Project Detail", deleteAction))
        case .addProjectDetail:
            break
        }
    }
}

// MARK: - ProfileImageEditorCellDelegate
extension ResumeEditorViewController: ProfileImageEditorCellDelegate {
    func didPressButton(_ tableViewCell: ProfileImageEditorCell) {
        router.route(from: self, to: .imagePicker(self))
    }
}

// MARK: - NameEditorCellDelegate
extension ResumeEditorViewController: NameEditorCellDelegate {
    func didChangeName(
        _ tableViewCell: NameEditorCell,
        name: String?
    ) {
        viewModel.set(name: name)
    }
    
    func willBeginCellUpdate(_ tableViewCell: NameEditorCell) {
        tableView.beginUpdates()
    }
    
    func didEndCellUpdate(_ tableViewCell: NameEditorCell) {
        tableView.endUpdates()
    }
}

// MARK: - MobileNumberEditorCellDelegate
extension ResumeEditorViewController: MobileNumberEditorCellDelegate {
    func didChangeMobileNumber(
        _ tableViewCell: MobileNumberEditorCell,
        mobileNumber: String?
    ) {
        viewModel.set(mobileNumber: mobileNumber)
    }
    
    func willBeginCellUpdate(_ tableViewCell: MobileNumberEditorCell) {
        tableView.beginUpdates()
    }
    
    func didEndCellUpdate(_ tableViewCell: MobileNumberEditorCell) {
        tableView.endUpdates()
    }
}

// MARK: - EmailAddressEditorCellDelegate
extension ResumeEditorViewController: EmailAddressEditorCellDelegate {
    func didChangeEmailAddress(
        _ tableViewCell: EmailAddressEditorCell,
        emailAddress: String?
    ) {
        viewModel.set(emailAddress: emailAddress)
    }
    
    func willBeginCellUpdate(_ tableViewCell: EmailAddressEditorCell) {
        tableView.beginUpdates()
    }
    
    func didEndCellUpdate(_ tableViewCell: EmailAddressEditorCell) {
        tableView.endUpdates()
    }
}

// MARK: - ResidenceAddressEditorCellDelegate
extension ResumeEditorViewController: ResidenceAddressEditorCellDelegate {
    func didChangeResidenceAddress(
        _ tableViewCell: ResidenceAddressEditorCell,
        residenceAddress: String?
    ) {
        viewModel.set(residenceAddress: residenceAddress)
    }
}

// MARK: - CareerObjectiveEditorCellDelegate
extension ResumeEditorViewController: CareerObjectiveEditorCellDelegate {
    func didChangeCareerObjective(
        _ tableViewCell: CareerObjectiveEditorCell,
        careerObjective: String?
    ) {
        viewModel.set(careerObjective: careerObjective)
    }
}

// MARK: - TotalYearsOfExperienceEditorCellDelegate
extension ResumeEditorViewController: TotalYearsOfExperienceEditorCellDelegate {
    func didChangeTotalYearsOfExperience(
        _ tableViewCell: TotalYearsOfExperienceEditorCell,
        totalYearsOfExperience: String?
    ) {
        viewModel.set(totalYearsOfExperience: totalYearsOfExperience)
    }
}

// MARK: - WorkSummaryEditorViewControllerDelegate
extension ResumeEditorViewController: WorkSummaryEditorViewControllerDelegate {
    func done(
        _ viewController: WorkSummaryEditorViewController,
        workSummary: WorkSummary
    ) {
        viewModel.set(workSummary: workSummary)
        tableView.reloadData()
    }
}

// MARK: - SkillEditorViewControllerDelegate
extension ResumeEditorViewController: SkillEditorViewControllerDelegate {
    func done(
        _ viewController: SkillEditorViewController,
        skill: Skill
    ) {
        viewModel.set(skill: skill)
        tableView.reloadData()
    }
}

// MARK: - EducationDetailEditorViewControllerDelegate
extension ResumeEditorViewController: EducationDetailEditorViewControllerDelegate {
    func done(
        _ viewController: EducationDetailEditorViewController,
        educationDetail: EducationDetail
    ) {
        viewModel.set(educationDetail: educationDetail)
        tableView.reloadData()
    }
}

// MARK: - ProjectDetailEditorViewControllerDelegate
extension ResumeEditorViewController: ProjectDetailEditorViewControllerDelegate {
    func done(
        _ viewController: ProjectDetailEditorViewController,
        projectDetail: ProjectDetail
    ) {
        viewModel.set(projectDetail: projectDetail)
        tableView.reloadData()
    }
}

// MARK: - UIImagePickerControllerDelegate
extension ResumeEditorViewController: UIImagePickerControllerDelegate {
    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]
    ) {
        guard let image = info[.editedImage] as? UIImage else { return }
        viewModel.set(profileImage: image)
        tableView.reloadData()
        picker.dismiss(animated: true)
    }
}

// MARK: - UINavigationControllerDelegate
extension ResumeEditorViewController: UINavigationControllerDelegate {}
