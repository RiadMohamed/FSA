//
//  AlarmViewController.swift
//  FSA
//
//  Created by Riad Mohamed on 9/18/20.
//  Copyright © 2020 Riad Mohamed. All rights reserved.
//

import UIKit

class AlarmListViewController: UIViewController {
    // MARK: - Outlets & Variables
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
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
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // TODO: Design the alarm cell
        let cell = UITableViewCell()
        return cell
    }
    
    
}
