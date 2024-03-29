//
//  AddCategoryController.swift
//  ToDo
//
//  Created by Jony Tucci on 7/26/19.
//  Copyright © 2019 Jony Tucci. All rights reserved.
//

import UIKit
import RealmSwift
class AddCategoryController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    //MARK:- Properties
    fileprivate let cellId = "cellId"
    var newCategoryName = ""
    var textField =  UITextField()
    
    var editedCategory: Category?
    
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
        setupNavBar()
        if let editedCategory = editedCategory {
            textField.text = editedCategory.name
            self.title = "Update List"
        } else {
            self.title = "New List"
        }
        
    }
    
    
    //MARK:- Actions
    @objc func handleSaveTapped() {
        guard let newCategoryName = textField.text else { return }
        
        if editedCategory != nil {
            editedCategory?.update(name: newCategoryName)
        } else {
            Category.add(name: newCategoryName)
        }
        
        dismiss(animated: true)
        
    }
    
    @objc func handleCancelTapped() {
        dismiss(animated: true)
    }
    
    //MARK:- Setup
    private func setupCollectionView() {
        collectionView.backgroundColor = UIColor.ToDo.darkBackground
        collectionView.register(AddCategoryCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    private func setupNavBar() {
        navigationController?.navigationBar.tintColor = UIColor.ToDo.lightTextColor
        navigationController?.navigationBar.barTintColor = UIColor.ToDo.navBarColor
        navigationController?.navigationBar.barStyle = .black
        self.title = "New List"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.save, target: self, action: #selector(handleSaveTapped))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.cancel, target: self, action: #selector(handleCancelTapped))
    }
    
    //MARK:- Data Source
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! AddCategoryCell
        textField = cell.textField
        textField.delegate = self
        textField.becomeFirstResponder()
        //MARK:-  REMOVE - This is sample code to be used later for quick add
        //let bar = UIToolbar()
        //let category = UIBarButtonItem(title: "Test", style: .plain, target: self, action: nil)
        //bar.items = [category]
        //bar.sizeToFit()
        //textField.inputAccessoryView = bar
        // END REMOVE
        if let editedCategory = editedCategory{
            textField.text = editedCategory.name
        }
        return cell
    }
    
    //MARK:- Layout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 44)
    }
    
    
}

//MARK:- Text Field Delegate
extension AddCategoryController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        newCategoryName = textField.text ?? ""
    }
}
