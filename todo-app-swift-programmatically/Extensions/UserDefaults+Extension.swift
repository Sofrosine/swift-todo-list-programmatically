//
//  UserDefaults+Extension.swift
//  todo-app-swift-programmatically
//
//  Created by Soultan Muhammad Albar on 04/06/22.
//

import Foundation

extension UserDefaults {
    private enum UserDefaultsKey: String {
        case todos
    }
    
    var todos: [Todo]? {
        get {
            if let data = object(forKey: UserDefaultsKey.todos.rawValue) as? Data {
                let todoList = try? JSONDecoder().decode([Todo].self, from: data)
                return todoList
            }
            return nil
        }
        
        set {
            if newValue == nil {
                removeObject(forKey: UserDefaultsKey.todos.rawValue)
            } else {
                let data = try? JSONEncoder().encode(newValue)
                setValue(data, forKey: UserDefaultsKey.todos.rawValue)
            }
        }
    }
}
