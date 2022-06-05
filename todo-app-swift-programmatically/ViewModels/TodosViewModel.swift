//
//  TodoViewModels.swift
//  todo-app-swift-programmatically
//
//  Created by Soultan Muhammad Albar on 01/06/22.
//

import Foundation

class TodoViewModel {
    var todos: ObservableObject<[Todo]?> = ObservableObject([])
    
    func getTodos() -> [Todo] {
        let todoList = TodosService.shared.getTodos()
        self.todos.value = todoList;
        return todoList
    }
    
    func addTodo(title: String, date: Date) {
        TodosService.shared.addTodo(title: title, date: Date.now)
    }
    
    func updateTodo(todosParam: [Todo]) {
        TodosService.shared.updateTodo(todosParam: todosParam)
    }
}
