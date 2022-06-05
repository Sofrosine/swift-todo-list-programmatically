//
//  TodoService.swift
//  todo-app-swift-programmatically
//
//  Created by Soultan Muhammad Albar on 02/06/22.
//

import Foundation

final class TodosService {
    static let shared = TodosService()
    
    private var todos: [Todo] = []
    
    private init() {}
    
    func addTodo(title: String, date: Date) {
        self.todos.append(Todo(name: title, date: date))
        UserDefaults.standard.todos = self.todos
    }
    
    func getTodos() -> [Todo] {
        self.todos = UserDefaults.standard.todos ?? []
        return todos
    }
    
    func updateTodo(todosParam: [Todo]) {
        self.todos = todosParam
        UserDefaults.standard.todos = self.todos
    }
    
}
