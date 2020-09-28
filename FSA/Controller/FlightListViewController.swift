//
//  FlightListViewController.swift
//  FSA
//
//  Created by Riad Mohamed on 9/24/20.
//  Copyright © 2020 Riad Mohamed. All rights reserved.
//

import UIKit
import CoreData


class FlightListViewController: UIViewController {
    // MARK: - Outlets & Variables
    @IBOutlet weak var tableView: UITableView!
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var flightsArray: [Flight] = []
    
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        flightsArray = loadArray()
    }
    
    
    func deselectRows() {
        if let selectedIndex = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: selectedIndex, animated: true)
        }
    }
    
    func saveArray() {
        do {
            try context.save()
        } catch {
            print("Error saving context: \(error)")
        }
        tableView.reloadData()
    }
    
    func loadArray() -> [Flight] {
        let request : NSFetchRequest<Flight> = Flight.fetchRequest()
        do {
            return try context.fetch(request)
        } catch {
            print("Error loading flights: \(error)")
        }
        return []
    }
    
    
    func updateFlight(_ updatedFlight: Flight) {
        let indexPath = tableView.indexPathForSelectedRow
        tableView.deselectRow(at: indexPath!, animated: true)
        flightsArray[indexPath!.row] = updatedFlight
        saveArray()
    }
    
    
    func deleteFlight(at index: Int) {
        print("Delete activated")
        context.delete(flightsArray[index])
        flightsArray.remove(at: index)
        saveArray()
    }
    
    func deleteAllFlights() {
        guard flightsArray.count > 0 else {
            print("Flights array is already empty")
            return
        }
        
        print("Delete All activated")
        
        let request: NSFetchRequest<Flight> = Flight.fetchRequest()
        request.returnsObjectsAsFaults = false
        do {
            let results = try context.fetch(request)
            for result in results {
                context.delete(result)
            }
        } catch {
            print("Failed to delete all Flights. \(error)")
        }
        
        for index in 0...flightsArray.count-1 {
            context.delete(flightsArray[index])
        }
        flightsArray = []
        saveArray()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "flightPageSegue" {
            // TODO: Create a FlightVC
            let destVC = segue.destination as! FlightViewController
            let indexPath = tableView.indexPathForSelectedRow
            destVC.currentFlight = flightsArray[indexPath!.row]
        }
    }
    
    
    // MARK: - Actions
    @IBAction func deleteAllButtonTapped(_ sender: UIButton) {
        deleteAllFlights()
        print("Deleting all flights")
    }
}

// MARK: - TableView Delegate & DataSource Extension
extension FlightListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return flightsArray.count
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deleteFlight(at: indexPath.row)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "flightCell") else {
            print("Cannot dequeue flightCell cell")
            return UITableViewCell()
        }
        
        cell.textLabel?.text = flightsArray[indexPath.row].callsign
        
        cell.detailTextLabel?.text = flightsArray[indexPath.row].departureTime!.toString()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "flightPageSegue", sender: self)
    }
    
}
