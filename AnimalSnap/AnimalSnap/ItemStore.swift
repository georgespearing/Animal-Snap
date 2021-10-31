//
//  ItemStore.swift
//  AnimalSnap
//
//  Created by user203264 on 10/23/21.
//

import UIKit

class ItemStore {
    
    var allItems = [Item]()
    
//    init(){
//        for _ in 0..<5{
//            createItem()
//        }
//    }
    
    @discardableResult func createItem() -> Item {
        let newItem = Item(random: true)
        allItems.append(newItem)
        
        return newItem
    }
    
    func removeItem(_ item: Item){
        if let index = allItems.firstIndex(of: item){
            allItems.remove(at: index)
        }
    }
    
    func moveItem(from fromIndex: Int, to toIndex: Int){
        if fromIndex == toIndex{
            return
        }
        
        // get reference to object being moved
        let movedItem = allItems[fromIndex]
        
        // remove item from array
        allItems.remove(at: fromIndex)
        
        // Insert item in array at new location
        allItems.insert(movedItem, at: toIndex)
        
        
    }
    
    
}
