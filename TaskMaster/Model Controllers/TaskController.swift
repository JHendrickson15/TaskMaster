//
//  TaskController.swift
//  TaskMaster
//
//  Created by Jordan Hendrickson on 5/8/19.
//  Copyright © 2019 Jordan Hendrickson. All rights reserved.
//

import Foundation
import CoreData
class TaskController {
    
    static let sharedInstance = TaskController()
    
    var tasks: [Task]{
        
        let request: NSFetchRequest<Task> = Task.fetchRequest()
        return try! CoreDataStack.context.fetch(request)
    }
    
    func add(name: String , notes: String? , due: Date?){
       Task(name: name, notes: notes, due: due)
    }
    
    func delete(task: Task) {
        if let moc = task.managedObjectContext{
            moc.delete(task)
            
        }

        }
    func update(task: Task, name: String , notes: String? , due: Date?){
        task.name = name
        task.notes = notes
        task.due = due
       
        }
    func toggleIsComplete(task: Task){
       task.isComplete = !task.isComplete
    }
    func fetchTasks() -> [Task]{
        return tasks
    }
}//end of class
