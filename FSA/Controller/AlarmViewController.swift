//
//  AlarmViewController.swift
//  FSA
//
//  Created by Riad Mohamed on 9/20/20.
//  Copyright © 2020 Riad Mohamed. All rights reserved.
//

import UIKit
import CoreData


class AlarmViewController: UIViewController {

    // MARK: - Outlets & Variables
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var notesTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    var alarm: Alarm? = nil
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker.timeZone = TimeZone(identifier: "UTC")
        
        if let currentAlarm = alarm {
            titleTextField.text = currentAlarm.title
            notesTextField.text = currentAlarm.notes
            datePicker.date = currentAlarm.date!
        }
    }
    
    
    func saveNewAlarm() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let alarm = Alarm(context: context)
        alarm.title = titleTextField.text ?? ""
        alarm.date = datePicker.date
        alarm.notes = notesTextField.text ?? ""
        
        guard let parentVC = self.presentingViewController as? AlarmListViewController else {
            print("VC is not shown modally from parent")
            return
        }
        parentVC.alarmsArray.append(alarm)
        parentVC.saveArray()
    }
    
    func updateAlarm() {
        
    }
    
    // MARK: - Actions
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        if alarm == nil {
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
        dismiss(animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
