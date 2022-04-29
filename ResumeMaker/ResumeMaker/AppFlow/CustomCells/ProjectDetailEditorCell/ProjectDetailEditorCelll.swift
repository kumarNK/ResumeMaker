//
//  ProjectDetailEditorCelll.swift
//  ResumeMaker
//
//  Created by Narender Kumar on 29/04/2022.
//


import UIKit

protocol ProjectDetailEditorCellDelegate: AnyObject {
    func didChangeProjectName(
        _ tableViewCell: ProjectDetailEditorCell,
        projectName: String?
    )
    func didChangeTeamSize(
        _ tableViewCell: ProjectDetailEditorCell,
        teamSize: String?
    )
    func didChangeProjectSummary(
        _ tableViewCell: ProjectDetailEditorCell,
        projectSummary: String?
    )
    func didChangeTechnologyUsed(
        _ tableViewCell: ProjectDetailEditorCell,
        technologyUsed: String?
    )
    func didChangeRole(
        _ tableViewCell: ProjectDetailEditorCell,
        role: String?
    )
}

class ProjectDetailEditorCell: UITableViewCell {
    private let projectNameTextField = UITextField()
    private let teamSizeTextField = UITextField()
    private let projectSummaryLabel = UILabel()
    private let projectSummaryTextView = UITextView()
    private let technologyUsedLabel = UILabel()
    private let technologyUsedTextView = UITextView()
    private let roleTextField = UITextField()
    
    weak var delegate: ProjectDetailEditorCellDelegate?
    
    var projectDetail: ProjectDetail? {
        didSet {
            projectNameTextField.text = projectDetail?.projectName
            teamSizeTextField.text = projectDetail?.teamSize
            projectSummaryTextView.text = projectDetail?.projectSummary
            technologyUsedTextView.text = projectDetail?.technologyUsed
            roleTextField.text = projectDetail?.role
        }
    }
    
    static let reuseIdentifier = String(describing: ProjectDetailEditorCell.self)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addHierarchy()
        configureHierarchy()
        layoutHierarchy()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addHierarchy() {
        contentView.addSubview(projectNameTextField)
        contentView.addSubview(teamSizeTextField)
        contentView.addSubview(projectSummaryLabel)
        contentView.addSubview(projectSummaryTextView)
        contentView.addSubview(technologyUsedLabel)
        contentView.addSubview(technologyUsedTextView)
        contentView.addSubview(roleTextField)
    }
    
    private func configureHierarchy() {
        configureView()
        configureProjectNameTextField()
        configureTeamSizeTextField()
        configureProjectSummaryLabel()
        configureProjectSummaryTextView()
        configurTechnologyUsedLabel()
        configureTechnologyUsedTextView()
        configureRoleTextField()
    }
    
    private func layoutHierarchy() {
        layoutProejctNameTextField()
        layoutTeamSizeTextField()
        layoutProjectSummaryLabel()
        layoutProjectSummaryTextView()
        layoutTechnologyUsedLabel()
        layoutTechnologyUsedTextView()
        layoutRoleTextField()
    }
    
    private func configureView() {
        backgroundColor = .systemBackground
        selectionStyle = .none
    }
    
    private func configureProjectNameTextField() {
        projectNameTextField.delegate = self
        projectNameTextField.font = .preferredFont(forTextStyle: .body)
        projectNameTextField.placeholder = "Project Name"
        projectNameTextField.borderStyle = .roundedRect
        projectNameTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    private func configureTeamSizeTextField() {
        teamSizeTextField.delegate = self
        teamSizeTextField.font = .preferredFont(forTextStyle: .body)
        teamSizeTextField.placeholder = "Team Size"
        teamSizeTextField.keyboardType = .numberPad
        teamSizeTextField.borderStyle = .roundedRect
        teamSizeTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    private func configureProjectSummaryLabel() {
        projectSummaryLabel.text = "Project Summary"
        projectSummaryLabel.font = .preferredFont(forTextStyle: .subheadline)
        projectSummaryLabel.textColor = .secondaryLabel
    }
    
    private func configureProjectSummaryTextView() {
        projectSummaryTextView.delegate = self
        projectSummaryTextView.font = .preferredFont(forTextStyle: .body)
        projectSummaryTextView.setRoundedRectBorderStyle()
    }
    
    private func configurTechnologyUsedLabel() {
        technologyUsedLabel.text = "Technology Used"
        technologyUsedLabel.font = .preferredFont(forTextStyle: .subheadline)
        technologyUsedLabel.textColor = .secondaryLabel
    }
    
    private func configureTechnologyUsedTextView() {
        technologyUsedTextView.delegate = self
        technologyUsedTextView.font = .preferredFont(forTextStyle: .body)
        technologyUsedTextView.setRoundedRectBorderStyle()
    }
    
    private func configureRoleTextField() {
        roleTextField.delegate = self
        roleTextField.font = .preferredFont(forTextStyle: .body)
        roleTextField.placeholder = "Role"
        roleTextField.borderStyle = .roundedRect
        roleTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        if textField == projectNameTextField {
            projectNameTextFieldDidChange(textField)
        }
        if textField == teamSizeTextField {
            teamSizeTextFieldDidChange(textField)
        }
        if textField == roleTextField {
            roleTextFieldDidChange(textField)
        }
    }
    
    private func projectNameTextFieldDidChange(_ textField: UITextField) {
        if let text = textField.text, text.isEmpty {
            delegate?.didChangeProjectName(self, projectName: nil)
        } else {
            delegate?.didChangeProjectName(self, projectName: textField.text)
        }
    }
    
    private func teamSizeTextFieldDidChange(_ textField: UITextField) {
        if let text = textField.text, text.isEmpty {
            delegate?.didChangeTeamSize(self, teamSize: nil)
        } else {
            delegate?.didChangeTeamSize(self, teamSize: textField.text)
        }
    }
    
    private func projectSummaryTextViewDidChange(_ textView: UITextView) {
        let text = textView.text.trimmingCharacters(in: .whitespacesAndNewlines)
        if text.isEmpty {
            delegate?.didChangeProjectSummary(self, projectSummary: nil)
        } else {
            delegate?.didChangeProjectSummary(self, projectSummary: textView.text)
        }
    }
    
    private func technologyUsedTextViewDidChange(_ textView: UITextView) {
        let text = textView.text.trimmingCharacters(in: .whitespacesAndNewlines)
        if text.isEmpty {
            delegate?.didChangeTechnologyUsed(self, technologyUsed: nil)
        } else {
            delegate?.didChangeTechnologyUsed(self, technologyUsed: textView.text)
        }
    }
    
    private func roleTextFieldDidChange(_ textField: UITextField) {
        if let text = textField.text, text.isEmpty {
            delegate?.didChangeRole(self, role: nil)
        } else {
            delegate?.didChangeRole(self, role: textField.text)
        }
    }
    
    private func layoutProejctNameTextField() {
        let inset: CGFloat = 20
        projectNameTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            projectNameTextField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            projectNameTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            projectNameTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset)
        ])
    }
    
    private func layoutTeamSizeTextField() {
        let inset: CGFloat = 20
        teamSizeTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            teamSizeTextField.topAnchor.constraint(equalTo: projectNameTextField.bottomAnchor, constant: 8),
            teamSizeTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            teamSizeTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset)
        ])
    }
    
    private func layoutProjectSummaryLabel() {
        let inset: CGFloat = 20
        projectSummaryLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            projectSummaryLabel.topAnchor.constraint(equalTo: teamSizeTextField.bottomAnchor, constant: 8),
            projectSummaryLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            projectSummaryLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset)
        ])
    }
    
    private func layoutProjectSummaryTextView() {
        let inset: CGFloat = 20
        projectSummaryTextView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            projectSummaryTextView.topAnchor.constraint(equalTo: projectSummaryLabel.bottomAnchor, constant: 4),
            projectSummaryTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            projectSummaryTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
            projectSummaryTextView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    private func layoutTechnologyUsedLabel() {
        let inset: CGFloat = 20
        technologyUsedLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            technologyUsedLabel.topAnchor.constraint(equalTo: projectSummaryTextView.bottomAnchor, constant: 8),
            technologyUsedLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            technologyUsedLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset)
        ])
    }
    
    private func layoutTechnologyUsedTextView() {
        let inset: CGFloat = 20
        technologyUsedTextView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            technologyUsedTextView.topAnchor.constraint(equalTo: technologyUsedLabel.bottomAnchor, constant: 4),
            technologyUsedTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            technologyUsedTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
            technologyUsedTextView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    private func layoutRoleTextField() {
        let inset: CGFloat = 20
        roleTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            roleTextField.topAnchor.constraint(equalTo: technologyUsedTextView.bottomAnchor, constant: 8),
            roleTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            roleTextField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            roleTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset)
        ])
    }
}

// MARK: - UITextFieldDelegate
extension ProjectDetailEditorCell: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if projectNameTextField.resignFirstResponder() {
            teamSizeTextField.becomeFirstResponder()
        }
        textField.resignFirstResponder()
        return true
    }
}

// MARK: - UITextViewDelegate
extension ProjectDetailEditorCell: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        if textView == projectSummaryTextView {
            projectSummaryTextViewDidChange(textView)
        }
        if textView == technologyUsedTextView {
            technologyUsedTextViewDidChange(textView)
        }
    }
}
