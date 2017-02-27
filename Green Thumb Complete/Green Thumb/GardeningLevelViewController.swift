//
//  GardeningLevelViewController.swift
//  Green Thumb
//
//  Created by Jennifer Person on 2/7/17.
//  Copyright © 2017 Jennifer Person. All rights reserved.
//

import UIKit
import CoreData

class GardeningLevelViewController: UIViewController {

    // MARK: - Properties
    
    var managedContext: NSManagedObjectContext!
    var coreDataStack: CoreDataStack!
    var plantsFetch: NSFetchRequest<SavedPlant>!
    
    // MARK: - Outlets
    
    @IBOutlet weak var currentGardeningLevelLabel: UILabel!
    @IBOutlet weak var changeGardeningLevelButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        coreDataStack = appDelegate.coreDataStack
        managedContext = coreDataStack.managedContext
        plantsFetch = SavedPlant.fetchRequest()
        plantsFetch.predicate = NSPredicate(format: "%K == %@", #keyPath(SavedPlant.plantName), "Carrot")

        plantsFetch.returnsObjectsAsFaults = false

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
    }
    
    func loadData() {
        var defaultLabel = "Unable to load gardening level"
        do {
            let results = try managedContext.fetch(plantsFetch)
            if results.count > 0 {
                let plant = results.first
                defaultLabel = plant!.gardeningLevel!

                }

        currentGardeningLevelLabel.text = defaultLabel

        }  catch let error as NSError {
            print("Fetch error: \(error) description: \(error.userInfo)")
        }
        
        print("load data called")
        
    }


    @IBAction func changeLevel(_ sender: Any) {
        UserDefaults.setFirstLaunch()
        Alerts.sharedInstance.showUserPropertyPickerAlert(viewController: self)
        
    }
}
