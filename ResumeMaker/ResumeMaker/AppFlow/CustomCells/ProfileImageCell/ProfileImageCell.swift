//
//  ProfileImageCell.swift
//  ResumeMaker
//
//  Created by Narender Kumar on 29/04/2022.
//


import UIKit

class ProfileImageCell: UITableViewCell {
    private let profileImageView = UIImageView()
    
    var image: UIImage? {
        didSet {
            profileImageView.image = image ?? UIImage(systemName: "person.crop.circle.fill")
        }
    }
    
    static let reuseIdentifier = String(describing: ProfileImageCell.self)
    
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
    }
    
    private func configureHierarchy() {
        configureView()
        configureProfileImageView()
    }
    
    private func layoutHierarchy() {
        layoutProfileImageView()
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
            profileImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            profileImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            profileImageView.widthAnchor.constraint(equalToConstant: 100),
            profileImageView.heightAnchor.constraint(equalTo: profileImageView.widthAnchor)
        ])
    }
}
