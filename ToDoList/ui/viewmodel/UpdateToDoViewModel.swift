//
//  UpdateToDoViewModel.swift
//  ToDoList
//
//  Created by alihizardere on 3.10.2023.
//

import Foundation

class UpdateToDoViewModel {
    
    var trepo = ToDoDaoRepository()
    
    func update(todo_id:Int, todo_name:String ) {
        trepo.update(todo_id: todo_id, todo_name: todo_name)
    }
}
