//
//  Alarm.swift
//  FSA
//
//  Created by Riad Mohamed on 9/28/20.
//  Copyright © 2020 Riad Mohamed. All rights reserved.
//

import Foundation
import UserNotifications

extension Alarm {
    func addNotification(_ title: String?, _ notes: String? = "") {
        let content = UNMutableNotificationContent()
        content.title = title!
        content.sound = .default
        content.body = notes!
        content.badge = 1
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year,.month,.day, .hour, .minute], from: self.date!)
        print(components)
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
//        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let request = UNNotificationRequest(identifier: self.dateCreated!.toString(), content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { (error) in
            if error != nil {
                print("Error creating the alarm notifcation. \(error!)")
            }
        }
    }
    
    func updateNotification(_ title: String?, _ notes: String? = "") {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [self.dateCreated!.toString()])
        self.addNotification(title)
    }
    
    
}
