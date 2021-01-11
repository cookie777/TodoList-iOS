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
        Todo(
            title: "Buy bagels🥯 at Costco",
            todoDescription: "should be plain, not others",
            priority: 0,
            isCompleted: true
        ),
        Todo(
            title: "Send email✉️ to the bank",
            todoDescription: "about the bonus, I finally fulfilled the conditions",
            priority: 0,
            isCompleted: false
        ),
        Todo(
            title: "Back up to time-machine",
            todoDescription: "don't forget not to save dropbox folder",
            priority: 1,
            isCompleted: true
        ),
        Todo(
            title: "Buy Banana🍌",
            todoDescription: "better to go No-frills. 0.66$/ lb. Cheapest",
            priority: 1,
            isCompleted: false
        ),
        Todo(
            title: "🤩Change phone plan",
            todoDescription: "Send email and change to more cheap plan.",
            priority: 2,
            isCompleted: false
        ),
        Todo(
            title: "Call to my parent",
            todoDescription: "",
            priority: 2,
            isCompleted: false
        ),
        Todo(
            title: "Clean air pod pro",
            todoDescription: "and also exchange ear chip.",
            priority: 2,
            isCompleted: true
        ),
        Todo(
            title: "Dummy Data",
            todoDescription: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. In nisl nisi scelerisque eu. Lectus mauris ultrices eros in..",
            priority: 2,
            isCompleted: false
        ),
        Todo(
            title: "Dummy Data",
            todoDescription: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. In nisl nisi scelerisque eu. Lectus mauris ultrices eros in..",
            priority: 2,
            isCompleted: false
        ),
        Todo(
            title: "Dummy Data",
            todoDescription: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. In nisl nisi scelerisque eu. Lectus mauris ultrices eros in..",
            priority: 2,
            isCompleted: false
        ),
        Todo(
            title: "Dummy Data",
            todoDescription: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. In nisl nisi scelerisque eu. Lectus mauris ultrices eros in..",
            priority: 2,
            isCompleted: false
        ),
        Todo(
            title: "Dummy Data",
            todoDescription: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. In nisl nisi scelerisque eu. Lectus mauris ultrices eros in..",
            priority: 2,
            isCompleted: false
        ),
        Todo(
            title: "Dummy Data",
            todoDescription: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. In nisl nisi scelerisque eu. Lectus mauris ultrices eros in..",
            priority: 2,
            isCompleted: false
        ),
        Todo(
            title: "Dummy Data",
            todoDescription: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. In nisl nisi scelerisque eu. Lectus mauris ultrices eros in..",
            priority: 2,
            isCompleted: false
        ),
        Todo(
            title: "Dummy Data",
            todoDescription: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. In nisl nisi scelerisque eu. Lectus mauris ultrices eros in..",
            priority: 2,
            isCompleted: false
        ),
        Todo(
            title: "Dummy Data",
            todoDescription: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. In nisl nisi scelerisque eu. Lectus mauris ultrices eros in..",
            priority: 2,
            isCompleted: false
        ),
        Todo(
            title: "Dummy Data",
            todoDescription: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. In nisl nisi scelerisque eu. Lectus mauris ultrices eros in..",
            priority: 2,
            isCompleted: false
        ),
        Todo(
            title: "Dummy Data",
            todoDescription: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. In nisl nisi scelerisque eu. Lectus mauris ultrices eros in..",
            priority: 2,
            isCompleted: false
        ),
        Todo(
            title: "Dummy Data",
            todoDescription: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. In nisl nisi scelerisque eu. Lectus mauris ultrices eros in..",
            priority: 2,
            isCompleted: false
        ),
        Todo(
            title: "Dummy Data",
            todoDescription: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. In nisl nisi scelerisque eu. Lectus mauris ultrices eros in..",
            priority: 2,
            isCompleted: false
        ),
        Todo(
            title: "Dummy Data",
            todoDescription: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. In nisl nisi scelerisque eu. Lectus mauris ultrices eros in..",
            priority: 2,
            isCompleted: false
        ),
        Todo(
            title: "Dummy Data",
            todoDescription: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. In nisl nisi scelerisque eu. Lectus mauris ultrices eros in..",
            priority: 2,
            isCompleted: false
        ),
        Todo(
            title: "Dummy Data",
            todoDescription: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. In nisl nisi scelerisque eu. Lectus mauris ultrices eros in..",
            priority: 2,
            isCompleted: false
        ),
        Todo(
            title: "Dummy Data",
            todoDescription: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. In nisl nisi scelerisque eu. Lectus mauris ultrices eros in..",
            priority: 2,
            isCompleted: false
        ),
    ]
    

}
