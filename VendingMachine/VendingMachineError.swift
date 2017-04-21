//
//  VendingMachineError.swift
//  VendingMachine
//
//  Created by David Anglin on 4/19/17.
//  Copyright © 2017 Treehouse Island, Inc. All rights reserved.
//

import Foundation

enum VendingMachineError: Error {
    case invalidSelection
    case outOfStock
    case insufficientFunds(required: Double)
}
