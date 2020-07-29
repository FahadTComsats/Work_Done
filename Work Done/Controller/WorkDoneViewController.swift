//
//  ViewController.swift
//  Work Done
//
//  Created by Fahad Tariq on 28/07/2020.
//  Copyright © 2020 Fahad Tariq. All rights reserved.
//

import UIKit

class WorkDoneViewController: UITableViewController {

    
    var items = [Items]()
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newItem = Items()
        newItem.title = "Fahad"
        items.append(newItem)
         
//        if let itemArray = defaults.array(forKey: "WorkDoneList") as? [String]{
//            items = itemArray
//        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "WorkDoneItemCell", for: indexPath)
        let item = items[indexPath.row]
        cell.textLabel?.text = item.title
         
        if item.done == true{
            cell.accessoryType = .checkmark
        }else{
            cell.accessoryType = .none
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        items[indexPath.row].done = !items[indexPath.row].done
        
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add Work", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            let newItem = Items()
            newItem.title = textField.text!
            self.items.append(newItem)
            
            self.defaults.set(self.items, forKey: "WorkDoneList")
            
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            
            alertTextField.placeholder = "Create new Item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil )
    }
    

}

