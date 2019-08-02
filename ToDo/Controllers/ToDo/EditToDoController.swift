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
    let textField = UITextField()
    
    var toDo: ToDoItem?
    
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
        if let toDo = toDo {
            textField.text = toDo.name
            textField.textColor = .white
        }
        
        setupCollectionView()
    }
    
    //MARK:- Setup
    private func setupCollectionView() {
        collectionView.backgroundColor = .white
        collectionView.register(ToDoDatePickerCell.self, forCellWithReuseIdentifier: dateCellId)
        textField.textAlignment = .left
        self.navigationItem.titleView = textField
        
 
    }
    
    //MARK:- Data Source
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: dateCellId, for: indexPath) as! ToDoDatePickerCell
        cell.datePickerTextField.delegate = self
        return cell
    }
    
    //MARK:- Layout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 44)
    }
    
    
   
}


extension EditToDoController: UITextFieldDelegate {
    
}
