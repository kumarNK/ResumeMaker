//
//  WorkSummaryCell.swift
//  ResumeMaker
//
//  Created by Narender Kumar on 29/04/2022.
//


import UIKit

class WorkSummaryCell: UITableViewCell {
    private let companyNameLabel = UILabel()
    private let durationLabel = UILabel()
    
    var workSummary: WorkSummary? {
        didSet {
            companyNameLabel.text = workSummary?.companyName
            durationLabel.text = workSummary?.duration
        }
    }
    
    static let reuseIdentifier = String(describing: WorkSummaryCell.self)
    
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
        contentView.addSubview(companyNameLabel)
        contentView.addSubview(durationLabel)
    }
    
    private func configureHierarchy() {
        configureView()
        configureCompanyNameLabel()
        configureDurationLabel()
    }
    
    private func layoutHierarchy() {
        layoutCompanyNameLabel()
        layoutDurationLabel()
    }
    
    private func configureView() {
        backgroundColor = .systemBackground
        selectionStyle = .none
    }
    
    private func configureCompanyNameLabel() {
        companyNameLabel.adjustsFontForContentSizeCategory = true
        companyNameLabel.font = .preferredFont(forTextStyle: .body)
        companyNameLabel.numberOfLines = 0
    }
    
    private func layoutCompanyNameLabel() {
        let inset: CGFloat = 20
        companyNameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            companyNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            companyNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            companyNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset)
        ])
    }
    
    private func configureDurationLabel() {
        durationLabel.adjustsFontForContentSizeCategory = true
        durationLabel.font = .preferredFont(forTextStyle: .subheadline)
        durationLabel.textColor = .secondaryLabel
        durationLabel.numberOfLines = 0
    }
    
    private func layoutDurationLabel() {
        let inset: CGFloat = 20
        durationLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            durationLabel.topAnchor.constraint(equalTo: companyNameLabel.bottomAnchor, constant: 4),
            durationLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            durationLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            durationLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset)
        ])
    }
}
