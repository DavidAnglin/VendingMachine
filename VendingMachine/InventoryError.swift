//
//  InventoryError.swift
//  VendingMachine
//
//  Created by David Anglin on 4/17/17.
//  Copyright © 2017 Treehouse Island, Inc. All rights reserved.
//

import Foundation

enum InventoryError: Error {
    case invalidResource
    case conversionFailure
    case invalidSelection
}
