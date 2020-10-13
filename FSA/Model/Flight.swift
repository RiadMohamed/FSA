//
//  Flight.swift
//  FSA
//
//  Created by Riad Mohamed on 10/4/20.
//  Copyright © 2020 Riad Mohamed. All rights reserved.
//

import Foundation

extension Flight {
    func getTitle() -> String {
        guard let dep = self.departure, let arr = self.arrival else {
            return ""
        }
        if !dep.isEmpty && !arr.isEmpty { return "\(dep) to \(arr)" }
        if dep.isEmpty && !arr.isEmpty { return "\(arr)" }
        if !dep.isEmpty && arr.isEmpty { return "\(dep)" }
        return ""
    }
}
