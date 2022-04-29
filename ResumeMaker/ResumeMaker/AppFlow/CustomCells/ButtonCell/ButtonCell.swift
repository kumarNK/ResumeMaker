//
//  ButtonCell.swift
//  ResumeMaker
//
//  Created by Narender Kumar on 29/04/2022.
//


import UIKit

class ButtonCell: UITableViewCell {
    let button = UIButton()
    
    var action: (() -> Void)?
    
    static let reuseIdentifier = String(describing: ButtonCell.self)
    
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
        contentView.addSubview(button)
    }
    
    private func configureHierarchy() {
        configureView()
        configureButton()
    }
    
    private func layoutHierarchy() {
        layoutButton()
    }
    
    private func configureView() {
        backgroundColor = .systemBackground
        selectionStyle = .none
    }
    
    private func configureButton() {
        button.addTarget(self, action: #selector(action(_:)), for: .touchUpInside)
    }
    
    @objc private func action(_ button: UIButton) {
        action?()
    }
    
    private func layoutButton() {
        let inset: CGFloat = 20
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            button.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            button.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset)
        ])
    }
}
