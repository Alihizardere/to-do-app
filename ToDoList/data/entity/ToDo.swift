//
//  ToDo.swift
//  ToDoList
//
//  Created by alihizardere on 2.10.2023.
//

import Foundation
class ToDo {
    var todo_id:Int?
    var todo_name:String?
    
    init(todo_id: Int, todo_name: String) {
        self.todo_id = todo_id
        self.todo_name = todo_name
    }
}
