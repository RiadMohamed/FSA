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
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
//        datePicker.timeZone = TimeZone(identifier: "UTC")
        
        if let safeCurrentAlarm = currentAlarm {
            titleTextField.text = safeCurrentAlarm.title
            notesTextField.text = safeCurrentAlarm.notes
            datePicker.date = safeCurrentAlarm.date!
            saveButton.setTitle("Update Alarm", for: .normal)
        } else {
            saveButton.setTitle("Add Alarm", for: .normal)
        }
    }
    
    
    func saveNewAlarm() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let alarm = Alarm(context: context)
        alarm.title = titleTextField.text ?? ""
        alarm.date = datePicker.date
        alarm.notes = notesTextField.text ?? ""
        alarm.dateCreated = Date()
        
//        print(alarm.date?.timeIntervalSince1970)
        
        addNotification(for: alarm)
        
        guard let parentVC = self.presentingViewController as? AlarmListViewController else {
            print("VC is not shown modally from parent")
            return
        }
        parentVC.alarmsArray.append(alarm)
        parentVC.saveArray()
    }
    
    func updateAlarm() {
        // TODO: write the updateAlarm Function
        currentAlarm!.title = titleTextField.text ?? ""
        currentAlarm!.date = datePicker.date
        currentAlarm!.notes = notesTextField.text ?? ""
        updateNotification(for: currentAlarm!)
        
        guard let parentVC = self.presentingViewController as? AlarmListViewController else {
            print("VC is not shown modally from parent")
            return
        }
        
        parentVC.updateAlarm(currentAlarm!)
    }
    
    func addNotification(for alarm: Alarm) {
        let content = UNMutableNotificationContent()
        content.title = alarm.title!
        content.sound = .default
        content.body = alarm.notes!
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year,.month,.day], from: alarm.date!)
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
        let request = UNNotificationRequest(identifier: dateToString(for: alarm.dateCreated!), content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { (error) in
            if error != nil {
                print("Error creating the alamr. \(error!)")
            }
        }
    }
    
    func updateNotification(for alarm: Alarm) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [dateToString(for: alarm.dateCreated!)])
        addNotification(for: alarm)
    }
    
    func dateToString(for date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        return dateFormatter.string(from: date)
    }
    
    // MARK: - Actions
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        if currentAlarm == nil {
            saveNewAlarm()
        } else {
            updateAlarm()
        }
        dismiss(animated: true, completion: nil)
        
//        func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//            // Get the new view controller using segue.destination.
//            // Pass the selected object to the new view controller.
//            
//        }
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
