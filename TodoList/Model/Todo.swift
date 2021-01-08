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
}
