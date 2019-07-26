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
    
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var name = ""
    @objc dynamic var isCompleted = false
    @objc dynamic var dateCreated = Date()
    var parentCategory = LinkingObjects(fromType: Category.self, property: "toDoItems")
    
    override static func primaryKey() -> String {
        return ToDoItem.Property.id.rawValue
    }
    
    convenience init(_ name: String) {
        self.init()
        self.name = name
    }
}

// MARK: - CRUD methods

extension ToDoItem {
    
    static func all(in realm: Realm = try! Realm()) -> Results<ToDoItem> {
        return realm.objects(ToDoItem.self)
            .sorted(byKeyPath: ToDoItem.Property.isCompleted.rawValue)
    }
    
    @discardableResult
    static func add(text: String, in realm: Realm = try! Realm()) -> ToDoItem {
        let item = ToDoItem(text)
        try! realm.write {
            realm.add(item)
        }
        return item
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

