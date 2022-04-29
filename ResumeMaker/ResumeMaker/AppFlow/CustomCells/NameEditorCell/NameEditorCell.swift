//
//  NameEditorCell.swift
//  ResumeMaker
//
//  Created by Narender Kumar on 29/04/2022.
//


import UIKit

protocol NameEditorCellDelegate: AnyObject {
    func didChangeName(
        _ tableViewCell: NameEditorCell,
        name: String?
    )
    func willBeginCellUpdate(_ tableViewCell: NameEditorCell)
    func didEndCellUpdate(_ tableViewCell: NameEditorCell)
}

class NameEditorCell: UITableViewCell {
    private let textField = UITextField()
    private let errorLabel = UILabel()
    
    weak var delegate: NameEditorCellDelegate?
    
    var name: String? {
        didSet {
            textField.text = name
        }
    }
    
    static let reuseIdentifier = String(describing: NameEditorCell.self)
    
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
        contentView.addSubview(errorLabel)
    }
    
    private func configureHierarchy() {
        configureView()
        configureTextField()
        configureErrorLabel()
    }
    
    private func layoutHierarchy() {
        layoutTextField()
        layoutErrorLabel()
    }
    
    private func configureView() {
        backgroundColor = .systemBackground
        selectionStyle = .none
    }
    
    private func configureTextField() {
        textField.delegate = self
        textField.font = .preferredFont(forTextStyle: .body)
        textField.placeholder = "Name"
        textField.borderStyle = .roundedRect
        textField.autocorrectionType = .no
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        if let text = textField.text, !text.isEmpty {
            clearError()
            delegate?.didChangeName(self, name: text)
        } else {
            errorLabel.text = "Please enter name"
            updateLayout()
            delegate?.didChangeName(self, name: textField.text)
        }
    }
    
    private func layoutTextField() {
        let inset: CGFloat = 20
        textField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            textField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            textField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset)
        ])
    }
    
    private func configureErrorLabel() {
        errorLabel.font = .preferredFont(forTextStyle: .caption2)
        errorLabel.numberOfLines = 0
        errorLabel.textColor = .red
    }
    
    private func layoutErrorLabel() {
        let inset: CGFloat = 20
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            errorLabel.topAnchor.constraint(equalTo: textField.bottomAnchor),
            errorLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            errorLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            errorLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset)
        ])
    }
    
    private func updateLayout() {
        delegate?.willBeginCellUpdate(self)
        layoutIfNeeded()
        delegate?.didEndCellUpdate(self)
    }
    
    private func clearError() {
        errorLabel.text = nil
        updateLayout()
    }
}

// MARK: - UITextFieldDelegate
extension NameEditorCell: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
