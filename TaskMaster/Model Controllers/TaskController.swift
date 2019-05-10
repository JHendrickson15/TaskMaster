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
    
    let fetchedResultsController: NSFetchedResultsController<Task>
    
    init() {
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        fetchRequest.sortDescriptors = [(NSSortDescriptor(key: "isComplete", ascending: true)) , (NSSortDescriptor(key: "due", ascending: false))]
        
        let resultsController:NSFetchedResultsController<Task> = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataStack.context, sectionNameKeyPath: "isComplete", cacheName: nil)
        
        fetchedResultsController = resultsController
        
        do {
            try fetchedResultsController.performFetch()
        }catch{
            print("There was an error performing the fetch!! \(error.localizedDescription)")
        }
    }
    
    func add(name: String , notes: String? , due: Date?){
       Task(name: name, notes: notes, due: due)
        saveToPersistentStore()
    }
    
    func delete(task: Task) {
        if let moc = task.managedObjectContext{
            moc.delete(task)
            saveToPersistentStore()
        }

        }
    func update(task: Task, name: String , notes: String? , due: Date?){
        task.name = name
        task.notes = notes
        task.due = due
       saveToPersistentStore()
        }
    func toggleIsComplete(task: Task){
       task.isComplete = !task.isComplete
        saveToPersistentStore()
    }
    func saveToPersistentStore() {
        let moc = CoreDataStack.context
        do{
            try moc.save()
        }catch{
            print("There was an error saving to the persistent Store \(error)")
        }
    }
}//end of class
