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
    var currentAlarm: Alarm? = nil
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker.timeZone = TimeZone(identifier: "UTC")
        
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
        
        guard let parentVC = self.presentingViewController as? AlarmListViewController else {
            print("VC is not shown modally from parent")
            return
        }
        
        parentVC.updateAlarm(currentAlarm!)
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
