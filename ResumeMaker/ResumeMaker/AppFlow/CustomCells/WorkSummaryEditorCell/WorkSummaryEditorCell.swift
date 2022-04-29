//
//  WorkSummaryEditorCell.swift
//  ResumeMaker
//
//  Created by Narender Kumar on 29/04/2022.
//


import UIKit

protocol WorkSummaryEditorCellDelegate: AnyObject {
    func didChangeCompanyName(
        _ tableViewCell: WorkSummaryEditorCell,
        companyName: String?
    )
    func didChangeDuration(_ tableViewCell: WorkSummaryEditorCell,
        duration: String?
    )
}

class WorkSummaryEditorCell: UITableViewCell {
    private let companyNameTextField = UITextField()
    private let durationTextField = UITextField()
    
    weak var delegate: WorkSummaryEditorCellDelegate?
    
    var workSummary: WorkSummary? {
        didSet {
            companyNameTextField.text = workSummary?.companyName
            durationTextField.text = workSummary?.duration
        }
    }
    
    static let reuseIdentifier = String(describing: WorkSummaryEditorCell.self)
    
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
        contentView.addSubview(companyNameTextField)
        contentView.addSubview(durationTextField)
    }
    
    private func configureHierarchy() {
        configureView()
        configureCompanyNameTextField()
        configureDurationTextField()
    }
    
    private func layoutHierarchy() {
        layoutCompanyNameTextField()
        layoutDurationTextField()
    }
    
    private func configureView() {
        backgroundColor = .systemBackground
        selectionStyle = .none
    }
    
    private func configureCompanyNameTextField() {
        companyNameTextField.delegate = self
        companyNameTextField.font = .preferredFont(forTextStyle: .body)
        companyNameTextField.placeholder = "Company Name"
        companyNameTextField.borderStyle = .roundedRect
        companyNameTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    private func configureDurationTextField() {
        durationTextField.delegate = self
        durationTextField.font = .preferredFont(forTextStyle: .body)
        durationTextField.placeholder = "Duration"
        durationTextField.borderStyle = .roundedRect
        durationTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        if textField == companyNameTextField {
            companyNameTextFieldDidChange(textField)
        }
        if textField == durationTextField {
            durationTextFieldDidChange(textField)
        }
    }
    
    private func companyNameTextFieldDidChange(_ textField: UITextField) {
        if let text = textField.text, text.isEmpty {
            delegate?.didChangeCompanyName(self, companyName: nil)
        } else {
            delegate?.didChangeCompanyName(self, companyName: textField.text)
        }
    }
    
    private func durationTextFieldDidChange(_ textField: UITextField) {
        if let text = textField.text, text.isEmpty {
            delegate?.didChangeDuration(self, duration: nil)
        } else {
            delegate?.didChangeDuration(self, duration: textField.text)
        }
    }
    
    private func layoutCompanyNameTextField() {
        let inset: CGFloat = 20
        companyNameTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            companyNameTextField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            companyNameTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            companyNameTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset)
        ])
    }
    
    private func layoutDurationTextField() {
        let inset: CGFloat = 20
        durationTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            durationTextField.topAnchor.constraint(equalTo: companyNameTextField.bottomAnchor, constant: 8),
            durationTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            durationTextField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            durationTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset)
        ])
    }
}

// MARK: - UITextFieldDelegate
extension WorkSummaryEditorCell: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if companyNameTextField.resignFirstResponder() {
            durationTextField.becomeFirstResponder()
        }
        textField.resignFirstResponder()
        return true
    }
}
