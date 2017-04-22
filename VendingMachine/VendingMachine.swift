//
//  VendingMachine.swift
//  VendingMachine
//
//  Created by Screencast on 12/6/16.
//  Copyright © 2016 Treehouse Island, Inc. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Vending Selection Enum -
enum VendingSelection: String {
    case soda
    case dietSoda
    case chips
    case cookie
    case sandwich
    case wrap
    case candyBar
    case popTart
    case water
    case fruitJuice
    case sportsDrink
    case gum
    
    func icon() -> UIImage {
        return UIImage(named: self.rawValue) ?? #imageLiteral(resourceName: "default")
    }
}

// MARK: - Protocols -
protocol VendingItem {
    var price: Double { get }
    var quantity: Int { get set }
}

protocol VendingMachine {
    var selection: [VendingSelection] { get }
    var inventory: [VendingSelection: VendingItem] { get set }
    var amountDeposited: Double { get set }
    
    init(inventory: [VendingSelection: VendingItem])
    func vend(selection: VendingSelection, quantity: Int) throws
    func deposit(_ amount: Double)
    func item(forSelection selection: VendingSelection) -> VendingItem?
}

// MARK: - Struct -
struct Item: VendingItem {
    let price: Double
    var quantity: Int
}

// MARK: - Classes -

// Plist Converter
class PlistConverter {
    /// Converts dictionary from a Plist
    static func dictionary(fromFile name: String, ofType type: String) throws -> [String : AnyObject] {
        guard let path = Bundle.main.path(forResource: name, ofType: type) else {
            throw InventoryError.invalidResource
        }
        
        guard let dictionary = NSDictionary(contentsOfFile: path) as? [String : AnyObject] else {
            throw InventoryError.conversionFailure
        }
        
        return dictionary
    }
}

// Inventory Unarchiver
class InventoryUnarchiver {
    /// Returns available inventory
    static func vendingInventory(fromDictionary dictionary: [String : AnyObject]) throws -> [VendingSelection : VendingItem] {
        var inventory: [VendingSelection : VendingItem] = [:]
        
        for (key, value) in dictionary {
            if let itemDictionary = value as? [String : Any], let price = itemDictionary[Constants.price] as? Double, let quantity = itemDictionary[Constants.quantity] as? Int {
                let item = Item(price: price, quantity: quantity)
                
                guard let selection = VendingSelection(rawValue: key) else {
                    throw InventoryError.invalidSelection
                }
                
                inventory.updateValue(item, forKey: selection)
            }
        }
        return inventory
    }
}

// Food Vending Machine
class FoodVendingMachine: VendingMachine {
    let selection: [VendingSelection] = [.soda, .dietSoda, .chips, .cookie, .wrap, .sandwich, .candyBar, .popTart, .water, .fruitJuice, .sportsDrink, .gum]
    var inventory: [VendingSelection : VendingItem]
    var amountDeposited: Double = 10.0
    
    required init(inventory: [VendingSelection : VendingItem]) {
        self.inventory = inventory
    }
    
    /// Handles the vending of the vending machine
    func vend(selection: VendingSelection, quantity: Int) throws {
        guard var item = inventory[selection] else {
           throw VendingMachineError.invalidSelection
        }
        
        guard item.quantity >= quantity else {
            throw VendingMachineError.outOfStock
        }
        
        let totalPrice = item.price * Double(quantity)
        
        if amountDeposited >= totalPrice {
            amountDeposited -= totalPrice
            item.quantity -= quantity
            inventory.updateValue(item, forKey: selection)
        } else {
            let amountRequired = totalPrice - amountDeposited
            throw VendingMachineError.insufficientFunds(required: amountRequired)
        }
    }
    
    /// Handles depositing of money
    func deposit(_ amount: Double) {
        amountDeposited += amount
    }
    
    /// Returns a Vending Item selected
    func item(forSelection selection: VendingSelection) -> VendingItem? {
        return inventory[selection]
    }
    
}










































