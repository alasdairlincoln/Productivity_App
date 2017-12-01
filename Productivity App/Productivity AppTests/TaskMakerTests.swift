import XCTest

class TaskMakerTests: XCTestCase {
    
    let tasker = Tasker.sharedInstance
    let HomeworkTask = Task(title: "Homework")
    let CourseworkTask = Task(title: "Coursework")
    
    override func setUp() {
        super.setUp()
        tasker.clearList()
    }
    
    func testAddTask() {
        tasker.add(task: HomeworkTask)
        let newTask: Task = tasker.getTask(atIndex: 0)
        XCTAssertEqual(newTask.title, "Homework")
    }
    
    func testGetTask() {
        tasker.add(task: HomeworkTask)
        let newTask = tasker.getTask(atIndex: 0)
        XCTAssertEqual(newTask.title, "Homework")
    }
    
    func testCountTasks() {
        tasker.add(task: HomeworkTask)
        let tasksCount = tasker.count
        XCTAssertEqual(tasksCount, 1)
    }
    
    func testClearList() {
        tasker.add(task: HomeworkTask)
        tasker.clearList()
        let tasksCount = tasker.count
        XCTAssertEqual(tasksCount, 0)
    }
    
    func testInsert() {
        tasker.add(task: HomeworkTask)
        tasker.insert(task: CourseworkTask, at: 0)
        let newTask = tasker.getTask(atIndex: 0)
        XCTAssertEqual(newTask.title, "Coursework")
    }
    
    func testUpdate() {
        tasker.add(task: HomeworkTask)
        tasker.update(task: CourseworkTask, at: 0)
        let newTask = tasker.getTask(atIndex: 0)
        XCTAssertEqual(newTask.title, "Coursework")
    }
    
    func testRemove() {
        tasker.add(task: HomeworkTask)
        tasker.remove(at: 0)
        let tasksCount = tasker.count
        XCTAssertEqual(tasksCount, 0)
    }
    
}
