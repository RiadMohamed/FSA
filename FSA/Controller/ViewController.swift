//
//  ViewController.swift
//  FSA
//
//  Created by Riad Mohamed on 6/24/20.
//  Copyright © 2020 Riad Mohamed. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    // MARK: - Outlets
    
//    @IBOutlet weak var countryTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var countryTextField: UITextField!
    @IBOutlet weak var localTimeLabel: UILabel!
    
    // MARK: - ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        countryTextField.delegate = self
        cityTextField.delegate = self
    }

    // MARK: - Functions
    
    func fetchLocalTime(address locationString: String) -> String {
        
        //TODO: Get coordinates of the city.
        let coordinates = getCoordinatesByCoreLocation(address: locationString)
        //TODO: Get the current unix time from the TimeZoneDB API
        let currentUnixTime = getUnixTime(lat: Double(coordinates.latitude), long: Double(coordinates.longitude))
        //TODO: convert the unix time to string "HH:MM:SS AM/PM"
        let currentLocalTimeString: String = getLocalTimeString(unix: currentUnixTime)
        
        return currentLocalTimeString
    }
    
    func getCoordinatesByCoreLocation(address: String) -> CLLocationCoordinate2D {
        // TODO: Initiate the CoreLocation service to get the coordinates of the given address.
        
        var coordinates = CLLocationCoordinate2D()
        return coordinates
    }
    
    func getUnixTime(lat: Double, long: Double) -> Double {
        var unixTime: Double = 0
        // TODO: Create the networking code for the request and receieve the response.
        
        // TODO: Parse the response as JSON and extract the current UNIX time.
        
        return unixTime
    }
    
    func getLocalTimeString(unix: Double) -> String {
        var localTimeString = ""
        // TODO: Initiate the Date Formatter object with the time style.
        
        // TODO: Get the date with the corressponding given unix time.
        
        // TODO: return the output as a string.
        return localTimeString 
    }
    
    
    // MARK: - Actions
        // MARK: - FetchButtonTapped
    @IBAction func fetchButtonTapped(_ sender: UIButton) {
        countryTextField.endEditing(true)
        cityTextField.endEditing(true)
        print("Button Tapped")
        guard let cityName = cityTextField.text, cityName.count != 0 else {
            print("City textfield is empty, couldn't get city name")
            return
        }
//        print(cityName)
        var locationString = cityName
        if let countryName = countryTextField.text, countryName.count != 0 {
            locationString.append(", " + countryName)
        } else {
            print("Country textfield is empty, couldn't get country name")
        }
        print(locationString)
        // TODO: call the fetchLocalTime function
        fetchLocalTime(address: locationString)
    }

}

// MARK: - Delegates Methods
    // MARK: - UITextFieldDelegate
extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        print(textField.text ?? "")
        // TODO: Call the fetch function
        return true
    }
}
