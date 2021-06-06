//
//  AddCity.swift
//  CityApp
//
//  Created by engin gülek on 5.06.2021.
//

import UIKit
import CoreData

class AddCity: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var cityNameText: UITextField!
    @IBOutlet weak var countryNameText: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        
        imageView.isUserInteractionEnabled=true;
        let imageGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectImage))
        view.addGestureRecognizer(imageGestureRecognizer)
        saveButton.isEnabled=false;
        
    }
    
    @objc func selectImage() {
        
        //-- seçmek için resme basıp galerinin açılmasına kadar gerçekleşen olay
        let picker = UIImagePickerController()
        picker.delegate=self;
        picker.sourceType = .photoLibrary;
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
        //--
        
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.originalImage] as? UIImage
        saveButton.isEnabled=true
        self.dismiss(animated: true, completion: nil)
    }
    

    @IBAction func saveClicked(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate;
        let context = appDelegate.persistentContainer.viewContext;
        let newCity = NSEntityDescription.insertNewObject(forEntityName: "City", into: context)
        
        newCity.setValue(cityNameText.text!, forKey: "name")
        newCity.setValue(countryNameText.text!, forKey: "country")
        newCity.setValue(descriptionTextView.text!, forKey: "cityDes")
        newCity.setValue(UUID(), forKey: "id")
        let imageData = imageView.image?.jpegData(compressionQuality: 0.5)
        newCity.setValue(imageData, forKey: "image")
      
           
        do{
            try context.save()
        }catch{
            print("Error")
        }
        
        NotificationCenter.default.post(name: NSNotification.Name("newData"), object: nil)
        self.navigationController?.popViewController(animated: true)
    
        
    }
    

}
