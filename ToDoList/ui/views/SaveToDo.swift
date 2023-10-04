//
//  SaveToDo.swift
//  ToDoList
//
//  Created by alihizardere on 2.10.2023.
//

import UIKit

class SaveToDo: UIViewController {

    @IBOutlet weak var tfToDo: UITextField!
    var viewModel = SaveToDoViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    @IBAction func buttonSave(_ sender: Any) {
        if let name = tfToDo.text {
            viewModel.save(todo_name: name)
        }
    }
    
    
    

}
