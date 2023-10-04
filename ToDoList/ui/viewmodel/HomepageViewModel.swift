//
//  HomepageViewModel.swift
//  ToDoList
//
//  Created by alihizardere on 3.10.2023.
//

import Foundation
import RxSwift

class HomepageViewModel {
    
    var toDoList = BehaviorSubject<[ToDo]>(value: [ToDo]())
    var trepo = ToDoDaoRepository()
    
    init(){
        trepo.copyDatabase()
        toDoList = trepo.toDoList
    }
    
    func search(searchText:String) {
        trepo.search(searchText: searchText)
    }
    func delete(todo_id:Int){
        trepo.delete(todo_id: todo_id)
        trepo.uploadToDo()
    }
    func uploadToDo(){
        trepo.uploadToDo()
    }
}
