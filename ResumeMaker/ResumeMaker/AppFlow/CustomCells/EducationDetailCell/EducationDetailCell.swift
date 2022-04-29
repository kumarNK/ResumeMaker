//
//  EducationDetailCell.swift
//  ResumeMaker
//
//  Created by Narender Kumar on 29/04/2022.
//


import UIKit

class EducationDetailCell: UITableViewCell {
    private let classNameLabel = UILabel()
    private let passingYearLabel = UILabel()
    private let percentageOrCGPALabel = UILabel()
    
    var educationDetail: EducationDetail? {
        didSet {
            classNameLabel.text = educationDetail?.`class`
            passingYearLabel.text = educationDetail?.passingYear
            percentageOrCGPALabel.text = educationDetail?.percentageOrCGPA
        }
    }
    
    static let reuseIdentifier = String(describing: EducationDetailCell.self)
    
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
        contentView.addSubview(classNameLabel)
        contentView.addSubview(passingYearLabel)
        contentView.addSubview(percentageOrCGPALabel)
    }
    
    private func configureHierarchy() {
        configureView()
        configureClassLabel()
        configurePassingYearLabel()
        configurePercentageOrCGPALabel()
    }
    
    private func layoutHierarchy() {
        layoutClassLabel()
        layoutPassingYearLabel()
        layoutPercentageOrCGPALabel()
    }
    
    private func configureView() {
        backgroundColor = .systemBackground
        selectionStyle = .none
    }
    
    private func configureClassLabel() {
        classNameLabel.adjustsFontForContentSizeCategory = true
        classNameLabel.font = .preferredFont(forTextStyle: .body)
        classNameLabel.numberOfLines = 0
    }
    
    private func layoutClassLabel() {
        let inset: CGFloat = 20
        classNameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            classNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            classNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            classNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset)
        ])
    }
    
    private func configurePassingYearLabel() {
        passingYearLabel.adjustsFontForContentSizeCategory = true
        passingYearLabel.font = .preferredFont(forTextStyle: .subheadline)
        passingYearLabel.textColor = .secondaryLabel
        passingYearLabel.numberOfLines = 0
    }
    
    private func layoutPassingYearLabel() {
        let inset: CGFloat = 20
        passingYearLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            passingYearLabel.topAnchor.constraint(equalTo: classNameLabel.bottomAnchor, constant: 4),
            passingYearLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            passingYearLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset)
        ])
    }
    
    private func configurePercentageOrCGPALabel() {
        percentageOrCGPALabel.adjustsFontForContentSizeCategory = true
        percentageOrCGPALabel.font = .preferredFont(forTextStyle: .footnote)
        percentageOrCGPALabel.numberOfLines = 0
    }
    
    private func layoutPercentageOrCGPALabel() {
        let inset: CGFloat = 20
        percentageOrCGPALabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            percentageOrCGPALabel.topAnchor.constraint(equalTo: passingYearLabel.bottomAnchor, constant: 4),
            percentageOrCGPALabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            percentageOrCGPALabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            percentageOrCGPALabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset)
        ])
    }
}
