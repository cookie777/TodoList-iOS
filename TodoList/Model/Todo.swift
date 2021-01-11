//
//  Todo.swift
//  TodoList
//
//  Created by Takayuki Yamaguchi on 2021-01-07.
//

import Foundation

struct Todo {
    var title: String
    var todoDescription: String
    var priority: Int
    var isCompleted: Bool
    var id : String = UUID().uuidString
    
    static var sampleData:[Todo] = [
        Todo(title: "Clean dishes", todoDescription: "desc", priority: 0, isCompleted: false),
        Todo(title: "Buy soy milk", todoDescription: "desc", priority: 0, isCompleted: true),
        Todo(title: "Sleep well", todoDescription: "desc", priority: 1, isCompleted: true),
        Todo(title: "Buy banana🍌", todoDescription: "desc", priority: 1, isCompleted: false),
        Todo(title: "Eat slowly", todoDescription: "desc", priority: 2, isCompleted: false)
    ]
    

}
