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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

// MARK: - TableView Delegate & DataSource Extension
extension AlarmListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // TODO: Set the number of rows to count of the alarms array
        return alarmsArray.count
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
    
    
}
