//
//  CategoryController.swift
//  ToDo
//
//  Created by Jony Tucci on 7/26/19.
//  Copyright © 2019 Jony Tucci. All rights reserved.
//

import UIKit
import RealmSwift
import SwipeCellKit

struct CategoryConstants {
    
    static let categoryCellHeight: CGFloat = 60
    static let footerCellWidth: CGFloat = 60
    static let footerCellHeight: CGFloat = 50
    static let cellSpacing: CGFloat = 0
    
}

class CategoryController: UITableViewController {
    
    //MARK:- Properties
    // Cell ID's
    fileprivate let cellId = "categoryCell"
    fileprivate let footerCellID = "footerCellId"
    
    // Data Objects
    private var categories: Results<Category>?
    private var categoriesToken: NotificationToken?
    
    // UI Elements
    var addButton = CircleButton()
    
    // Used to track index of cell with Swipe Options opened so it can be closed when transitioning to new view
    var swipedIndex: IndexPath?
    
    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupNavBar()
        setupButton()
        categories = Category.all()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        categoriesToken = categories?.observe { [weak tableView] changes in
            guard let tableView = tableView else { return }
            
            switch changes {
            case .initial:
                tableView.reloadData()
            case .update(_, let deletions, let insertions, let updates):
                tableView.applyChanges(deletions: deletions, insertions: insertions, updates: updates)
            case .error: break
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        categoriesToken?.invalidate()
    }
    
    //MARK:- Setup
    private func setupTableView() {
        tableView.register(CategoryCell.self, forCellReuseIdentifier: cellId)
        tableView.register(CategoryFooterCell.self, forHeaderFooterViewReuseIdentifier: footerCellID)
        tableView.separatorStyle = .none
        
    }
    
    private func setupNavBar() {
        navigationController?.navigationBar.barTintColor = UIColor.ToDo.navBarColor
        navigationController?.navigationBar.barStyle = .black
    }
    
    private func setupButton() {
        // Constraints
        view.addSubview(addButton)
        addButton.constrainHeight(constant: 50)
        addButton.constrainWidth(constant: 50)
        addButton.centerXInSuperview()
        addButton.anchor(top: nil, leading: nil, bottom: tableView.safeAreaLayoutGuide.bottomAnchor, trailing: nil)
        
        // Actions
        addButton.addTarget(self, action: #selector(handleAddButtonTapped), for: .touchUpInside)
    }
    
    //MARK:- Actions
    @objc func handleAddButtonTapped() {
        addButton.pulsate()
    }
    
    //Add new list
    @objc func handleCreateListTapped() {
        // Checks if a cell has been swiped if swipe options (delete, edit) are visible it will dismiss them
        if let index = swipedIndex {
            let cell = tableView.cellForRow(at: index) as! SwipeTableViewCell
            cell.hideSwipe(animated: true)
            swipedIndex = nil
        }
        let navController = UINavigationController(rootViewController: AddCategoryController())
        navigationController?.present(navController, animated: true)
    }
    
    
    //MARK:- TableView Delegate Methods
    
    //MARK: Data Source
    // Standard Cell
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! CategoryCell
        let category = categories?[indexPath.row]
        cell.delegate = self
        cell.category = category
        return cell
    }
    
    // Footer
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = CategoryFooterCell()
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleCreateListTapped))
        footerView.addGestureRecognizer(tapRecognizer)
        return footerView
    }
    
    //MARK: Layout
    // Standard Cell
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CategoryConstants.categoryCellHeight
    }
    
    // Footer
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CategoryConstants.footerCellHeight
    }
    
    // Footer Configuration
    override func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        if let footer = view as? UITableViewHeaderFooterView{
            footer.backgroundView?.backgroundColor = UIColor.ToDo.lightCellBackgroundColor        }
    }
    
    //MARK: Selection
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let toDoViewController = ToDoController()
        toDoViewController.parentCategory = categories?[indexPath.item]
        navigationController?.pushViewController(toDoViewController, animated: true)
    }
}



//MARK:- SwipeCellKit Delegate
extension CategoryController: SwipeTableViewCellDelegate {
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }
        
        let deleteAction = SwipeAction(style: .default , title: nil) { (action, indexPath) in
            if let category = self.categories?[indexPath.item] {
                category.delete()
                //Dismiss swipe
                action.hidesWhenSelected = true
                self.swipedIndex = nil
            }
        }
        
        let editAction = SwipeAction(style: .default, title: nil) { action, indexPath in
            // handle action by updating model with deletion
            let vc = AddCategoryController()
            vc.editedCategory = self.categories?[indexPath.item]
            let navController = UINavigationController(rootViewController: vc)
            // Dismiss swipe
            action.hidesWhenSelected = true
            self.swipedIndex = nil
            self.navigationController?.present(navController, animated: true)
        }
        
        // customize the action appearance
        deleteAction.image = UIImage.ToDo.trash.resizedImage(newSize: CGSize(width: 28  , height: 28))
        deleteAction.backgroundColor = UIColor.ToDo.deleteSwipeBackgroundColor
        
        editAction.image = UIImage.ToDo.settings.resizedImage(newSize: CGSize(width: 28 , height: 28))
        editAction.backgroundColor = UIColor.ToDo.editSwipeBackgroundColor
        
        return [deleteAction, editAction]
    }

    // Used to ensure swiped cell is dismissed when transitioning to new scene
    func tableView(_ tableView: UITableView, willBeginEditingRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) {
            swipedIndex = indexPath
    }

}
