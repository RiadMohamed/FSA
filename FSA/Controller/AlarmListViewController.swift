//
//  AlarmViewController.swift
//  FSA
//
//  Created by Riad Mohamed on 9/18/20.
//  Copyright © 2020 Riad Mohamed. All rights reserved.
//

import UIKit
import CoreData
import UserNotifications


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
        alarmsArray = loadArray()
    }
    
    func deselectRows() {
        if let selectedIndex = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: selectedIndex, animated: true)
        }
    }
    
    func addAlarm(_ alarm: Alarm) {
        alarmsArray.append(alarm)
        saveArray()
    }
    
    // MARK: - CRUD
    func saveArray() {
        do {
            try context.save()
        } catch {
            print("Error saving context: \(error)")
        }
        tableView.reloadData()
    }
    
    func loadArray() -> [Alarm] {
        let request : NSFetchRequest<Alarm> = Alarm.fetchRequest()
        do {
            return try context.fetch(request)
        } catch {
            print("Error loading alarms: \(error)")
        }
        return []
    }
    
    func updateAlarm(_ updatedAlarm: Alarm) {
        let indexPath = tableView.indexPathForSelectedRow
        tableView.deselectRow(at: indexPath!, animated: true)
        alarmsArray[indexPath!.row] = updatedAlarm
        saveArray()
    }
    
    func deleteAlarm(at index: Int) {
        print("Delete activated")
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [alarmsArray[index].dateCreated!.toString()])
        context.delete(alarmsArray[index])
        alarmsArray.remove(at: index)
        saveArray()
    }
    
    func deleteAllAlarms() {
        guard alarmsArray.count > 0 else {
            print("Alarms array is already empty")
            return
        }
        
        print("Delete All activated")
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        let request: NSFetchRequest<Alarm> = Alarm.fetchRequest()
        request.returnsObjectsAsFaults = false
        do {
            let results = try context.fetch(request)
            for result in results {
                context.delete(result)
            }
        } catch {
            print("Failed to delete all alarms. \(error)")
        }
        
        for index in 0...alarmsArray.count-1 {
            context.delete(alarmsArray[index])
        }
        alarmsArray = []
        saveArray()
    }

     // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "alarmPageSegue" {
            let destVC = segue.destination as! AlarmViewController
            let indexPath = tableView.indexPathForSelectedRow
            destVC.currentAlarm = alarmsArray[indexPath!.row]
        }
    }
    
    // MARK: - Actions
    @IBAction func deleteAllButtonTapped(_ sender: UIButton) {
        deleteAllAlarms()
        print("Deleting All alarms")
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
            deleteAlarm(at: indexPath.row)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "alarmCell") else {
            print("Cannot dequeue alarmCell cell")
            return UITableViewCell()
        }
        cell.textLabel?.text = alarmsArray[indexPath.row].title
        
        cell.detailTextLabel?.text = alarmsArray[indexPath.row].date!.toString()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "alarmPageSegue", sender: self)
    }
}
