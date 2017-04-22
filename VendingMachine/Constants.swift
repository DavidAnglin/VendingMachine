//
//  Constants.swift
//  VendingMachine
//
//  Created by David Anglin on 4/20/17.
//  Copyright © 2017 Treehouse Island, Inc. All rights reserved.
//

import Foundation

struct Constants {
    
    // Title
    static let outOfStock = "Out of Stock"
    static let insufficientFunds = "Insufficient Funds"
    static let invalidSelection = "Invalid Selection"
    
    // Message
    static let outOfStockMessage = "This item is unavailable. Please make another selection."
    static let insufficientFundsMessage = "You need $%\(".2")f to complete the transaction"
    static let invalidSelectionMessage = "Please make another selection"
    
    // Buttons
    static let ok = "OK"
    
    // File
    static let vendingMachine = "VendingInventory"
    static let pList = "plist"
    
    // Reuse Identifiers
    static let vendingItem = "vendingItem"
    
    // Keys
    static let price = "price"
    static let quantity = "quantity"
}
