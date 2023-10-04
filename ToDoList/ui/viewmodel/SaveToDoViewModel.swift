//
//  SaveToDoViewModel.swift
//  ToDoList
//
//  Created by alihizardere on 3.10.2023.
//

import Foundation

class SaveToDoViewModel {
    
    var trepo = ToDoDaoRepository()
    
    func save(todo_name:String){
        trepo.save(todo_name: todo_name)
    }
}
