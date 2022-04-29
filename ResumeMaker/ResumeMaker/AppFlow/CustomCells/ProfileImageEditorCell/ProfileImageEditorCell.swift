//
//  ProfileImageEditorCell.swift
//  ResumeMaker
//
//  Created by Narender Kumar on 29/04/2022.
//


import UIKit

protocol ProfileImageEditorCellDelegate: AnyObject {
    func didPressButton(_ tableViewCell: ProfileImageEditorCell)
}

class ProfileImageEditorCell: UITableViewCell {
    private let profileImageView = UIImageView()
    private let button = UIButton()
    
    weak var delegate: ProfileImageEditorCellDelegate?
    
    var image: UIImage? {
        didSet {
            profileImageView.image = image ?? UIImage(systemName: "person.crop.circle.fill")
//            let title = image == nil ? "Add Photo" : "Edit"
//            var configuration = UIButton.Configuration.plain()
//            configuration.title = title
//            button.configuration = configuration

            let image = UIImage(named: "camera_black") as UIImage?
            button.setImage(image, for: .normal)
        }
    }
    
    static let reuseIdentifier = String(describing: ProfileImageEditorCell.self)
    
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
        contentView.addSubview(profileImageView)
        contentView.addSubview(button)
    }
    
    private func configureHierarchy() {
        configureView()
        configureProfileImageView()
        configureButton()
    }
    
    private func layoutHierarchy() {
        layoutProfileImageView()
        layoutButton()
    }
    
    private func configureView() {
        backgroundColor = .systemBackground
        selectionStyle = .none
    }
    
    private func configureProfileImageView() {
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.tintColor = .systemGray4
        profileImageView.clipsToBounds = true
        profileImageView.layer.cornerRadius = 50
    }
    
    private func layoutProfileImageView() {
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            profileImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            profileImageView.widthAnchor.constraint(equalToConstant: 100),
            profileImageView.heightAnchor.constraint(equalTo: profileImageView.widthAnchor)
        ])
    }
    
    private func configureButton() {
        button.addTarget(self, action: #selector(action(_:)), for: .touchUpInside)
    }
    
    @objc private func action(_ button: UIButton) {
        delegate?.didPressButton(self)
    }
    
    private func layoutButton() {
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: -14),
            button.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            button.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
    }
}
