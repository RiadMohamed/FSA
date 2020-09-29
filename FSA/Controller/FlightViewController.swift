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
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad() 
        if let safeCurrentFlight = currentFlight {
            callsignTextField.text = safeCurrentFlight.callsign
            departureTextField.text = safeCurrentFlight.departure
            arrivalTextField.text = safeCurrentFlight.arrival
            etdDatePicker.date = safeCurrentFlight.etd!
            alarmDatePicker.date = safeCurrentFlight.alarmTime!
            saveButton.setTitle("Update Flight", for: .normal)
        } else {
            saveButton.setTitle("Add Flight", for: .normal)
        }
    }
    
    func getUserFlight() -> Flight {
        let flight = Flight(context: context)
        flight.callsign = callsignTextField.text ?? ""
        flight.departure = departureTextField.text ?? ""
        flight.arrival = arrivalTextField.text ?? ""
        flight.etd = etdDatePicker.date
        flight.alarmTime = alarmDatePicker.date
        flight.dateCreated = Date()
        flight.alarm = Alarm(context: context)
        flight.alarm?.date = flight.alarmTime
        return flight
    }
    
    func addNewFlight() {
        guard let parentVC = self.presentingViewController?.children.last as? FlightListViewController else {
            print("VC is not shown modally from parent")
            return
        }
        
        let flight = getUserFlight()
        flight.alarm?.addNotification()
        parentVC.addFlight(flight)
    }
    
    func updateFlight() {
        guard let parentVC = self.presentingViewController as? FlightListViewController else {
            print("VC is not shown modally from parent")
            return
        }
        currentFlight = getUserFlight()
        currentFlight?.alarm?.updateNotification()
        parentVC.updateFlight(currentFlight!)
    }
    
    // MARK: - Actions
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        
    }
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        
    }
    
}
