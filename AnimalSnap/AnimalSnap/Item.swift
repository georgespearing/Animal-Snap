//
//  Item.swift
//  AnimalSnap
//
//  Created by George Spearing on 10/23/21.
// This is the actual item class. This is where the information is stored

import UIKit


class Item: Equatable, Codable{
    var name: String
    var valueInDollars: Int
    var locationValue: String?
    var textDescription: String?
    let itemKey: String
    
    
    convenience init(random: Bool = false){
            self.init(name: "[EMPTY]", valueInDollars:1)

    }
    
    static func == (lhs: Item, rhs: Item) -> Bool {
        return lhs.name == rhs.name &&
        lhs.locationValue == rhs.locationValue &&
        lhs.valueInDollars == rhs.valueInDollars &&
        lhs.textDescription == rhs.textDescription
    }
    
}
