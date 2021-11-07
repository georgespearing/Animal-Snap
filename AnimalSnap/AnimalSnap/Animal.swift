//
//  Item.swift
//  AnimalSnap
//
//  Created by George Spearing on 10/23/21.
// This is the actual item class. This is where the information is stored

import UIKit


class Animal: Equatable, Codable{
    var name: String
    var valueInDollars: Int
    var locationValue: Date
    var textDescription: String?
    let itemKey: String
    
    init(name: String, valueInDollars: Int){
        self.name = name
        self.valueInDollars = valueInDollars
//        self.serialNumber = serialNumber
        self.locationValue = Date()
//        self.dateCreated = Date()
        self.textDescription = "Description"
        self.itemKey = UUID().uuidString

    }
    
    convenience init(random: Bool = false){
        
        if random{
            let nouns = ["Bear", "Penguin", "Dog"]
                    
            let randomNoun = nouns.randomElement()!
                    
            let randomValue = Int.random(in: 0..<10)

            self.init(name: randomNoun, valueInDollars: randomValue)
        }
        else{
            self.init(name: "[EMPTY]", valueInDollars:1)
        }
    }
    
    static func == (lhs: Animal, rhs: Animal) -> Bool {
        return lhs.name == rhs.name &&
        lhs.locationValue == rhs.locationValue &&
        lhs.valueInDollars == rhs.valueInDollars &&
        lhs.textDescription == rhs.textDescription
    }
    
}
