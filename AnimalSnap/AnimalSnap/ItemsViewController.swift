//
//  ItemsViewController.swift
//  AnimalSnap
//
//  Created by user203264 on 10/23/21.
//

import UIKit

class ItemsViewController: UITableViewController{
    
    var itemStore: ItemStore!
    var imageStore: ImageStore!
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
        
        navigationItem.leftBarButtonItem = editButtonItem
    }
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
//        tableView.rowHeight = 65
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 65
    }
    
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    @IBAction func addNewItem(_ sender: UIBarButtonItem){
//       // make a new index path for the 0 section, last row

//       // insert this new row into the table
        // Create a new item and add it to the store
        let newItem = itemStore.createItem()
        
        // figure out where that item is in the array
        if let index = itemStore.allItems.firstIndex(of: newItem){
            let indexPath = IndexPath(row: index, section: 0)
            
            // insert this new row into the table
            tableView.insertRows(at: [indexPath], with: .automatic)
            
        }
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        // if the triggered segue is the "showItem" segue
        switch segue.identifier{
        case "showItem":
            // Figure out which row was just tapped
            if let row = tableView.indexPathForSelectedRow?.row{
                // Get the item associated with this row and pass it along
                let item = itemStore.allItems[row]
                let detailViewController = segue.destination as! DetailViewController
                detailViewController.item = item
                detailViewController.imageStore = imageStore
                detailViewController.itemStore = itemStore
            }
        default:
            preconditionFailure("Unexpected segue Identifier")
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return itemStore.allItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
//        // create instance of UITableViewCell with default appearance
        // get a new or recycled cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemCell
        
        // set the text on the cell with the description of the item
        // that is at the nth idex of items, where n = row this cell
        // will appear in on the table view
        let item = itemStore.allItems[indexPath.row]
        
        // configure the cell with the Item
        cell.nameLabel.text=item.name
        cell.locationLabel.text = item.locationValue
        cell.valueLabel.text = "\(item.valueInDollars)"
        if (item.valueInDollars >= 5){
            cell.valueLabel.textColor = UIColor.green
        } else{
            cell.valueLabel.textColor = UIColor.red
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle,
                            forRowAt indexPath: IndexPath){
        // if the table view is asking to commit a delete command
        if editingStyle == .delete{
            let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            
            alertController.modalPresentationStyle = .popover
//            alertController.popoverPresentationController?.barButtonItem = tableView
            
            let deleteAction = UIAlertAction(title: "Delete", style: .default) {_ in
                //            print("Present photo library")
                let item = self.itemStore.allItems[indexPath.row]
                
                // Remove the item from the store
                self.itemStore.removeItem(item)
                
                // remove the item's image from the image store
                self.imageStore.deleteImage(forKey: item.itemKey)
                
                // also remove that row from the table view with an animation
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
            alertController.addAction(deleteAction)

            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alertController.addAction(cancelAction)
            
            
            present(alertController, animated: true, completion: nil)
            
        }

    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath){
        // update the model
        itemStore.moveItem(from: sourceIndexPath.row, to: destinationIndexPath.row)
    }
    
}
