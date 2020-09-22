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
        
        alarmsArray = self.loadArray()
        // Do any additional setup after loading the view.
    }
    
    func deselectRows() {
        if let selectedIndex = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: selectedIndex, animated: true)
        }
    }
    
    func dateToString(for date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        return dateFormatter.string(from: date)
    }
    
    func saveArray() {
        do {
            try context.save()
        } catch {
            print("Error saving context: \(error)")
        }
        tableView.reloadData()
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
    
    func updateAlarm(_ updatedAlarm: Alarm) {
        // TODO: Write the updateAlarm function
        let indexPath = tableView.indexPathForSelectedRow
        tableView.deselectRow(at: indexPath!, animated: true)
        alarmsArray[indexPath!.row] = updatedAlarm
        self.saveArray()
    }
    
    func deleteAlarm(at index: Int) {
        // TODO: Write the deleteAlarm function
        print("Delete activated")
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [dateToString(for: alarmsArray[index].dateCreated!)])
        context.delete(alarmsArray[index])
        alarmsArray.remove(at: index)
        saveArray()
        
    }
    
    func deleteAllAlarms() {
        // TODO: Write the deleteAllAlarms function
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
//            tableView.deselectRow(at: indexPath!, animated: true)
            destVC.currentAlarm = alarmsArray[indexPath!.row]
        }
    }
    
    // MARK: - Actions
    @IBAction func deleteAllButtonTapped(_ sender: UIButton) {
        deleteAllAlarms()
        print("Deleting All alarmsd")
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
        
        // TODO: change the notes to date.
        cell.detailTextLabel?.text = dateToString(for: alarmsArray[indexPath.row].date!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("1: \(indexPath.row)")
        performSegue(withIdentifier: "alarmPageSegue", sender: self)
    }
}
