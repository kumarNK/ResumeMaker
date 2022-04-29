//
//  CareerObjectiveEditorCell.swift
//  ResumeMaker
//
//  Created by Narender Kumar on 29/04/2022.
//


import UIKit

protocol CareerObjectiveEditorCellDelegate: AnyObject {
    func didChangeCareerObjective(
        _ tableViewCell: CareerObjectiveEditorCell,
        careerObjective: String?
    )
}

class CareerObjectiveEditorCell: UITableViewCell {
    private let textView = UITextView()
    
    weak var delegate: CareerObjectiveEditorCellDelegate?
    
    var careerObjective: String? {
        didSet {
            textView.text = careerObjective
        }
    }
    
    static let reuseIdentifier = String(describing: CareerObjectiveEditorCell.self)
    
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
        contentView.addSubview(textView)
    }
    
    private func configureHierarchy() {
        configureView()
        configureTextView()
    }
    
    private func layoutHierarchy() {
        layoutTextView()
    }
    
    private func configureView() {
        backgroundColor = .systemBackground
        selectionStyle = .none
    }
    
    private func configureTextView() {
        textView.delegate = self
        textView.font = .preferredFont(forTextStyle: .body)
        textView.setRoundedRectBorderStyle()
    }
    
    private func layoutTextView() {
        let inset: CGFloat = 20
        textView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            textView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            textView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            textView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
            textView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
}

// MARK: - UITextViewDelegate
extension CareerObjectiveEditorCell: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        let text = textView.text.trimmingCharacters(in: .whitespacesAndNewlines)
        if text.isEmpty {
            delegate?.didChangeCareerObjective(self, careerObjective: nil)
        } else {
            delegate?.didChangeCareerObjective(self, careerObjective: text)
        }
    }
}
