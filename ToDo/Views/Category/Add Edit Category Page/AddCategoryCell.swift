//
//  AddCategoryCell.swift
//  ToDo
//
//  Created by Jony Tucci on 7/26/19.
//  Copyright © 2019 Jony Tucci. All rights reserved.
//

import UIKit

class AddCategoryCell: UICollectionViewCell {
    
    //MARK:- Properties
    let iconImageView: UIImageView = UIImageView(cornerRadius: 8)
    let textField = UITextField()
    
    //MARK:- Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        // UI Setup
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
        let stackView = UIStackView(arrangedSubviews: [iconImageView, textField])
        stackView.spacing = 10
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 10, left: 10, bottom: 10, right: 10))
    }
    
    private func setupProperties() {
        iconImageView.image = UIImage.ToDo.listIcon
        iconImageView.contentMode = .scaleAspectFit
        
        textField.attributedPlaceholder = NSAttributedString(string: "List Name...",
                                                             attributes: [NSAttributedString.Key.foregroundColor: UIColor.ToDo.darkTextColor])
        textField.textAlignment = .left
        textField.returnKeyType = UIReturnKeyType.done
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        textField.keyboardType = UIKeyboardType.default
        
        backgroundColor = UIColor.ToDo.lightBackground
    }
}
