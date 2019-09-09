//
//  EditToDoTableController.swift
//  ToDo
//
//  Created by Jony Tucci on 9/9/19.
//  Copyright © 2019 Jony Tucci. All rights reserved.
//

import UIKit

class EditToDoTableController: UITableViewController {
  
    //UI
    let nameTextField = UITextField()
    var date: UIDatePicker?
    var dateTextField: UITextField?
    
    var toDo: ToDoItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
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
    private func setupTableView() {
        tableView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        tableView.tableFooterView = UIView() // Removes horizontal lines in table
        tableView.keyboardDismissMode = .interactive // Allows dragging to interact with keyboard
    }
    
    //MARK:- TableView Delegate Methods
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 1 {
            let cell = ToDoDatePickerTableCell(style: .default, reuseIdentifier: nil)
            cell.datePickerTextField.delegate = self
            cell.datePickerTextField.text = toDo.formattedDueDate
            date = cell.datePicker
            dateTextField = cell.datePickerTextField
            return cell
        }
        let cell = SettingsCell(style: .default, reuseIdentifier: nil)
        
        switch indexPath.section {
        case 0:
            cell.textField.placeholder = "Enter Name"
            cell.textField.text = toDo.name
            //cell.textField.addTarget(self, action: #selector(handleNameChanged), for: .editingChanged)
        default:
            cell.textField.placeholder = "Add Notes.."
           // cell.textField.text = toDo.notes
            //cell.textField.addTarget(self, action: #selector(AddNotes), for: .editingChanged)

        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    //MARK: Header
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
              
        let headerLabel = HeaderLabel()
        
        switch section {
        case 0:
            headerLabel.text = "Name"
        case 1:
            headerLabel.text = "Due Date"
        default:
            headerLabel.text = "Notes"
        }
        headerLabel.font = .boldSystemFont(ofSize: 16)
        return headerLabel
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
}


extension EditToDoTableController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
}

class HeaderLabel: UILabel {
    override func draw(_ rect: CGRect) {
        super.drawText(in: rect.insetBy(dx: 16, dy: 0))
    }
}
