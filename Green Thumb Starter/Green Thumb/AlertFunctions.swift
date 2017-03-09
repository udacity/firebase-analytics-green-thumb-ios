
//
//  AlertFunctions.swift
//  Green Thumb
//
//  Created by Jennifer Person on 1/27/17.
//  Copyright © 2017 Jennifer Person. All rights reserved.
//

import Foundation
import UIKit
import CoreData

let gardeningLevelUserProperty = ["level_1", "level_2", "level_3", "level_4", "level_5"]
let gardeningLevelDescription = ["Never", "About Once a Year", "About Once a Month", "About Once a Week", "About Every Day", "Ask Again Later"]

class Alerts {

    // MARK: - Properties
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var coreDataStack : CoreDataStack!
    var managedContext: NSManagedObjectContext!
    var plantsFetch: NSFetchRequest<SavedPlant>!
    static let sharedInstance = Alerts()
    var gardeningFrequecy: SavedPlant?
    var hasGardeningFrequency = false
    
    // Standard Alert
    static func showAlert(title: String, message: String, viewController: AnyObject) {
    
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: title, style: .default, handler: { action in
        alert.dismiss(animated: true, completion: nil)
        }))
    
        viewController.present(alert, animated: true, completion: nil)
    }

    func saveExperience(currentGardeningFrequency: String, callingVC: AnyObject?) {
        
        do {
            print("plant name \(gardeningFrequecy?.plantName)")
            gardeningFrequecy!.gardeningLevel = currentGardeningFrequency
            print("garden frequency \(gardeningFrequecy!.gardeningLevel)")
            try managedContext.save()
        } catch let error as NSError {
            print("Saving error: \(error), description: \(error.userInfo)")
        }
        
        if let gardeningVC = callingVC as? GardeningLevelViewController {
            gardeningVC.loadData()
        }
        
    }
    
// Special alert for user property upon first launching app
 func showUserPropertyPickerAlert(viewController: AnyObject) {
    let isFirstLaunch = UserDefaults.isFirstLaunch()
    
    if isFirstLaunch {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        coreDataStack = appDelegate.coreDataStack
        self.managedContext = coreDataStack.managedContext
        plantsFetch = SavedPlant.fetchRequest()
        plantsFetch.predicate = NSPredicate(format: "%K == %@", #keyPath(SavedPlant.plantName), "Carrot")
        plantsFetch.returnsObjectsAsFaults = false
        
        do {
            let results = try self.managedContext.fetch(self.plantsFetch)
            if results.count > 0 {
                gardeningFrequecy = results.first
                print("plant pulled from core data \(gardeningFrequecy!.plantName)")
                print("freqnecy pulled from core data \(gardeningFrequecy!.gardeningLevel)")
                hasGardeningFrequency = true
            } else {
                gardeningFrequecy = SavedPlant(context: managedContext)
                gardeningFrequecy!.plantName = "Carrot"
                hasGardeningFrequency = false
            }
            
        }  catch let error as NSError {
            print("Fetch error: \(error) description: \(error.userInfo)")
        }
        
        let alert = UIAlertController(title: "My Gardening Profile", message: "How Often Do You Garden?", preferredStyle: .alert)
        
        let oneAction = UIAlertAction(title: gardeningLevelDescription[0], style: .default) { _ in
            self.saveExperience(currentGardeningFrequency: gardeningLevelDescription[0], callingVC: viewController)
        }
        let twoAction = UIAlertAction(title: gardeningLevelDescription[1], style: .default) { _ in
            self.saveExperience(currentGardeningFrequency: gardeningLevelDescription[1], callingVC: viewController)
        }
        
        let threeAction = UIAlertAction(title: gardeningLevelDescription[2], style: .default) { _ in
            self.saveExperience(currentGardeningFrequency: gardeningLevelDescription[2], callingVC: viewController)
        }
        
        let fourAction = UIAlertAction(title: gardeningLevelDescription[3], style: .default) { _ in
            self.saveExperience(currentGardeningFrequency: gardeningLevelDescription[3], callingVC: viewController)
        }
        
        let fiveAction = UIAlertAction(title: gardeningLevelDescription[4], style: .default) { _ in
            self.saveExperience(currentGardeningFrequency: gardeningLevelDescription[4], callingVC: viewController)
        }
        
        let cancelAction = UIAlertAction(title: gardeningLevelDescription[5], style: .cancel) { _ in
            UserDefaults.setFirstLaunch()
        }
        
        alert.addAction(oneAction)
        alert.addAction(twoAction)
        alert.addAction(threeAction)
        alert.addAction(fourAction)
        alert.addAction(fiveAction)
        alert.addAction(cancelAction)
        
        viewController.present(alert, animated: true, completion: nil)
    }
}
}
