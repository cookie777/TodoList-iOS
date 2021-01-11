//
//  TodoData.swift
//  TodoList
//
//  Created by Takayuki Yamaguchi on 2021-01-07.
//

import Foundation


let todoCell = "todoCell"

struct Symbol {
    static var checked = "✓"
    static var unChecked = " "
}

struct PriorityTitle {
    static var First = "High"
    static var Second = "Medium"
    static var Third = "Low"
}

enum CellType {
    case textField, segmentControl, date
}
