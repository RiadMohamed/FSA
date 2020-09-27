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
    
    var currentFlight: Flight? = nil
    @IBOutlet weak var callsignTextField: UITextField!
    @IBOutlet weak var departureTextField: UITextField!
    @IBOutlet weak var arrivalTextField: UITextField!
    @IBOutlet weak var etdDatePicker: UIDatePicker!
    @IBOutlet weak var alarmDatePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func dateToString(for date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        return dateFormatter.string(from: date)
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
