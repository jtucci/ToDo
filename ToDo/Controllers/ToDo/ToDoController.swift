//
//  ToDoController.swift
//  ToDo
//
//  Created by Jony Tucci on 7/28/19.
//  Copyright © 2019 Jony Tucci. All rights reserved.
//

import UIKit
import RealmSwift
import SwipeCellKit

class ToDoController: UITableViewController {
    
    //MARK:- Properties
    
    // Cell Id's
    fileprivate let cellId = "toDoCell"
    fileprivate let headerCellId = "headerCell"
    
    // Used to keep track of which cell has an open SwipeAction
    var swipedIndex: IndexPath?
    
    // Data Source
    private var toDoTasks: Results<ToDoItem>?
    private var categoryToken: NotificationToken?
    
    var parentCategory : Category!{
        didSet{
            toDoTasks = parentCategory?.allTasks()
        }
    }
    
    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupTableView()
        addBackgroundGradient()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        categoryToken = toDoTasks?.observe { [weak self] changes in
            
            switch changes {
            case .initial:
                self?.tableView.reloadData()
            case .update(_, let deletions, let insertions, let updates):
                self?.tableView.applyChanges(deletions: deletions, insertions: insertions, updates: updates)
            case .error: break
            }
        }
    }
    
    //MARK:- Actions
    // Hides keyboard
    @objc func handleDoneTapped(_ sender: UITextField) {
        self.view.endEditing(true)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.edit, target: self, action: #selector(handleEditTapped))
    }
    
    @objc func handleEditTapped(_ sender: UITextField) {
        tableView.setEditing(!tableView.isEditing, animated: true)
    }
    
    @objc func handleTappedItem(sender: UITapGestureRecognizer) {
        let point = (sender.view?.convert(CGPoint.zero, to: tableView))!
        guard let indexPath = tableView.indexPathForRow(at: point) else { return }
        let toDoItem = toDoTasks?[indexPath.item]
        toDoItem?.toggleCompleted()
    }
    
    
    //MARK:- Setup
    private func setupTableView() {
        tableView.register(ToDoHeaderCell.self, forHeaderFooterViewReuseIdentifier: headerCellId)
        tableView.register(ToDoCell.self, forCellReuseIdentifier: cellId)
        tableView.backgroundColor = UIColor.clear
        tableView.separatorStyle = .none
        tableView.allowsMultipleSelectionDuringEditing = true
        
    }
    
    private func setupNavBar() {
        navigationController?.navigationBar.tintColor = UIColor.ToDo.lightTextColor
        navigationController?.navigationBar.barTintColor = UIColor.ToDo.navBarColor
        navigationController?.navigationBar.barStyle = .black
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.edit, target: self, action: #selector(handleEditTapped))
    }
    
    private func addBackgroundGradient() {
        let collectionViewBackgroundView = UIView()
        let gradientLayer = CAGradientLayer()
        
        gradientLayer.frame.size = view.frame.size
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.3)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.colors = [UIColor.ToDo.backgroundGradientDark.cgColor, UIColor.ToDo.backgroundGradientLight.cgColor]
        
        tableView.backgroundView = collectionViewBackgroundView
        tableView.backgroundView?.layer.addSublayer(gradientLayer)
    }
    
    //MARK:- Tableview Delegate Methods
    
    //MARK: Data Source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoTasks?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ToDoCell
        let toDo = toDoTasks![indexPath.row]
        let tapped: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTappedItem))
        
        cell.toDoItem = toDo
        cell.iconImageView.addGestureRecognizer(tapped)
        cell.delegate = self
        
        return cell
    }
    
    //Header Cell
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerCell = ToDoHeaderCell()
        headerCell.textField.delegate = self
        return headerCell
    }
    
    //MARK: Edit
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
    }
    
  
    //MARK: Selection
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let editToDoVC = EditToDoController()
        editToDoVC.toDo = toDoTasks?[indexPath.row]
        navigationController?.pushViewController(editToDoVC, animated: true)
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

//MARK:- Text field Delegate methods
extension ToDoController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let newTaskName = textField.text else { return false}
        if newTaskName != "" {
            parentCategory.addToDo(name: newTaskName)
        }
        textField.text = ""
        
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(handleDoneTapped))
        if let index = swipedIndex {
            let cell = tableView.cellForRow(at: index) as! SwipeTableViewCell
            cell.hideSwipe(animated: true)
            swipedIndex = nil
        }
    }
}


//MARK:- SwipeCell Delegate Methods
extension ToDoController: SwipeTableViewCellDelegate {
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        
        guard orientation == .right else { return nil }
        
        let deleteAction = SwipeAction(style: .default , title: nil) { (action, indexPath) in
            if let task = self.toDoTasks?[indexPath.row] {
                task.delete()
                //Dismiss swipe
                action.hidesWhenSelected = true
                self.swipedIndex = nil
            }
        }
        
        let editAction = SwipeAction(style: .default, title: nil) { action, indexPath in
            
            // Dismiss swipe
            action.hidesWhenSelected = true
            self.swipedIndex = nil
            
        }
        
        // customize the action appearance
        deleteAction.image = UIImage.ToDo.trash.resizedImage(newSize: CGSize(width: 28  , height: 28))
        deleteAction.backgroundColor = UIColor.ToDo.deleteSwipeBackgroundColor
        
        editAction.image = UIImage.ToDo.settings.resizedImage(newSize: CGSize(width: 28 , height: 28))
        editAction.backgroundColor = UIColor.ToDo.editSwipeBackgroundColor
        
        return [deleteAction, editAction]
        
    }
    
    // Used to ensure swiped cell is dismissed when transitioning to new scene
    func collectionView(_ collectionView: UICollectionView, willBeginEditingItemAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) {
        swipedIndex = indexPath
    }
    
    
}
