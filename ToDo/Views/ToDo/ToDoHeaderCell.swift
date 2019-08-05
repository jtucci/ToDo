//
//  ToDoHeaderCell.swift
//  ToDo
//
//  Created by Jony Tucci on 7/28/19.
//  Copyright © 2019 Jony Tucci. All rights reserved.
//

import UIKit

final class ToDoHeaderCell: UITableViewHeaderFooterView {
    
    //MARK:- Properties
    let iconLabel = UILabel(text: "＋", font: UIFont.ToDo.largeText )
    let textField = UITextField()
    let containerView = UIView()
    
    //MARK:- Initialization
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupProperties()
        setupLayout()
        

    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout(){
        backgroundColor = .clear
        
        iconLabel.constrainHeight(constant: 40)
        iconLabel.constrainWidth(constant: 20)
        addSubview(containerView)
        containerView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 10, left: 8, bottom: 5, right: 8))
        
        let stackView = UIStackView(arrangedSubviews: [iconLabel, textField])
        stackView.spacing = 5
        containerView.addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 5, left: 5, bottom: 5, right: 5))
    }
    
    private func setupProperties(){
        
        iconLabel.textColor = UIColor.ToDo.darkTextColor
        
        textField.attributedPlaceholder = NSAttributedString(string: "Add a ToDo ...",
                                                             attributes: [NSAttributedString.Key.foregroundColor: UIColor.ToDo.darkTextColor])
        textField.textColor = UIColor.ToDo.darkTextColor
        textField.textAlignment = .left
        textField.returnKeyType = UIReturnKeyType.next
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        textField.keyboardType = UIKeyboardType.default
        
        
        containerView.layer.masksToBounds = true
        containerView.layer.cornerRadius = 4
        containerView.backgroundColor = UIColor.ToDo.darkCellBackGroundColor
        
   
        
        self.backgroundView = UIView(frame: self.bounds)
        self.backgroundView?.backgroundColor = UIColor(white: 0.5, alpha: 0.0)
        
        //contentView.backgroundColor = .clear
        //backgroundView?.backgroundColor = .clear
    }
    
}
