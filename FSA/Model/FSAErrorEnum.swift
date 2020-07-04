//
//  FSAErrorEnum.swift
//  FSA
//
//  Created by Riad Mohamed on 7/2/20.
//  Copyright © 2020 Riad Mohamed. All rights reserved.
//

import Foundation

enum FSAError: Error {
    case gettingCoordinatesError
    case parseLocationCoordinatesError
}

enum State {
    case idle
    case waitingForCoordinates
    case waitingForUNIXTime
    case waitingForUNIXParse
}
