//
//  Category.swift
//  ToDo
//
//  Created by Jony Tucci on 7/26/19.
//  Copyright © 2019 Jony Tucci. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    
    enum Property: String {
        case id, name
    }
    
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var name = ""
    
    var numberOfItems: Int {
        return toDoItems.count
    }
    
    let toDoItems = List<ToDoItem>()
    
    convenience init(_ name: String) {
        self.init()
        self.name = name
    }
    
}

//MARK: - CRUD

extension Category {
    // Gets all tasks
    static func all(in realm: Realm = try! Realm()) -> Results<Category> {
        return realm.objects(Category.self)
    }
    
    // Gets all tasks associated with current category
    func allTasks(in realm: Realm = try! Realm()) -> Results<ToDoItem> {
        let predicate = NSPredicate(format: "id == %@", self.id)
        return realm.objects(ToDoItem.self).filter(predicate).sorted(byKeyPath: "isCompleted")
    }
    
    @discardableResult
    static func add(name: String, in realm: Realm = try! Realm()) -> Category {
        let category = Category(name)
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("Error adding category: \(error)")
        }
        
        return category
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
    
    func addToDo(name: String, in realm: Realm = try! Realm()){
        do {
            try realm.write {
                let newTodo = ToDoItem(name)
                newTodo.id = id
                toDoItems.append(newTodo)
            }
        }catch{
            print("Error adding Task: \(error)")
        }
    }
    
    
    func delete() {
        guard let realm = realm else { return }
        try! realm.write {
            realm.delete(self)
        }
    }
}

