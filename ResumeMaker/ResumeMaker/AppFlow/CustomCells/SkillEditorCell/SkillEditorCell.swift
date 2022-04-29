//
//  SkillEditorCell.swift
//  ResumeMaker
//
//  Created by Narender Kumar on 29/04/2022.
//


import UIKit

protocol SkillEditorCellDelegate: AnyObject {
    func didChangeSkill(
        _ tableViewCell: SkillEditorCell,
        text: String?
    )
}

class SkillEditorCell: UITableViewCell {
    private let skillTextField = UITextField()
    
    weak var delegate: SkillEditorCellDelegate?
    
    var skill: Skill? {
        didSet {
            skillTextField.text = skill?.text
        }
    }
    
    static let reuseIdentifier = String(describing: SkillEditorCell.self)
    
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
        contentView.addSubview(skillTextField)
    }
    
    private func configureHierarchy() {
        configureView()
        configureSkillTextField()
    }
    
    private func layoutHierarchy() {
        layoutSkillTextField()
    }
    
    private func configureView() {
        backgroundColor = .systemBackground
        selectionStyle = .none
    }
    
    private func configureSkillTextField() {
        skillTextField.delegate = self
        skillTextField.font = .preferredFont(forTextStyle: .body)
        skillTextField.placeholder = "Skill"
        skillTextField.borderStyle = .roundedRect
        skillTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        if let text = textField.text, text.isEmpty {
            delegate?.didChangeSkill(self, text: nil)
        } else {
            delegate?.didChangeSkill(self, text: textField.text)
        }
    }
    
    private func layoutSkillTextField() {
        let inset: CGFloat = 20
        skillTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            skillTextField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            skillTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            skillTextField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            skillTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset)
        ])
    }
}

// MARK: - UITextFieldDelegate
extension SkillEditorCell: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
