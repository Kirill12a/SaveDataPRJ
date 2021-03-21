//
//  CoreDataTableViewController.swift
//  9 SkillBox new version
//
//  Created by Kirill Drozdov on 21.03.2021.
//

import UIKit
import CoreData

class CoreDataTableViewController: UITableViewController {
    
    var items = [Items]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let item =  items[indexPath.row]
        cell.textLabel?.text = item.name
        cell.accessoryType = item.completed ? .checkmark : .none
        return cell
    }
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        items[indexPath.row].completed = !items[indexPath.row].completed
        
        saveItems()
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete){
            let item = items[indexPath.row]
            items.remove(at: indexPath.row)
            context.delete(item)
            
            do{
                try context.save()
            }catch{
                print("Ошибка удаления \(error.localizedDescription)")
            }
            
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Добавить новое событие", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Добавить", style: .default) { (action) in
            
            let newItem  = Items(context: self.context)
            newItem.name = textField.text!
            self.items.append(newItem)
            self.saveItems()
        }
        
        alert.addAction(action)
        alert.addTextField { (field) in
            textField = field
            textField.placeholder = "Добавить новую задачу"
        }
        present(alert, animated: true, completion: nil)
        
    }
    
    func saveItems(){
        
        do{
            try context.save()
        }catch{
            print("Ошибока сохр. айтемов \(error.localizedDescription)")
        }
        
        tableView.reloadData()
    }
    
    func loadItems(){
        let request: NSFetchRequest<Items> = Items.fetchRequest()
        
        do{
            items = try context.fetch(request)
        }catch{
            print("Ошибка")
        }
        
        tableView.reloadData()
    }
    
}
