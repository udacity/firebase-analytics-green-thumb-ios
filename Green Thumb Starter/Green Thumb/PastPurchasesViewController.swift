//
//  PastPurchasesViewController.swift
//  Green Thumb
//
//  Created by Jennifer Person on 1/5/17.
//  Copyright © 2017 Jennifer Person. All rights reserved.
//

import UIKit
import CoreData

class PastPurchasesViewController: UIViewController {

    // MARK: - Properties
    
    let purchasesCell = "purchasesCell"
    var managedContext: NSManagedObjectContext!
    var currentPlant : SavedPlant?
    var allPurchasedPlants: [SavedPlant] = []
    var coreDataStack: CoreDataStack!
    var plantsFetch: NSFetchRequest<SavedPlant>!
    
    // MARK: - Outlets
    
    @IBOutlet weak var purchasesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        coreDataStack = appDelegate.coreDataStack
        managedContext = coreDataStack.managedContext
        
        plantsFetch = SavedPlant.fetchRequest()
        plantsFetch.returnsObjectsAsFaults = false
        loadData()
        
        let shoppingCartButton = UIBarButtonItem(image: shoppingCartImage, style: .plain, target: self, action: #selector(checkoutShoppingCart(sender:)))
        shoppingCartButton.tintColor = Colors.grayColor
        navigationItem.setRightBarButtonItems([shoppingCartButton], animated: true)
    }
    
    func loadData() {
        allPurchasedPlants.removeAll()
        do {
            let results = try managedContext.fetch(plantsFetch)
            if results.count > 0 {
                //allPurchasedPlants = results
                for result in results {
                    if result.numberPlantsPurchased > 0 {
                        allPurchasedPlants.append(result)
                    }
                }
            }
            
        }  catch let error as NSError {
            print("Fetch error: \(error) description: \(error.userInfo)")
        }

        purchasesTableView.reloadData()
    }
    
    func buyItAgain(currentPlant: SavedPlant) {
        currentPlant.numberPlantsSaved += 1

        self.performSegue(withIdentifier: checkoutSegue, sender: self)
    }
    
    func checkoutShoppingCart(sender: AnyObject) {
        performSegue(withIdentifier:checkoutSegue, sender:self)
    }

}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension PastPurchasesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allPurchasedPlants.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: purchasesCell, for: indexPath) as! PurchasesTableViewCell
        currentPlant = allPurchasedPlants[indexPath.item]
        cell.currentPlant = currentPlant
        cell.populatePurchasesCell(currentPlant: currentPlant!)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        currentPlant = allPurchasedPlants[indexPath.item]
        if editingStyle == .delete {
            let plantToRemove = currentPlant
            managedContext.delete(plantToRemove!)
        do {
                try managedContext.save()
                loadData()
            }   catch let error as NSError {
                print("Saving error: \(error), description: \(error.userInfo)")
            }
        }
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {

        currentPlant = allPurchasedPlants[indexPath.item]
        
        let delete = UITableViewRowAction(style: .normal, title: "Delete") { action, index in
            let plantToRemove = self.currentPlant
            self.managedContext.delete(plantToRemove!)
            do {
                try self.managedContext.save()
                self.loadData()
            }   catch let error as NSError {
                print("Saving error: \(error), description: \(error.userInfo)")
            }
        }
        delete.backgroundColor = .red
        
        let buyAgain = UITableViewRowAction(style: .normal, title: "Buy Again") { action, index in
            self.buyItAgain(currentPlant: self.currentPlant!)
        }
        buyAgain.backgroundColor = .blue
        
        return [buyAgain, delete]
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
}
