//
//  CategoryController.swift
//  ToDo
//
//  Created by Jony Tucci on 7/26/19.
//  Copyright © 2019 Jony Tucci. All rights reserved.
//

import UIKit
import RealmSwift

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
    }
    
    private func setupNavBar() {
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.07201969673, green: 0.2897559313, blue: 0.3654557808, alpha: 1)
        navigationController?.navigationBar.barStyle = .black
    }
    
    private func setupButton() {
        // Constraints
        view.addSubview(addButton)
        addButton.constrainHeight(constant: 50)
        addButton.constrainWidth(constant: 50)
        addButton.centerXInSuperview()
        addButton.anchor(top: nil, leading: nil, bottom: view.bottomAnchor, trailing: nil, padding: .init(top: 0, left: 0, bottom: 20, right: 0))
        
        // Actions
        addButton.addTarget(self, action: #selector(handleAddButtonTapped), for: .touchUpInside)
    }
    
    //MARK:- Actions
    @objc func handleAddButtonTapped() {
        addButton.pulsate()
    }
    
    //Add new list
    @objc func handleCreateListTapped() {
        let navController = UINavigationController(rootViewController: AddCategoryController())
        navigationController?.present(navController, animated: true)
    }
    //MARK:- Data Source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! CategoryCell
        if let category = categories?[indexPath.row] {
            cell.categoryLabel.text = category.name
            cell.itemCountLabel.text = String(category.toDoItems.count)
        }
        return cell
    }
    
    // Layout
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CategoryConstants.categoryCellHeight
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = CategoryFooterCell()
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleCreateListTapped))
        footerView.addGestureRecognizer(tapRecognizer)
        return footerView
        

    }
    
}
