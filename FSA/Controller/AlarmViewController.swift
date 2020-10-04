//
//  AlarmViewController.swift
//  FSA
//
//  Created by Riad Mohamed on 9/20/20.
//  Copyright © 2020 Riad Mohamed. All rights reserved.
//

import UIKit
import CoreData
import UserNotifications

class AlarmViewController: UIViewController {

    // MARK: - Outlets & Variables
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var notesTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    var currentAlarm: Alarm? = nil
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var parentVC: AlarmListViewController? = nil
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        if let safeCurrentAlarm = currentAlarm {
            titleTextField.text = safeCurrentAlarm.title
            notesTextField.text = safeCurrentAlarm.notes
            datePicker.date = safeCurrentAlarm.date!
            saveButton.setTitle("Update Alarm", for: .normal)
        } else {
            saveButton.setTitle("Add Alarm", for: .normal)
        }
    }
    
    func getUserAlarm() -> Alarm {
        let alarm = Alarm(context: context)
        alarm.title = titleTextField.text ?? ""
        alarm.date = datePicker.date
        alarm.notes = notesTextField.text ?? ""
        alarm.dateCreated = Date()
        return alarm
    }
    
    func addNewAlarm() {
        let alarm = getUserAlarm()
        alarm.addNotification(alarm.title)
        parentVC!.addAlarm(alarm)
    }
    func updateAlarm() {
        currentAlarm = getUserAlarm()
        currentAlarm!.updateNotification(currentAlarm?.title)
        parentVC!.updateAlarm(currentAlarm!)
    }
    
    
    
    // MARK: - Actions
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        if currentAlarm == nil {
            addNewAlarm()
        } else {
            updateAlarm()
        }
        dismiss(animated: true, completion: nil)
    }
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        guard let parentVC = self.presentingViewController as? AlarmListViewController else {
            print("VC is not shown modally from parent")
            return
        }
        parentVC.deselectRows()
        dismiss(animated: true, completion: nil)
    }
}
