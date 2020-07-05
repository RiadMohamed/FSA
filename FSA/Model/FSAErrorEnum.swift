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
    case creatingURLError
    case networkingError
    case unwrappingNetworkingDataError
}

enum State {
    case idle
    case gettingCoordinates
    case gettingUnixTime
    case formattingUnixTime
}
