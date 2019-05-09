//
//  CoreDataStack.swift
//  TaskMaster
//
//  Created by Jordan Hendrickson on 5/8/19.
//  Copyright © 2019 Jordan Hendrickson. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack {
    
    static let container: NSPersistentContainer = {
        let persistentContainer = NSPersistentContainer(name: "TaskMaster")
        persistentContainer.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error {
                fatalError("Unresolved Error\(error)")
            }
        })
        return persistentContainer
    }()
    static var context: NSManagedObjectContext {
        return container.viewContext
    }
}
