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
    let nameLabel = UILabel(text: "ToDo Item", font: UIFont.ToDo.cellTitleText)
    let dueDateLabel = UILabel(text: "", font: UIFont.ToDo.cellDetailText)
    
    private var coord: CGPoint = .zero
    
    var toDoItem: ToDoItem! {
        didSet {
            nameLabel.text = toDoItem.name
            dueDateLabel.text = toDoItem.formattedDueDate
            iconImageView.image = toDoItem.isCompleted ? UIImage.ToDo.checkedBox : UIImage.ToDo.uncheckedBox
        }
    }
    
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
        iconImageView.isUserInteractionEnabled = true
        
        let contentStackView = UIStackView(arrangedSubviews: [nameLabel, dueDateLabel])
        contentStackView.axis = .vertical
        
        let containerView = UIView()
        containerView.backgroundColor = UIColor.ToDo.lightCellBackgroundColor
        containerView.layer.masksToBounds = true
        containerView.layer.cornerRadius = 4
        
        let stackView = UIStackView(arrangedSubviews: [iconImageView, contentStackView])
        stackView.spacing = 10
        containerView.addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 10, left: 10, bottom: 10, right: 10))
        
        contentView.addSubview(containerView)
        contentView.backgroundColor = .clear
        containerView.fillSuperview(padding: .init(top: 2, left: 10, bottom: 0, right: 10))
        

    }
    
    private func setupProperties() {
        backgroundColor = .clear
        
        iconImageView.image = UIImage.ToDo.uncheckedBox
        iconImageView.contentMode = .scaleAspectFit
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
    }
}

