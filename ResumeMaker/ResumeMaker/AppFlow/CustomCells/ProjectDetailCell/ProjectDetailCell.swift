//
//  ProjectDetailCell.swift
//  ResumeMaker
//
//  Created by Narender Kumar on 29/04/2022.
//


import UIKit

class ProjectDetailCell: UITableViewCell {
    private let projectNameLabel = UILabel()
    private let teamSizeLabel = UILabel()
    private let projectSummaryLabel = UILabel()
    private let technologyUsedLabel = UILabel()
    private let roleLabel = UILabel()
    
    var projectDetail: ProjectDetail? {
        didSet {
            projectNameLabel.text = projectDetail?.projectName
            teamSizeLabel.text = projectDetail?.teamSize
            projectSummaryLabel.text = projectDetail?.projectSummary
            technologyUsedLabel.text = projectDetail?.technologyUsed
            roleLabel.text = projectDetail?.role
        }
    }
    
    static let reuseIdentifier = String(describing: ProjectDetailCell.self)
    
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
        contentView.addSubview(projectNameLabel)
        contentView.addSubview(teamSizeLabel)
        contentView.addSubview(projectSummaryLabel)
        contentView.addSubview(technologyUsedLabel)
        contentView.addSubview(roleLabel)
    }
    
    private func configureHierarchy() {
        configureView()
        configureProjectNameLabel()
        configureTeamSizeLabel()
        configureProjectSummaryLabel()
        configureTechnologyUsedLabel()
        configureRoleLabel()
    }
    
    private func layoutHierarchy() {
        layoutProjectNameLabel()
        layoutTeamSizeLabel()
        layoutProjectSummaryLabel()
        layoutTechnologyUsedLabel()
        layoutRoleLabel()
    }
    
    private func configureView() {
        backgroundColor = .systemBackground
        selectionStyle = .none
    }
    
    private func configureProjectNameLabel() {
        projectNameLabel.adjustsFontForContentSizeCategory = true
        projectNameLabel.font = .preferredFont(forTextStyle: .headline)
        projectNameLabel.numberOfLines = 0
    }
    
    private func layoutProjectNameLabel() {
        let inset: CGFloat = 20
        projectNameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            projectNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            projectNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            projectNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset)
        ])
    }
    
    private func configureTeamSizeLabel() {
        teamSizeLabel.adjustsFontForContentSizeCategory = true
        teamSizeLabel.font = .preferredFont(forTextStyle: .body)
        teamSizeLabel.textColor = .secondaryLabel
        teamSizeLabel.numberOfLines = 0
    }
    
    private func layoutTeamSizeLabel() {
        let inset: CGFloat = 20
        teamSizeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            teamSizeLabel.topAnchor.constraint(equalTo: projectNameLabel.bottomAnchor, constant: 4),
            teamSizeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            teamSizeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset)
        ])
    }
    
    private func configureProjectSummaryLabel() {
        projectSummaryLabel.adjustsFontForContentSizeCategory = true
        projectSummaryLabel.font = .preferredFont(forTextStyle: .subheadline)
        projectSummaryLabel.numberOfLines = 0
    }
    
    private func layoutProjectSummaryLabel() {
        let inset: CGFloat = 20
        projectSummaryLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            projectSummaryLabel.topAnchor.constraint(equalTo: teamSizeLabel.bottomAnchor, constant: 4),
            projectSummaryLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            projectSummaryLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset)
        ])
    }
    
    private func configureTechnologyUsedLabel() {
        technologyUsedLabel.adjustsFontForContentSizeCategory = true
        technologyUsedLabel.font = .preferredFont(forTextStyle: .footnote)
        technologyUsedLabel.textColor = .secondaryLabel
        technologyUsedLabel.numberOfLines = 0
    }
    
    private func layoutTechnologyUsedLabel() {
        let inset: CGFloat = 20
        technologyUsedLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            technologyUsedLabel.topAnchor.constraint(equalTo: projectSummaryLabel.bottomAnchor, constant: 4),
            technologyUsedLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            technologyUsedLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset)
        ])
    }
    
    private func configureRoleLabel() {
        roleLabel.adjustsFontForContentSizeCategory = true
        roleLabel.font = .preferredFont(forTextStyle: .subheadline)
        roleLabel.numberOfLines = 0
    }
    
    private func layoutRoleLabel() {
        let inset: CGFloat = 20
        roleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            roleLabel.topAnchor.constraint(equalTo: technologyUsedLabel.bottomAnchor, constant: 4),
            roleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            roleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            roleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset)
        ])
    }
}
