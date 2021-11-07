//
//  Item.swift
//  AnimalSnap
//
//  Created by user203264 on 10/23/21.
//

import UIKit


class Item: Equatable, Codable{
    var name: String
    var valueInDollars: Int
//    var serialNumber: String?
    var locationValue: String?
//    let dateCreated: Date
    var textDescription: String?
    let itemKey: String
    
//    required init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//
//        name = try container.decode(String.self, forKey: .name)
//        valueInDollars = try container.decode(Int.self, forKey: .valueInDollars)
//        serialNumber = try container.decode(String?.self, forKey: .serialNumber)
//        dateCreated = try container.decode(Date.self, forKey: .dateCreated)
//        itemKey = UUID().uuidString
//
//
//        let categoryString = try container.decode(String.self, forKey: .category)
//        switch categoryString {
//        case "electronics":
//            category = .electronics
//        case "clothing":
//            category = .clothing
//        case "book":
//            category = .book
//        case "other":
//            category = .other
//        default:
//            category = .other
//        }
//    }

    init(name: String, valueInDollars: Int){
        self.name = name
        self.valueInDollars = valueInDollars
//        self.serialNumber = serialNumber
        self.locationValue = ""
//        self.dateCreated = Date()
        self.textDescription = "Description"
        self.itemKey = UUID().uuidString

    }

//    enum Category {
//        case electronics
//        case clothing
//        case book
//        case other
//    }
//
//    var category = Category.other
//
//    enum CodingKeys: String, CodingKey {
//        case name
//        case valueInDollars
//        case serialNumber
//        case dateCreated
//        case category
//    }
//
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encode(name, forKey: .name)
//        try container.encode(valueInDollars, forKey: .valueInDollars)
//        try container.encode(serialNumber, forKey:  .dateCreated)
//
//        switch category{
//        case .electronics:
//            try container.encode("electronics", forKey: .category)
//
//        case .clothing:
//            try container.encode("clothing", forKey: .category)
//
//        case .book:
//            try container.encode("book", forKey:  .category)
//
//        case .other:
//            try container.encode("other", forKey: .category)
//        }
//    }
    
    
   
    
    convenience init(random: Bool = false){
//        if random{
//            let adjectives = ["Fluffy", "Rusty", "Shiny"]
//            let nouns = ["Bear", "Spork", "Mac"]
//
//            let randomAdjective = adjectives.randomElement()!
//            let randomNoun = nouns.randomElement()!
//
//            let randomName = "\(randomAdjective) \(randomNoun)"
////            let randomValue = Int.random(in: 0..<100)
//            let startValue = 1
////            let randomSerialNumber = UUID().uuidString.components(separatedBy: "-").first!
//            self.init(name: randomName, valueInDollars: startValue)
//
//        } else{
            self.init(name: "[EMPTY]", valueInDollars:1)
//        }
    }
    
    static func == (lhs: Item, rhs: Item) -> Bool {
        return lhs.name == rhs.name &&
        lhs.locationValue == rhs.locationValue &&
        lhs.valueInDollars == rhs.valueInDollars &&
//        lhs.dateCreated == rhs.dateCreated
        lhs.textDescription == rhs.textDescription
    }
    
}
