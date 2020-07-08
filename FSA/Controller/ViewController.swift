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
    // MARK: - Properties
    var localTime: String = "" {
        didSet {
            DispatchQueue.main.async {
                self.localTimeLabel.text = self.localTime
            }
        }
    }
    
    var state: State = .idle {
        didSet {
            print(state)
        }
    }
    
    // MARK: - Outlets
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var countryTextField: UITextField!
    @IBOutlet weak var localTimeLabel: UILabel!
    
    // MARK: - ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cityTextField.delegate = self
        countryTextField.delegate = self
        state = .idle
    }
    
    // MARK: - Functions
    /// Takes unix time and create a Date Formatter object that will parse the unix time into string and return it back.
    /// - Parameter unix: Unix time
    /// - Returns: string with the format of "HH:MM:SS AM/PM"
    func formatUnixTime(unixTime: Double) -> String {
        state = .formattingUnixTime
        
        let date = Date(timeIntervalSince1970: unixTime)
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")!
        dateFormatter.timeStyle = .medium
        
        // TODO: Get the date with the corressponding given unix time.
        let localTimeString = dateFormatter.string(from: date)
        // TODO: return the output as a string.
        self.state = .idle
        return localTimeString 
    }
    
    func parseJSON(timeData: Data) -> TimeModel? {
        let decoder = JSONDecoder()
        do {
            let timeModel = try decoder.decode(TimeModel.self, from: timeData)
            return timeModel
        } catch {
            print(error)
            return nil
        }
    }
    
    
    /// Takes a lat and long, create a GET request to TimeZone DB with given coordinates, receieve the JSON response then extract and return the unix time for the current local time at those coordinates.
    /// - Parameters:
    ///   - lat: latitude of the location
    ///   - long: longitude of the location
    /// - Returns: current unix local time of the given location
    func getUnixTime(coordinates: CLLocationCoordinate2D, completionHander: @escaping (TimeModel?, Error?) -> Void) {
        
        state = .gettingUnixTime
        let APIKey = "AP6KGMZ6GGA3"
        let format = "json"
        let by = "position"

        let timeZoneURL = URL(string: "https://api.timezonedb.com/v2.1/get-time-zone?key=\(APIKey)&format=\(format)&by=\(by)&lat=\(coordinates.latitude)&lng=\(coordinates.longitude)")
        
        // 1- Create a URL
        guard let url = timeZoneURL else {
            print("Creating URL failed")
            state = .idle
            completionHander(nil, FSAError.creatingURLError)
            return
        }
        
        // 2- Create URLSession
        let session = URLSession(configuration: .default)
        
        // 3- Give the session a task
        let task = session.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print("Networking code returned an error. \(error!)")
                self.state = .idle
                completionHander(nil, FSAError.networkingError)
            }
            
            guard let safeData = data else {
                print("Unwrapping safe data from receieved data failed.")
                self.state = .idle
                completionHander(nil, FSAError.unwrappingNetworkingDataError)
                return
            }
            
            let timeModel = self.parseJSON(timeData: safeData)
            self.state = .idle
            completionHander(timeModel, nil)
        }
        
        // 4- Start the task
        task.resume()
    }
    
    
    /// Takes a location address string and returns the coordinates of that address.
    /// - Parameter address: string describing the location address in the form of "{cityName}" or  "{cityName}, {countryName}"
    /// - Returns: CLLocationCoordinate2D object containg the coordinates of the location address given
    func getCoordinatesByCoreLocation(address: String, completionHandler: @escaping (CLLocationCoordinate2D?, Error?) -> Void) {
        // TODO: Initiate the CoreLocation service to get the coordinates of the given address.
        self.state = .gettingCoordinates
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
        // CoreLocation Module.
        getCoordinatesByCoreLocation(address: locationString) { (c, error) in
            guard let coordinates = c, error == nil else {
                print(error!)
                return
            }
            print("Phase one result = \(coordinates)")
            self.localTime = "\(coordinates.latitude), \(coordinates.longitude)"
            
            // Networking Module.
            self.getUnixTime(coordinates: coordinates) { (timeModel, error) in
                if error != nil {
                    print(error!)
                }
                guard let safeTimeModel = timeModel else {
                    print("Error unwrapping the unix time.")
                    return
                }
                print("Phase two result = \(safeTimeModel)")
                self.localTime = "\(safeTimeModel.timestamp)"
                
                // UNIX Formatting Module.
                self.localTime = self.formatUnixTime(unixTime: safeTimeModel.timestamp)
            }
        }
    }
    
    // MARK: - Actions
    // MARK: - FetchButtonTapped
    func setupLocationString() -> String? {
        
        var locationString = ""
        
        if let cityName = cityTextField.text, let countryName = countryTextField.text {
            if cityName.count != 0 {
                locationString = cityName
            } else if countryName.count != 0 {
                locationString = "\(cityName), \(countryName)"
            } else {
                if countryName.count != 0 {
                    locationString = countryName
                }
            }
        }
        return locationString
    }
    
    @IBAction func fetchButtonTapped(_ sender: UIButton) {
        // Hide the keyboard.
        countryTextField.endEditing(true)
        cityTextField.endEditing(true)
        
        // Get a locationString.
        guard let locationString = setupLocationString() else {
            print("Could not get the location string")
            return
        }
        
        // Fetch the local time.
        fetchLocalTime(address: locationString)
    }
    
}

// MARK: - Delegates Methods
// MARK: - UITextFieldDelegate
extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        print(textField.text ?? "")
        fetchButtonTapped(UIButton())
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
}
