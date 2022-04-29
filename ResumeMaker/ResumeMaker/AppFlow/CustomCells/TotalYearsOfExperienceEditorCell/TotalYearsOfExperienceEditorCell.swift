//
//  TotalYearsOfExperienceEditorCell.swift
//  ResumeMaker
//
//  Created by Narender Kumar on 29/04/2022.
//


import UIKit

protocol TotalYearsOfExperienceEditorCellDelegate: AnyObject {
    func didChangeTotalYearsOfExperience(
        _ tableViewCell: TotalYearsOfExperienceEditorCell,
        totalYearsOfExperience: String?
    )
}

class TotalYearsOfExperienceEditorCell: UITableViewCell {
    private let textField = UITextField()
    
    weak var delegate: TotalYearsOfExperienceEditorCellDelegate?
    
    var totalYearsOfExperience: String? {
        didSet {
            textField.text = totalYearsOfExperience
        }
    }
    
    static let reuseIdentifier = String(describing: TotalYearsOfExperienceEditorCell.self)
    
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
        contentView.addSubview(textField)
    }
    
    private func configureHierarchy() {
        configureView()
        configureTextField()
    }
    
    private func layoutHierarchy() {
        layoutTextField()
    }
    
    private func configureView() {
        backgroundColor = .systemBackground
        selectionStyle = .none
    }
    
    private func configureTextField() {
        textField.font = .preferredFont(forTextStyle: .body)
        textField.placeholder = "Total Years of Experience"
        textField.keyboardType = .decimalPad
        textField.borderStyle = .roundedRect
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        if let text = textField.text, text.isEmpty {
            delegate?.didChangeTotalYearsOfExperience(self, totalYearsOfExperience: nil)
        } else {
            delegate?.didChangeTotalYearsOfExperience(self, totalYearsOfExperience: textField.text)
        }
    }
    
    private func layoutTextField() {
        let inset: CGFloat = 20
        textField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            textField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            textField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            textField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset)
        ])
    }
}
