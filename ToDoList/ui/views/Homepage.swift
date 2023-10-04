//
//  ViewController.swift
//  ToDoList
//
//  Created by alihizardere on 2.10.2023.
//

import UIKit
import RxSwift

class Homepage: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    var viewModel = HomepageViewModel()
    
    var toDoList = [ToDo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        
        _ = viewModel.toDoList.subscribe(onNext: { list in
            self.toDoList = list
            self.tableView.reloadData()
        })
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetail"{
            if let todo = sender as? ToDo{
                let destinationVC = segue.destination as! UpdateToDo
                destinationVC.todo = todo
            }
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        viewModel.uploadToDo()
    }
    
}
extension Homepage: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.search(searchText: searchText)
    }
}

extension Homepage: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let todo = toDoList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "toDoCell") as! ToDoCell
        cell.labelToDo.text = todo.todo_name
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let todo = toDoList[indexPath.row]
        performSegue(withIdentifier: "toDetail" , sender: todo )
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Sil"){contextualAction, view, bool in
        
            let todo = self.toDoList[indexPath.row]
            
            let alertController = UIAlertController(title: "Silme İşlemi", message: " silinsin mi?", preferredStyle: .alert)
            
            let cancelAction = UIAlertAction(title: "İptal", style: .cancel)
            alertController.addAction(cancelAction)
            
            let yesAction = UIAlertAction(title: "Evet", style: .destructive){action in
                self.viewModel.delete(todo_id: todo.todo_id!)
            }
            alertController.addAction(yesAction)
            
            self.present(alertController, animated: true)
        }
        return UISwipeActionsConfiguration(actions: [delete])
        
    }
    
    
}
