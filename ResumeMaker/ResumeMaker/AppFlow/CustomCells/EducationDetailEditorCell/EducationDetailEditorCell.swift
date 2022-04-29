//
//  EducationDetailEditorCell.swift
//  ResumeMaker
//
//  Created by Narender Kumar on 29/04/2022.
//


import UIKit

protocol EducationDetailEditorCellDelegate: AnyObject {
    func didChangeClass(
        _ tableViewCell: EducationDetailEditorCell,
        class: String?
    )
    func didChangePassingYear(
        _ tableViewCell: EducationDetailEditorCell,
        passingYear: String?
    )
    func didChangePercentageOrCGPA(
        _ tableViewCell: EducationDetailEditorCell,
        percentageOrCGPA: String?
    )
}

class EducationDetailEditorCell: UITableViewCell {
    private let classTextField = UITextField()
    private let passingYearTextField = UITextField()
    private let percentageOrCGPATextField = UITextField()
    
    weak var delegate: EducationDetailEditorCellDelegate?
    
    var educationDetail: EducationDetail? {
        didSet {
            classTextField.text = educationDetail?.`class`
            passingYearTextField.text = educationDetail?.passingYear
            percentageOrCGPATextField.text = educationDetail?.percentageOrCGPA
        }
    }
    
    static let reuseIdentifier = String(describing: EducationDetailEditorCell.self)
    
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
        contentView.addSubview(classTextField)
        contentView.addSubview(passingYearTextField)
        contentView.addSubview(percentageOrCGPATextField)
    }
    
    private func configureHierarchy() {
        configureView()
        configureClassTextField()
        configurePassingYearTextField()
        configurePercentageOrCGPATextField()
    }
    
    private func layoutHierarchy() {
        layoutClassTextField()
        layoutPassingYearTextField()
        layoutPercentageOrCGPATextField()
    }
    
    private func configureView() {
        backgroundColor = .systemBackground
        selectionStyle = .none
    }
    
    private func configureClassTextField() {
        classTextField.delegate = self
        classTextField.font = .preferredFont(forTextStyle: .body)
        classTextField.placeholder = "Class"
        classTextField.borderStyle = .roundedRect
        classTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    private func configurePassingYearTextField() {
        passingYearTextField.delegate = self
        passingYearTextField.font = .preferredFont(forTextStyle: .body)
        passingYearTextField.placeholder = "Passing Year"
        passingYearTextField.borderStyle = .roundedRect
        passingYearTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    private func configurePercentageOrCGPATextField() {
        percentageOrCGPATextField.delegate = self
        percentageOrCGPATextField.font = .preferredFont(forTextStyle: .body)
        percentageOrCGPATextField.placeholder = "Percentage/CGPA"
        percentageOrCGPATextField.borderStyle = .roundedRect
        percentageOrCGPATextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        if textField == classTextField {
            classTextFieldDidChange(textField)
        }
        if textField == passingYearTextField {
            passingYearTextFieldDidChange(textField)
        }
        if textField == percentageOrCGPATextField {
            percentageOrCGPATextFieldDidChange(textField)
        }
    }
    
    private func classTextFieldDidChange(_ textField: UITextField) {
        if let text = textField.text, text.isEmpty {
            delegate?.didChangeClass(self, class: nil)
        } else {
            delegate?.didChangeClass(self, class: textField.text)
        }
    }
    
    private func passingYearTextFieldDidChange(_ textField: UITextField) {
        if let text = textField.text, text.isEmpty {
            delegate?.didChangePassingYear(self, passingYear: nil)
        } else {
            delegate?.didChangePassingYear(self, passingYear: textField.text)
        }
    }
    
    private func percentageOrCGPATextFieldDidChange(_ textField: UITextField) {
        if let text = textField.text, text.isEmpty {
            delegate?.didChangePercentageOrCGPA(self, percentageOrCGPA: nil)
        } else {
            delegate?.didChangePercentageOrCGPA(self, percentageOrCGPA: textField.text)
        }
    }
    
    private func layoutClassTextField() {
        let inset: CGFloat = 20
        classTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            classTextField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            classTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            classTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset)
        ])
    }
    
    private func layoutPassingYearTextField() {
        let inset: CGFloat = 20
        passingYearTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            passingYearTextField.topAnchor.constraint(equalTo: classTextField.bottomAnchor, constant: 8),
            passingYearTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            passingYearTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset)
        ])
    }
    
    private func layoutPercentageOrCGPATextField() {
        let inset: CGFloat = 20
        percentageOrCGPATextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            percentageOrCGPATextField.topAnchor.constraint(equalTo: passingYearTextField.bottomAnchor, constant: 8),
            percentageOrCGPATextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            percentageOrCGPATextField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            percentageOrCGPATextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset)
        ])
    }
}

// MARK: - UITextFieldDelegate
extension EducationDetailEditorCell: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if classTextField.resignFirstResponder() {
            passingYearTextField.becomeFirstResponder()
        } else if passingYearTextField.resignFirstResponder() {
            percentageOrCGPATextField.becomeFirstResponder()
        }
        textField.resignFirstResponder()
        return true
    }
}
