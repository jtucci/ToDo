//
//  EditToDoController.swift
//  ToDo
//
//  Created by Jony Tucci on 8/2/19.
//  Copyright © 2019 Jony Tucci. All rights reserved.
//

import UIKit

class EditToDoController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    //MARK:- Properties
    fileprivate let dateCellId = "datePickerCellId"
    
    //UI
    let nameTextField = UITextField()
    var date: UIDatePicker?
    var dateTextField: UITextField?
    
    var toDo: ToDoItem! {
        didSet{
            nameTextField.text = toDo.name
            nameTextField.textColor = .white
            nameTextField.delegate = self
            nameTextField.constrainWidth(constant: view.frame.size.width - 100)
            self.navigationItem.titleView = nameTextField
            nameTextField.becomeFirstResponder()
        }
        
    }
    
    //MARK:- Initialization
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if nameTextField.text != "" {
            let newName = nameTextField.text!
            if dateTextField?.text == "" {
                date = nil
            }
            toDo?.update(name: newName, date: date?.date)
        }
        
    }
    
    //MARK:- Setup
    private func setupCollectionView() {
        collectionView.backgroundColor = .white
        collectionView.register(ToDoDatePickerCell.self, forCellWithReuseIdentifier: dateCellId)
    }
    
    //MARK:- Data Source
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: dateCellId, for: indexPath) as! ToDoDatePickerCell
        cell.datePickerTextField.delegate = self
        cell.datePickerTextField.text = toDo.formattedDueDate
        date = cell.datePicker
        dateTextField = cell.datePickerTextField
        return cell
    }
    
    //MARK:- Layout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 44)
    }
    
    
   
}


extension EditToDoController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    


}


