//
//  ToDoDatePickerCell.swift
//  ToDo
//
//  Created by Jony Tucci on 8/2/19.
//  Copyright © 2019 Jony Tucci. All rights reserved.
//

import UIKit

class ToDoDatePickerCell: UICollectionViewCell {
    
    //MARK:- Properties
    let datePickerTextField = UITextField()
    let datePicker = UIDatePicker()
    let iconImage = UIImageView(image: UIImage(named: "calendar"))
    
    
    //MARK:- Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // UI Setup
        iconImage.constrainWidth(constant: 16)
        iconImage.constrainHeight(constant: 16)
        iconImage.contentMode = .scaleAspectFit
        let tintedImage = iconImage.image?.withRenderingMode(.alwaysTemplate)
        iconImage.image = tintedImage
        iconImage.tintColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        
        
        let stackView = UIStackView(arrangedSubviews: [iconImage, datePickerTextField])
        stackView.spacing = 10
        
        contentView.addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 5, left: 16, bottom: 5, right: 16))
        datePickerTextField.attributedPlaceholder = NSAttributedString(string: "Due Date",
                                                             attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)])
        datePickerTextField.textAlignment = .left
        datePickerTextField.returnKeyType = UIReturnKeyType.done
        datePickerTextField.clearButtonMode = UITextField.ViewMode.whileEditing
        datePickerTextField.keyboardType = UIKeyboardType.default
        
        
        createDatePicker()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- Setup
    private func createDatePicker() {
        datePicker.datePickerMode = .date
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(handleDoneTapped))
        
        let dateLabel = UILabel(text: "Date", font: .systemFont(ofSize: 15))
        let dateButton = UIBarButtonItem(customView: dateLabel)
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handleCancelTapped))
        
        toolBar.setItems([cancelButton, flexSpace, dateButton, flexSpace,doneButton], animated: true)
        datePickerTextField.inputAccessoryView = toolBar
        datePickerTextField.inputView = datePicker
    }
    
    
    @objc func handleDoneTapped(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        
        datePickerTextField.text = "Due \(dateFormatter.string(from: datePicker.date))"
        contentView.endEditing(true)
    }
    
    @objc func handleCancelTapped() {
        contentView.endEditing(true)
    }
}
