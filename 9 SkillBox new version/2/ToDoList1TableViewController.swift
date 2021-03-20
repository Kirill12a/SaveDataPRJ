//
//  ToDoList1TableViewController.swift
//  9 SkillBox new version
//
//  Created by Kirill Drozdov on 21.03.2021.
//

import UIKit
import RealmSwift

class ToDoList1TableViewController: UITableViewController {
   
    var realm: Realm!
    var toDoList: Results<ToDoListItem>{
        get{return realm.objects(ToDoListItem.self)}
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        realm = try! Realm()
      
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoList.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        let item = toDoList[indexPath.row]
        cell.textLabel?.text = item.name
        cell.accessoryType = item.done == true ? .checkmark : .none

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = toDoList[indexPath.row]
        
        try! self.realm.write({
            item.done = !item.done
        })
        
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            let item = toDoList[indexPath.row]
            
            try! self.realm.write({
                self.realm.delete(item)
            })
            
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
 
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
    let alertVC = UIAlertController(title: "Новая задача", message: "Что нужно сделать", preferredStyle: .alert)
        alertVC.addTextField{ (UITextField) in
            
        }
        let cancelAction = UIAlertAction.init(title: "Отмена", style: .destructive, handler: nil)
        let addAction = UIAlertAction(title: "Добавить", style: .default) { (UIAlertAction)-> Void in
            let todoItemTextField = (alertVC.textFields?.first)! as UITextField
            let newToDoListItem = ToDoListItem()
            newToDoListItem.name = todoItemTextField.text!
            newToDoListItem.done = false
            
            
            try! self.realm.write({
                self.realm.add(newToDoListItem)
                self.tableView.insertRows(at: [IndexPath.init(row: self.toDoList.count - 1, section: 0)], with: .automatic)
            })
        }
        
        alertVC.addAction(addAction)
        present(alertVC, animated: true, completion: nil)
    }
}
