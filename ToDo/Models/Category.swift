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
        case id, text, isCompleted
    }
    
    @objc dynamic var name = ""
    let toDoItems = List<ToDoItem>()
    
    convenience init(_ name: String) {
        self.init()
        self.name = name
    }
    
}

// MARK: - CRUD methods

extension Category {
    
    static func all(in realm: Realm = try! Realm()) -> Results<Category> {
        return realm.objects(Category.self)
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
}
//
//    @discardableResult
//    static func add(text: String, in realm: Realm = try! Realm()) -> ToDoItem {
//        let item = ToDoItem(text)
//        try! realm.write {
//            realm.add(item)
//        }
//        return item
//    }
//
//    func toggleCompleted() {
//        guard let realm = realm else { return }
//        try! realm.write {
//            isCompleted = !isCompleted
//        }
//    }
//
//    func delete() {
//        guard let realm = realm else { return }
//        try! realm.write {
//            realm.delete(self)
//        }
//    }
//}



