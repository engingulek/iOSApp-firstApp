//
//  DetailView.swift
//  CityApp
//
//  Created by engin gülek on 5.06.2021.
//

import UIKit
import CoreData
class DetailView: UIViewController {
    
    @IBOutlet weak var cityText: UITextField!
    
    
    @IBOutlet weak var countryText: UITextField!
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    @IBOutlet weak var descText: UITextView!
    

    var chosenCityId : UUID?
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate;
        let context  = appDelegate.persistentContainer.viewContext;
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "City")
        let idString = chosenCityId?.uuidString;
        fetchRequest.predicate = NSPredicate(format: "id = %@", idString!)
        
        
        fetchRequest.returnsObjectsAsFaults=false
        
        
        do {
            let results = try context.fetch(fetchRequest)
            if results.count > 0
            {
                for result in results as! [NSManagedObject]{
                    if let name = result.value(forKey: "name") as?  String  {
                        cityText.text=name
                        
                    }
                    if let countryName = result.value(forKey: "country") as? String{
                        countryText.text=countryName;
                        
                    }
                    
                    if let cityDess = result.value(forKey: "cityDes") as? String{
                        descText.text = cityDess
                    }
                    
                    if let image = result.value(forKey: "image") as? Data{
                        let image = UIImage(data: image);
                        imageView.image=image
                    }
                }
            }
        }catch{
            
        }
        


       
        
        
        

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


