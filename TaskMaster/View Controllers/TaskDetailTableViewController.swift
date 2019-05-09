//
//  TaskDetailTableViewController.swift
//  TaskMaster
//
//  Created by Jordan Hendrickson on 5/8/19.
//  Copyright © 2019 Jordan Hendrickson. All rights reserved.
//

import UIKit

class TaskDetailTableViewController: UITableViewController {
    var task: Task?{
        didSet{
            updateViews()
        }
    }
    
    var dueDateValue: Date?
    
    @IBOutlet weak var taskNameTextField: UITextField!
    @IBOutlet weak var dueDateTextField: UITextField!
    @IBOutlet weak var notesBodyTextView: UITextView!
    @IBOutlet var dueDatePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        dueDateTextField.inputView = dueDatePicker
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        updateTask()
    }
    @IBAction func cancelButtonTapped(_ sender: Any) {
        let _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        self.dueDateTextField.text = sender.date.stringValue()
        self.dueDateValue = sender.date
    }
    
    @IBAction func userTappedView(_ sender: Any) {
        self.taskNameTextField.resignFirstResponder()
        self.dueDateTextField.resignFirstResponder()
        self.notesBodyTextView.resignFirstResponder()
    
    }
    
    func updateViews(){
        guard let task = task else {return}
        taskNameTextField.text = task.name
        notesBodyTextView.text = task.notes
        dueDateTextField.text = (task.due as Date?)?.stringValue()
        
    }
    
    
    func updateTask(){
        guard let taskNameTextField = taskNameTextField.text else {return}
        if let task = task {
            TaskController.sharedInstance.update(task: task, name: taskNameTextField, notes: notesBodyTextView.text, due: dueDateValue)
        }else{
            TaskController.sharedInstance.add(name: taskNameTextField, notes: notesBodyTextView.text, due: dueDateValue)
            
        }
        navigationController?.popViewController(animated: true)
    }
}
