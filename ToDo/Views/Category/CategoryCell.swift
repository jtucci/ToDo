//
//  CategoryCell.swift
//  ToDo
//
//  Created by Jony Tucci on 7/26/19.
//  Copyright © 2019 Jony Tucci. All rights reserved.
//

import UIKit
import SwipeCellKit

class CategoryCell: SwipeTableViewCell {
    
    //MARK:- Properties
    let iconImageView: UIImageView = UIImageView(cornerRadius: 8)
    let categoryLabel = UILabel(text: "Category Name", font: UIFont.ToDo.cellTitleText)
    let itemCountLabel = UILabel(text: "0", font: UIFont.ToDo.cellDetailText)
    
    var category: Category!{
        didSet{
            categoryLabel.text = category.name
            itemCountLabel.text = String(category.numberOfItems)
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
        let stackView = UIStackView(arrangedSubviews: [iconImageView, categoryLabel, itemCountLabel])
        stackView.spacing = 10
        contentView.addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 10, left: 10, bottom: 10, right: 10))
    }
    
    private func setupProperties() {
        iconImageView.image = UIImage.ToDo.listIcon
        iconImageView.contentMode = .scaleAspectFit
    }
    

}
