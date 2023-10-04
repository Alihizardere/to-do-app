//
//  ToDoDaoRepository.swift
//  ToDoList
//
//  Created by alihizardere on 3.10.2023.
//

import Foundation
import RxSwift

class ToDoDaoRepository {
    
    var toDoList = BehaviorSubject<[ToDo]>(value: [ToDo]())
    let db:FMDatabase?
    
    init(){
        let targetPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let databaseURL = URL(fileURLWithPath: targetPath).appendingPathComponent("todo.sqlite")
        
        db = FMDatabase(path: databaseURL.path)
    }
    
    func save(todo_name:String){
        db?.open()
        do{
            try db!.executeUpdate("INSERT INTO todo (todo_name) VALUES (?)", values: [todo_name])
        }catch{
            print(error.localizedDescription)
        }
        db?.close()
    }
    
    func update(todo_id:Int, todo_name:String ) {
        
        db?.open()
        do{
            try db!.executeUpdate("UPDATE todo SET todo_name=? WHERE todo_id=?", values: [todo_name,todo_id])
        }catch{
            print(error.localizedDescription)
        }
        db?.close()
    }
    
    func search(searchText:String) {
       
        db?.open()
        var list = [ToDo]()
        
        do{
            let rs = try db!.executeQuery("SELECT * FROM todo WHERE todo_name like '%\(searchText)%'", values: nil)
           
            while rs.next(){
                let todo_id = Int(rs.string(forColumn: "todo_id"))!
                let todo_name = rs.string(forColumn: "todo_name")!
                
                let todo = ToDo(todo_id: todo_id, todo_name: todo_name)
                list.append(todo)
            }
            toDoList.onNext(list)
            
        }catch{
            print(error.localizedDescription)
        }
        db?.close()
        
    }
    
    func delete(todo_id:Int){
        
        db?.open()
        do{
            try db!.executeUpdate("DELETE FROM todo WHERE todo_id=?", values: [todo_id])
        }catch{
            print(error.localizedDescription)
        }
        db?.close()
    }
    
    func uploadToDo(){
        
        db?.open()
        var list = [ToDo]()
        
        do{
            let rs = try db!.executeQuery("SELECT * FROM todo", values: nil)
            
            while rs.next(){
                let todo_id = Int(rs.string(forColumn: "todo_id"))!
                let todo_name = rs.string(forColumn: "todo_name")!
                
                let todo = ToDo(todo_id: todo_id, todo_name: todo_name)
                list.append(todo)
            }
            toDoList.onNext(list)
            
        }catch{
            print(error.localizedDescription)
        }
        db?.close()
        
       
    }
    func copyDatabase(){
            let bundlePath = Bundle.main.path(forResource: "todo", ofType: ".sqlite")
            let targetPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
            let copyLocation = URL(fileURLWithPath: targetPath).appendingPathComponent("todo.sqlite")
            let fileManager = FileManager.default
            if fileManager.fileExists(atPath: copyLocation.path){
                print("Veritabanı zaten var")
            }else{
                do{
                    try fileManager.copyItem(atPath: bundlePath!, toPath: copyLocation.path)
                }catch{}
            }
        }
}
