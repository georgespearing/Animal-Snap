//
//  DetailViewController.swift
//  AnimalSnap
//
//  Created by George Spearing on 10/31/21.
//
//  View for the user to edit the contents of the item
//

import UIKit

class DetailViewController: UIViewController, UITextFieldDelegate,
                            UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    
    // MARK: - Initialize
    
    @IBOutlet var nameField: UITextField!
    @IBOutlet var locationField: UIDatePicker!
    @IBOutlet var valueField: UITextField!
    @IBOutlet var descriptionField: UITextView!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var clearImage: UIButton!
    
    var item: Item! {
        didSet{
            navigationItem.title = item.name
            navigationItem.leftBarButtonItem?.title = "back"
        }
    }
    
    var imageStore: ImageStore!
    
    var itemStore: ItemStore!
    
    @IBAction func backgroundTapped(_ sender: UITapGestureRecognizer){
        view.endEditing(true)
    }
    
    @IBAction func choosePhotoSource(_ sender: UIBarButtonItem){
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        alertController.modalPresentationStyle = .popover
        alertController.popoverPresentationController?.barButtonItem = sender
        
        // only show the camera if one exists
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            
            let cameraAction = UIAlertAction(title: "Camera", style: .default) {_ in
                //            print("Present Camera")
                let imagePicker = self.imagePicker(for: .camera)
                self.present(imagePicker, animated: true, completion: nil)
            }
            alertController.addAction(cameraAction)
        }
        
        let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default) {_ in
            //            print("Present photo library")
            let imagePicker = self.imagePicker(for: .photoLibrary)
            imagePicker.modalPresentationStyle = .popover
            imagePicker.popoverPresentationController?.barButtonItem = sender
            self.present(imagePicker, animated: true, completion: nil)
        }
        alertController.addAction(photoLibraryAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    // MARK: - Deleting items and photos
    
    @IBAction func deleteEntry(_ sender: UIBarButtonItem){
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        alertController.modalPresentationStyle = .popover
        alertController.popoverPresentationController?.barButtonItem = sender
        
        let deleteAction = UIAlertAction(title: "Delete", style: .default) {_ in
            //            print("Present photo library")
            
            self.itemStore.removeItem(self.item)
            self.navigationController!.popViewController(animated: true)
        
        
        }
        alertController.addAction(deleteAction)

        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        
        present(alertController, animated: true, completion: nil)
        
    }
    
    @IBAction func deleteImage(_ sender: UIBarButtonItem){
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        alertController.modalPresentationStyle = .popover
        alertController.popoverPresentationController?.barButtonItem = sender
        
        let deleteAction = UIAlertAction(title: "Clear Image", style: .default) {_ in
            self.imageStore.deleteImage(forKey: self.item.itemKey)
            self.imageView.image = nil
            self.clearImage.isHidden = true
            
        
        }
        alertController.addAction(deleteAction)

        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        
        present(alertController, animated: true, completion: nil)
        
    }
    
    // MARK: - Image selection
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // get picked image from info dictionary
        let image = info[.originalImage] as! UIImage
        
        // store the image in the imagestore for the item's key
        imageStore.setImage(image, forKey: item.itemKey)
        
        // put image on the screen in the image view
        imageView.image = image
        
        // take image picker off the screen - you must call this dismiss method
        dismiss(animated: true, completion: nil)
        self.clearImage.isHidden = false
        
    }
    
    func imagePicker(for sourceType: UIImagePickerController.SourceType) -> UIImagePickerController{
        
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        imagePicker.delegate = self
        return imagePicker
    }
    
    // MARK: - View controls
    
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
        
        nameField.text = item.name
        locationField.date = item.locationValue
        valueField.text = "\(item.valueInDollars)"
        descriptionField.text = item.textDescription
        
        
        // get the item key
        let key = item.itemKey
        
        // if three is an associated image with the item, display it on the image view
        if let imageToDisplay = imageStore.image(forKey: key){
            imageView.image = imageToDisplay
            clearImage.isHidden = false
        } else{
            clearImage.isHidden = true
        }
    }
    
    override func viewWillDisappear(_ animated: Bool){
        super.viewWillDisappear(animated)
        
        // clear first responder
        view.endEditing(true)
        
        // "save" changes to item
        item.name = nameField.text ?? ""
//        item.serialNumber = serialNumberField.text
        item.locationValue = locationField.date
        item.textDescription = descriptionField.text
        
        if let valueText = valueField.text,
           let value = numberFormatter.number(from: valueText){
            item.valueInDollars = value.intValue
        } else{
            item.valueInDollars = 0
        }
    }
    
    // MARK: - Formatting
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        return true
    }
    
    let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 3
        return formatter
    }()
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
    
}
