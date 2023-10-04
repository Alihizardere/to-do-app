//
//  UpdateToDo.swift
//  ToDoList
//
//  Created by alihizardere on 2.10.2023.
//

import UIKit

class UpdateToDo: UIViewController {

    @IBOutlet weak var tfToDo: UITextField!
    var viewModel = UpdateToDoViewModel()
    
    var todo:ToDo?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let t = todo {
            tfToDo.text = t.todo_name
        }
    }
    

    @IBAction func buttonUpdate(_ sender: Any) {
        if let name = tfToDo.text, let t = todo {
            viewModel.update(todo_id: t.todo_id!, todo_name: name)
        }
    }
    

}
