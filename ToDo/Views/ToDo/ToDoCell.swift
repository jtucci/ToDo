//
//  ToDoCell.swift
//  ToDo
//
//  Created by Jony Tucci on 7/28/19.
//  Copyright © 2019 Jony Tucci. All rights reserved.
//

import UIKit
import SwipeCellKit
class ToDoCell: SwipeTableViewCell {
    
    //MARK:- Properties
    let iconImageView: UIImageView = UIImageView(cornerRadius: 8)
    let nameLabel = UILabel(text: "ToDo Item", font: .systemFont(ofSize: 15))
    
    //MARK:- Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
        setupProperties()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- Setup
    private func setupLayout() {
        
        iconImageView.constrainWidth(constant: 24)
        iconImageView.constrainHeight(constant: 24)
        
        layer.masksToBounds = true
        layer.cornerRadius = 4
        
        let stackView = UIStackView(arrangedSubviews: [iconImageView, nameLabel])
        stackView.spacing = 10
        contentView.addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 10, left: 10, bottom: 10, right: 10))
    }
    
    private func setupProperties() {
        backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        iconImageView.image = UIImage(named: "unchecked-box")
        iconImageView.contentMode = .scaleAspectFit
    }
    
    
}
