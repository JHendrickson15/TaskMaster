//
//  TableViewController.swift
//  TaskMaster
//
//  Created by Jordan Hendrickson on 5/9/19.
//  Copyright © 2019 Jordan Hendrickson. All rights reserved.
//

import UIKit
import CoreData

class TaskListTableViewController: UITableViewController , ButtonTableViewCellDelegate {
    
    func buttonCellButtonTapped(_ sender: ButtonTableViewCell) {
        guard let indexPath = tableView.indexPath(for: sender) else {return}
            let task = TaskController.sharedInstance.fetchedResultsController.object(at: indexPath)
            TaskController.sharedInstance.toggleIsComplete(task: task)
        sender.updateButton(task.isComplete)
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "TO DO"
        TaskController.sharedInstance.fetchedResultsController.delegate = self
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let sections = TaskController.sharedInstance.fetchedResultsController.sections, sections.count > section else {return nil}
        return sections[section].name
    }
//
//    // MARK: - Table view data source
//
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        guard let sections = TaskController.sharedInstance.fetchedResultsController.sections else {return 0}
        return sections.count
//        return TaskController.sharedInstance.fetchedResultsController.sections?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        guard let sections = TaskController.sharedInstance.fetchedResultsController.sections, sections.count > section else {return 0}
        return sections[section].numberOfObjects
//        return TaskController.sharedInstance.fetchedResultsController.sections?[section].numberOfObjects ?? 0
    }
    

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as! ButtonTableViewCell
        
        let task = TaskController.sharedInstance.fetchedResultsController.object(at: indexPath)
        cell.update(withTask: task)
        cell.delegate = self
        
        
        // Configure the cell...

        return cell
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let task = TaskController.sharedInstance.fetchedResultsController.object(at: indexPath)
            TaskController.sharedInstance.delete(task: task)
            // Delete the row from the data source
        }
    }


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailVC" {
            
            guard let selectedIndexPath = tableView.indexPathForSelectedRow, let destinationVC = segue.destination as? TaskDetailTableViewController else {return}
            
            let task = TaskController.sharedInstance.fetchedResultsController.object(at: selectedIndexPath)
            
            destinationVC.task = task
        }
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }


}// end of class

extension TaskListTableViewController: NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        switch type {
            
        case .delete:
           tableView.deleteSections(IndexSet(integer: sectionIndex), with: .automatic)
            
        case .insert:
            tableView.insertSections(IndexSet(integer: sectionIndex), with: .automatic)
            
        case .move:
            break
            
        case .update:
           break
        
        @unknown default:
            fatalError()
        }
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
            
        case .delete:
            guard let indexPath = indexPath else {return}
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
        case .insert:
            guard let newIndexPath = newIndexPath else {return}
            tableView.insertRows(at: [newIndexPath], with: .automatic)
            
        case .move:
            guard let oldIndexPath = indexPath, let newIndexPath = newIndexPath else {return}
            tableView.moveRow(at: oldIndexPath, to: newIndexPath)
            
        case .update:
            guard let indexPath = indexPath else {return}
            tableView.reloadRows(at: [indexPath], with: .automatic)
        @unknown default:
            fatalError()
        }
    }
}
