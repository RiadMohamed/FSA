//
//  Date.swift
//  FSA
//
//  Created by Riad Mohamed on 9/28/20.
//  Copyright © 2020 Riad Mohamed. All rights reserved.
//

import Foundation

extension Date {
    func toString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        return dateFormatter.string(from: self)
    }
}
