//
//  ToDoItem.swift
//  ToDo
//
//  Created by Jony Tucci on 7/26/19.
//  Copyright © 2019 Jony Tucci. All rights reserved.
//

import Foundation
import RealmSwift

class ToDoItem: Object {
    
    enum Property: String {
        case id, text, isCompleted
    }
    
    @objc dynamic var id = ""
    @objc dynamic var name = ""
    @objc dynamic var isCompleted = false
    @objc dynamic var dateCreated = Date()
    @objc dynamic var dueDate: Date?
    
    let dateFormatter: DateFormatter = {
       var dateFormatter = DateFormatter()
       dateFormatter.dateStyle = .medium
       return dateFormatter
    }()
    
    var formattedDueDate: String {
        get {
            if let date = dueDate{
                return "Due \(dateFormatter.string(from: date))"
            } else {
                return ""
            }
            
        }
    }
    
    var parentCategory = LinkingObjects(fromType: Category.self, property: "toDoItems")
    
    
    convenience init(_ name: String) {
        self.init()
        self.name = name
        
    }
}

// MARK: - CRUD methods
extension ToDoItem {
    
    static func all(in realm: Realm = try! Realm()) -> Results<ToDoItem> {
        return realm.objects(ToDoItem.self)
    }
    
    
    @discardableResult
    static func add(text: String, in realm: Realm = try! Realm()) -> ToDoItem {
        let item = ToDoItem(text)
        try! realm.write {
            realm.add(item)
        }
        return item
    }
    
    func update(name: String, date: Date? = nil, in realm: Realm = try! Realm()) {
        
        do {
            try realm.write {
                self.dueDate = date
                self.name = name
            }
        } catch {
            print("Error updating category: \(error)")
        }
    }
    
    func update(name: String, in realm: Realm = try! Realm()) {
        
        do {
            try realm.write {
                self.name = name
            }
        } catch {
            print("Error updating category: \(error)")
        }
    }
    
    func update(date: Date?, in realm: Realm = try! Realm()) {
        
        do {
            try realm.write {
                self.dueDate = date
          
            }
        } catch {
            print("Error updating category: \(error)")
        }
    }
    
    
    
    
    func toggleCompleted() {
        guard let realm = realm else { return }
        try! realm.write {
            isCompleted = !isCompleted
        }
    }
    
    
    func delete() {
        guard let realm = realm else { return }
        try! realm.write {
            realm.delete(self)
        }
    }
}
