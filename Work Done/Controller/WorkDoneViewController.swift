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
    let datafilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadItems()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "WorkDoneItemCell", for: indexPath)
        let item = items[indexPath.row]
        cell.textLabel?.text = item.title
        // value = condition ? ifTrue: ifFalse
        cell.accessoryType = item.done == true ? .checkmark: .none
        

        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        items[indexPath.row].done = !items[indexPath.row].done
        saveItems()
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add Work", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            let newItem = Items()
            
            newItem.title = textField.text!
            
            self.items.append(newItem)
            self.saveItems()
            
            
        }
        
        alert.addTextField { (alertTextField) in
            
            alertTextField.placeholder = "Create new Item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil )
    }
    
    func saveItems(){
        
        let encoder = PropertyListEncoder()
        do{
            let data = try encoder.encode(self.items)
            try data.write(to: self.datafilePath! )
            
        }catch{
            print("ERROR")
        }
        
        self.tableView.reloadData()
        
    }
    
    func loadItems(){
        
        if let data = try? Data(contentsOf: datafilePath!){
            let decoder = PropertyListDecoder()
            do{
                items = try decoder.decode([Items].self, from: data)
            }catch{
                print("Error ")
            }
        }
        
    }
    

}

