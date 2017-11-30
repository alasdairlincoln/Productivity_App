import XCTest

class TaskMakerTests: XCTestCase {
    
    let tasker = Tasker.sharedInstance
    
    override func setUp() {
        super.setUp()
        tasker.clearList()
    }
    
    func testAddTask() {
        tasker.add(task: "Homework")
        let newTask: String = tasker.getTask(atIndex: 0)
        XCTAssertEqual(newTask, "Homework")
    }
    
    func testGetTask() {
        tasker.add(task: "Homework")
        let newTask = tasker.getTask(atIndex: 0)
        XCTAssertEqual(newTask, "Homework")
    }
    
    func testCountTasks() {
        tasker.add(task: "Homework")
        let tasksCount = tasker.count
        XCTAssertEqual(tasksCount, 1)
    }
    
    func testClearList() {
        tasker.add(task: "Homework")
        tasker.clearList()
        let tasksCount = tasker.count
        XCTAssertEqual(tasksCount, 0)
    }
    
    func testInsert() {
        tasker.add(task: "Homework")
        tasker.insert(task: "Coursework", at: 0)
        let newTask = tasker.getTask(atIndex: 0)
        XCTAssertEqual(newTask, "Coursework")
    }
    
    func testUpdate() {
        tasker.add(task: "Homework")
        tasker.update(task: "Coursework", at: 0)
        let newTask = tasker.getTask(atIndex: 0)
        XCTAssertEqual(newTask, "Coursework")
    }
    
    func testRemove() {
        tasker.add(task: "Homework")
        tasker.remove(at: 0)
        let tasksCount = tasker.count
        XCTAssertEqual(tasksCount, 0)
    }
    
}
