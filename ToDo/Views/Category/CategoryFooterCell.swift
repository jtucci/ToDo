//
//  CategoryFooterCell.swift
//  ToDo
//
//  Created by Jony Tucci on 7/26/19.
//  Copyright © 2019 Jony Tucci. All rights reserved.
//

import UIKit

final class CategoryFooterCell: UITableViewHeaderFooterView {
    //MARK:- Properties
    let iconLabel = UILabel(text: "＋", font: UIFont.ToDo.largeText )
    let titleLabel = UILabel(text: "Create new list", font: UIFont.ToDo.cellTitleText)
    
    //MARK:- Initialization
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupLayout()
        setupProperties()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- Setup
    private func setupLayout() {
        iconLabel.constrainHeight(constant: 24)
        iconLabel.constrainWidth(constant: 24)
        
        let stackView = UIStackView(arrangedSubviews: [iconLabel, titleLabel])
        stackView.spacing = 10
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 5, left: 10, bottom: 5, right: 10))
    }
    
    private func setupProperties() {
        iconLabel.textColor = UIColor.ToDo.systemTextColor
        titleLabel.textColor = UIColor.ToDo.systemTextColor
    }
    
    
}

