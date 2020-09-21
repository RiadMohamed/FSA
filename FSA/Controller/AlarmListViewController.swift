//
//  AlarmViewController.swift
//  FSA
//
//  Created by Riad Mohamed on 9/18/20.
//  Copyright © 2020 Riad Mohamed. All rights reserved.
//

import UIKit
import CoreData
class AlarmListViewController: UIViewController {
    // MARK: - Outlets & Variables
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    @IBOutlet weak var tableView: UITableView!
    var alarmsArray: [Alarm] = []
    
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        alarmsArray = self.loadArray()
        // Do any additional setup after loading the view.
    }
    
    func saveArray() {
        do {
            try context.save()
        } catch {
            print("Error saving context: \(error)")
        }
        
        self.tableView.reloadData()
        
    }
    
    func loadArray() -> [Alarm] {
        //TODO: CoreData to load the saved alarms
        let request : NSFetchRequest<Alarm> = Alarm.fetchRequest()
        do {
            return try context.fetch(request)
        } catch {
            print("Error loading alarms: \(error)")
        }
        
        //TODO: In case the loading failed then return empty array with print statement.
        return []
    }
    
    func updateAlarm(at index: Int) {
        
    }
    
    func deleteAlarm(at index: Int) {
        
    }
    
    func deleteAllAlarms() {
        
    }

     // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "alarmPageSegue" {
            let destVC = segue.destination as! AlarmViewController
            let indexPath = tableView.indexPathForSelectedRow
            print("2: \(indexPath?.row)")
            tableView.deselectRow(at: indexPath!, animated: true)
            destVC.alarm = alarmsArray[indexPath!.row]
        }
    
         
    }
    

}

// MARK: - TableView Delegate & DataSource Extension
extension AlarmListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // TODO: Set the number of rows to count of the alarms array
        return alarmsArray.count
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // TODO: Handle clicking the delete button
            print("Delete activated")
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // TODO: Design the alarm cell
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "alarmCell") else {
            print("Cannot dequeue alarmCell cell")
            return UITableViewCell()
        }
        cell.textLabel?.text = alarmsArray[indexPath.row].title
        
        // TODO: change the notes to date.
        cell.detailTextLabel?.text = alarmsArray[indexPath.row].notes
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("1: \(indexPath.row)")
        performSegue(withIdentifier: "alarmPageSegue", sender: self)
    }
    
    
}
