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
    
    var localTime: String = "" {
        didSet {
            localTimeLabel.text = localTime
        }
    }
    var state: State = .idle
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var countryTextField: UITextField!
    @IBOutlet weak var localTimeLabel: UILabel!
    
    // MARK: - ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //        countryTextField.delegate = self
        cityTextField.delegate = self
        countryTextField.delegate = self
        state = .idle
    }
    
    // MARK: - Functions
    /// Takes unix time and create a Date Formatter object that will parse the unix time into string and return it back.
    /// - Parameter unix: Unix time
    /// - Returns: string with the format of "HH:MM:SS AM/PM"
    func getLocalTimeString(unix: Double) -> String {
        let localTimeString = "EMPTY TIME STRING"
        // TODO: Initiate the Date Formatter object with the time style.
        
        // TODO: Get the date with the corressponding given unix time.
        
        // TODO: return the output as a string.
        return localTimeString 
    }
    
    /// Takes a lat and long, create a GET request to TimeZone DB with given coordinates, receieve the JSON response then extract and return the unix time for the current local time at those coordinates.
    /// - Parameters:
    ///   - lat: latitude of the location
    ///   - long: longitude of the location
    /// - Returns: current unix local time of the given location
    func getUnixTime(lat: Double, long: Double) -> Double {
        let unixTime: Double = 0
        // TODO: Create the networking code for the request and receieve the response.
        
        // TODO: Parse the response as JSON and extract the current UNIX time.
        
        return unixTime
    }
    
    
    /// Takes a location address string and returns the coordinates of that address.
    /// - Parameter address: string describing the location address in the form of "{cityName}" or  "{cityName}, {countryName}"
    /// - Returns: CLLocationCoordinate2D object containg the coordinates of the location address given
    func getCoordinatesByCoreLocation(address: String, completionHandler: @escaping (CLLocationCoordinate2D?, Error?) -> Void) {
        // TODO: Initiate the CoreLocation service to get the coordinates of the given address.
        self.state = .waitingForCoordinates
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) { (placemarks, error)  in
            guard let coordinates = placemarks?.first?.location?.coordinate, error == nil else {
                print(error.debugDescription)
                self.state = .idle
                completionHandler(nil, FSAError.gettingCoordinatesError)
                return
            }
            self.state = .idle
            completionHandler(coordinates, nil)
        }
    }
    
    /// Take a location address string and returns the local time of that location using CoreLocation and API from TimeZoneDB
    /// - Parameter locationString: string describing the location address in the form of "{cityName}" or  "{cityName}, {countryName}"
    /// - Returns: string with the current local time at the given location address in the form of "HH:MM:SS AM/PM"
    func fetchLocalTime(address locationString: String) {
        
        getCoordinatesByCoreLocation(address: locationString) { (c, error) in
            guard let coordinates = c, error != nil else {
                print(error!)
                return
            }
            
            print(self.state)
            print(coordinates)
            self.localTime = "\(coordinates.latitude), \(coordinates.longitude)"
            
            // Networking code
            
            // UNIX Format code 
            
            
        }
    }
    
    // MARK: - Actions
    // MARK: - FetchButtonTapped
    func setupLocationString() -> String? {
        guard let cityName = cityTextField.text, cityName.count != 0 else {
            print("City textfield is empty, couldn't get city name")
            return nil
        }
        
        var locationString = cityName
        if let countryName = countryTextField.text, countryName.count != 0 {
            locationString.append(", " + countryName)
        } else {
            print("Country textfield is empty, couldn't get country name")
        }
        
        return locationString
    }
    
    @IBAction func fetchButtonTapped(_ sender: UIButton) {
        countryTextField.endEditing(true)
        cityTextField.endEditing(true)
        
        guard let locationString = setupLocationString() else {
            print("Could not get the location string")
            return
        }
        
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
