//
//  FlightViewController.swift
//  FSA
//
//  Created by Riad Mohamed on 9/27/20.
//  Copyright © 2020 Riad Mohamed. All rights reserved.
//

import UIKit
import CoreData

class FlightViewController: UIViewController {
    
    // MARK: - Outlets & Variables
    var currentFlight: Flight? = nil
    @IBOutlet weak var callsignTextField: UITextField!
    @IBOutlet weak var departureTextField: UITextField!
    @IBOutlet weak var arrivalTextField: UITextField!
    @IBOutlet weak var etdDatePicker: UIDatePicker!
    @IBOutlet weak var alarmDatePicker: UIDatePicker!
    @IBOutlet weak var saveButton: UIButton!
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if let safeCurrentAlarm = currentAlarm {
            titleTextField.text = safeCurrentAlarm.title
            notesTextField.text = safeCurrentAlarm.notes
            datePicker.date = safeCurrentAlarm.date!
            saveButton.setTitle("Update Alarm", for: .normal)
        } else {
            saveButton.setTitle("Add Alarm", for: .normal)
        }
    }
    
    func saveNewFlight() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let flight = Flight(context: context)
        flight.title = titleTextField.text ?? ""
        flight.date = datePicker.date
        flight.notes = notesTextField.text ?? ""
        flight.dateCreated = Date()
        
        guard let parentVC = self.presentingViewController?.children.last as? FlightListViewController else {
            print("VC is not shown modally from parent")
            return
        }
        
        addNotification(for: flight)
        parentVC.flightsArray.append(flight)
        parentVC.saveArray()
    }
    
    func updateFlight() {
        currentFlight!.title = titleTextField.text ?? ""
        currentFlight!.date = datePicker.date
        currentFlight!.notes = notesTextField.text ?? ""
        updateNotification(for: currentFlight!)
        
        guard let parentVC = self.presentingViewController as? FlightListViewController else {
            print("VC is not shown modally from parent")
            return
        }
        parentVC.updateAlarm(currentFlight!)
    }

    func addNotification(for alarm: Alarm) {
        let content = UNMutableNotificationContent()
        content.title = alarm.title!
        content.sound = .default
        content.body = alarm.notes!
        content.badge = 1
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year,.month,.day, .hour, .minute], from: alarm.date!)
        print(components)
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
//        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let request = UNNotificationRequest(identifier: alarm.dateCreated!.toString(), content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { (error) in
            if error != nil {
                print("Error creating the alamr. \(error!)")
            }
        }
    }
    
    func updateNotification(for alarm: Alarm) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [alarm.dateCreated!.toString()])
        addNotification(for: alarm)
    }
    
    // MARK: - Actions
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        
    }
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        
    }
    
}
