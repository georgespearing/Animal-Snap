//
//  ItemStore.swift
//  AnimalSnap
//
//  Created by George Spearing on 10/23/21.
// Class to store all the items created in the views

import UIKit

class AnimalStore {
    
    var allItems = [Animal]()
    	
    let itemArchiveURL: URL = {
        let documentsDirectories =
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentsDirectories.first!
        return documentDirectory.appendingPathComponent("items.plist")
    }()
    
    init(){
        do {
            let data = try Data(contentsOf: itemArchiveURL)
            let unarchiver = PropertyListDecoder()
            let items = try unarchiver.decode([Animal].self, from: data)
            allItems = items
        } catch{
            print("Error reading in saved items: \(error)")
            let newItem = Animal(random: true)
            allItems.append(newItem)
        }
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(saveChanges),
                                       name: UIScene.didEnterBackgroundNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(saveChanges),
                                       name: UIScene.didDisconnectNotification, object: nil)
    }
    
    @discardableResult func createItem() -> Animal {
        let newItem = Animal(random: false)
        allItems.append(newItem)
        
        return newItem
    }
    
    @objc func saveChanges() -> Bool {
        print("Saving Items to: \(itemArchiveURL)")
        do{
            let encoder = PropertyListEncoder()
    //        let data = encoder.encode(allItems)
            let data = try encoder.encode(allItems)
            try data.write(to: itemArchiveURL, options: [.atomic])
            return true
        } catch let encodingError{
            print("Error encoding allItems: \(encodingError)")
            return false
        }
    
    }
    
    func removeItem(_ item: Animal){
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
