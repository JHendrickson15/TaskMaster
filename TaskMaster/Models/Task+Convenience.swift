//
//  Task+Convenience.swift
//  TaskMaster
//
//  Created by Jordan Hendrickson on 5/8/19.
//  Copyright © 2019 Jordan Hendrickson. All rights reserved.
//

import Foundation
import CoreData

extension Task {
    @discardableResult
    convenience init(name: String , notes: String? = nil , due: Date? = nil , context: NSManagedObjectContext = CoreDataStack.context) {
        
        self.init(context: context)
        
        self.name = name
        self.notes = notes
        self.due = due
        self.isComplete = false
    }
}
