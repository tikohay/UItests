//
//  UserCell.swift
//  Lesson5
//
//  Created by Karakhanyan Tigran on 06.04.2022.
//

import UIKit

class UserCell: UICollectionViewCell, CellConfiguration {
    
    private var nameLabel = UILabel()
    private var companyNameLabel = UILabel()
   
    static var resuseId: String = "UserCell"
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        nameLabel.text = nil
    }
    
    func setCell(with user: UserData) {
        self.nameLabel.text = user.name
        self.companyNameLabel.text = user.company.name
    }
    
    private func setupViews() {
        nameLabel.numberOfLines = 0
        nameLabel.textAlignment = .center
        companyNameLabel.numberOfLines = 0
        companyNameLabel.textAlignment = .center
        
        addSubview(nameLabel)
        addSubview(companyNameLabel)
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        companyNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 4),
            nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 4),
            nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: -4),
            nameLabel.heightAnchor.constraint(equalToConstant: self.frame.height / 2),
            
            companyNameLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            companyNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 4),
            companyNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: -4),
            companyNameLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -4),
        ])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setupViews()
    }
}
