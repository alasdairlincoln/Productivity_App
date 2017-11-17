//
//  ListController.swift
//  Productivity App
//
//  Created by Alasdair Lincoln on 28/10/2017.
//  Copyright © 2017 Alasdair Lincoln. All rights reserved.
//

import UIKit

class BackgroundView: UIView {
    
    
    
}

class ListController: UITableViewController {
    
    var tasks:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let savedItems = UserDefaults.standard
        if let loadedItems:[String] = savedItems.object(forKey: "items") as! [String]? {
            self.tasks = loadedItems
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    @IBAction func editMode(_ sender: UIBarButtonItem) {
        self.isEditing = !self.isEditing
        if self.isEditing {
            sender.title = "Done"
        } else {
            sender.title = "Edit"
        }
    }
    
    @IBAction func addTask(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "New Task", message: "Type task below", preferredStyle: .alert)
        alert.addTextField(configurationHandler: nil)
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { (action) in
            if let textFields = alert.textFields {
                if let item = textFields[0].text {
                    self.tasks.append(item)
                    DispatchQueue.main.async {
                        self.saveList()
                        self.tableView.reloadData()
                    }
                }
            }
            
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
    
    func saveList() {
        let savedItems = UserDefaults.standard
        savedItems.set(tasks, forKey: "items")
        savedItems.synchronize()
    }

    

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        //TO-DO: Fix bug that causes a crash when final item is deleted
        
        var youHaveData: Bool
        
        if self.tasks.isEmpty {
            youHaveData = false
        } else {
            youHaveData = true
        }
        
        var numOfSections: Int = 0
        if youHaveData
        {
            tableView.separatorStyle = .singleLine
            numOfSections            = 1
            tableView.backgroundView = nil
        }
        else
        {
            let noDataLabel: UILabel     = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
            noDataLabel.text          = "No tasks, please add a task"
            noDataLabel.textColor     = UIColor.black
            noDataLabel.textAlignment = .center
            tableView.backgroundView  = noDataLabel
            tableView.separatorStyle  = .none
            
            //TO-DO: remove edit button when displaying no task screen
            
            //self.navigationItem.leftBarButtonItem = self.deleteBarButton
        }
        return numOfSections
    
 
    
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.tasks.count
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell:UITableViewCell = self.tableView?.cellForRow(at: indexPath){
            if cell.accessoryType == .checkmark {
                cell.accessoryType = .none
            } else {
                cell.accessoryType = .checkmark
            }
        }
        tableView.deselectRow(at: indexPath, animated: true)
        
        
        //TO-DO: properly implement this
        //ViewController()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "jobList", for: indexPath)
        
        if let lable = cell.textLabel {
            lable.text = self.tasks[indexPath.row]

        }
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.tasks.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            self.saveList()
        }
    }
 
    
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let item:String = tasks[fromIndexPath.row]
        self.tasks.remove(at: fromIndexPath.row)
        tasks.insert(item, at: to.row)
        self.tableView.reloadData()
        self.saveList()
    }

    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        
        return true
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
