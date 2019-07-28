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
    let iconLabel = UILabel(text: "+", font: .systemFont(ofSize: 30) )
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
        
        iconLabel.textColor = .white
        
        textField.attributedPlaceholder = NSAttributedString(string: "Add a ToDo ...",
                                                             attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)])
        textField.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        textField.textAlignment = .left
        textField.returnKeyType = UIReturnKeyType.next
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        textField.keyboardType = UIKeyboardType.default
        
        
        containerView.layer.masksToBounds = true
        containerView.layer.cornerRadius = 4
        containerView.backgroundColor = #colorLiteral(red: 0.05098039216, green: 0.2, blue: 0.2509803922, alpha: 1)
        
        self.backgroundView = UIView(frame: self.bounds)
        self.backgroundView?.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
    }
    
}
