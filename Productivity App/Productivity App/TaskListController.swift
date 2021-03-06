import UIKit

class TaskListController: UITableViewController {

    var tasks:[String] = []
    let tasker = Tasker.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*
        let savedItems = UserDefaults.standard
        if let loadedItems:[Task] = savedItems.object(forKey: "tasks") as! [Task]? {
            tasker.tasks = loadedItems
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
 
        }
        */
    }

    /*
    func saveList() {
        let savedItems = UserDefaults.standard
        savedItems.set(tasker.tasks, forKey: "tasks")
        savedItems.synchronize()
    }
    */
    @IBAction func add(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "New Task", message: "Type task below", preferredStyle: .alert)
        alert.addTextField(configurationHandler: nil)
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { (action) in
            if let textFields = alert.textFields {
                if let item = textFields[0].text {
                    self.tasker.add(task: Task(title: item))
                    DispatchQueue.main.async {
                        //self.saveList()
                        self.tableView.reloadData()
                    }
                }
            }
            
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func editMode(_ sender: UIBarButtonItem) {
        self.isEditing = !self.isEditing
        if self.isEditing {
            sender.title = "Done"
        } else {
            sender.title = "Edit"
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        /*
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
         */
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasker.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Task", for: indexPath)
        
        if let lable = cell.textLabel {
            let task1 = tasker.tasks[indexPath.row]
            lable.text = task1.title
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tasker.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            //self.saveList()
        }
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let task:Task = tasker.tasks[fromIndexPath.row]
        tasker.remove(at: fromIndexPath.row)
        tasker.insert(task: task, at: to.row)
        self.tableView.reloadData()
        //self.saveList()
    }
   
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
 
}
