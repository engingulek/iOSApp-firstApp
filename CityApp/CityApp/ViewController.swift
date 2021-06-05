//
//  ViewController.swift
//  CityApp
//
//  Created by engin gülek on 5.06.2021.
//

import UIKit
import CoreData
class ViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
 
    
    @IBOutlet weak var tableView: UITableView!
    var nameArray = [String]()
    var idArray = [UUID]()
    var selectedCity = ""
    var selectedCityId : UUID?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate=self
        tableView.dataSource=self
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addCity))
      getAllData()
        
    }
    
    @objc func addCity()
    {
        performSegue(withIdentifier: "toAddCity", sender: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(getAllData), name: NSNotification.Name.init("newData"), object: nil)
    }
    
   
    
    
   @objc func getAllData()  {
    nameArray.removeAll(keepingCapacity: false)
    idArray.removeAll(keepingCapacity: false)
        let appdelegate = UIApplication.shared.delegate as! AppDelegate;
        let context = appdelegate.persistentContainer.viewContext;
      
        
        let fetctRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "City")
        
        fetctRequest.returnsObjectsAsFaults=false;
        
        do{
            let results =   try context.fetch(fetctRequest)
            if results.count > 0
            {
                for result in results as! [NSManagedObject]{
                    if let name = result.value(forKey: "name") as? String
                    {
                        self.nameArray.append(name)
                    }
                    if let id = result.value(forKey: "id") as? UUID{
                        self.idArray.append(id)
                    }
                    
                    self.tableView.reloadData()
                
                }
            }
            
            
        }catch{
            
        }
        
        
      
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = UITableViewCell()
        
        cell.textLabel?.text = nameArray [indexPath.row]
        return cell
    }
    
  
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailsVC" {
            let destionVC = segue.destination as! DetailView
            destionVC.chosenCityId = selectedCityId;
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        selectedCityId = idArray[indexPath.row]
        performSegue(withIdentifier: "toDetailsVC", sender: nil)
       
        
    }
    
 
   
    
  


}

