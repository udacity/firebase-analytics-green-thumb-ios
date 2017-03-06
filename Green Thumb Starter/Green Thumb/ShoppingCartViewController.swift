//
//  ShoppingCartViewController.swift
//  Green Thumb
//
//  Created by Jennifer Person on 1/3/17.
//  Copyright © 2017 Jennifer Person. All rights reserved.
//

import UIKit
import CoreData
import Firebase

class ShoppingCartViewController: UIViewController {
    
    // MARK: - Properties
    
    let cartCell = "cartCell"
    var managedContext: NSManagedObjectContext!
    var currentPlant : SavedPlant?
    var allSavedPlants: [SavedPlant] = []
    var coreDataStack: CoreDataStack!
    var plantsFetch: NSFetchRequest<SavedPlant>!
    
    // MARK: - Outlets
    
    @IBOutlet weak var continueShoppingButton: UIButton!
    @IBOutlet weak var totalPriceAllItemsLabel: UILabel!
    @IBOutlet weak var itemsInCartTableView: UITableView!
    @IBOutlet weak var purchaseButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.configureTotal), name: Notification.Name(rawValue: shoppingNotificationKey), object: nil)
        
        setNavigationButtons()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        coreDataStack = appDelegate.coreDataStack
        managedContext = coreDataStack.managedContext
        plantsFetch = SavedPlant.fetchRequest()
        plantsFetch.returnsObjectsAsFaults = false
        loadData()
    }
    
    override func viewDidLayoutSubviews() {
        configureButton(button: purchaseButton)
        configureButton(button: continueShoppingButton)
        configureTotal()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadData() {
        allSavedPlants.removeAll()
        do {
            let results = try managedContext.fetch(plantsFetch)
            if results.count > 0 {
                let allPlants = results
                for plant in allPlants {
                    if plant.numberPlantsSaved > 0 {
                        allSavedPlants.append(plant)
                    }
                }
            }
            
        }  catch let error as NSError {
            print("Fetch error: \(error) description: \(error.userInfo)")
        }
        
        itemsInCartTableView.reloadData()
    }
    
    func configureTotal() {
        var total = 0
        
        for plant in allSavedPlants {
            let amount = plant.numberPlantsSaved
            let price = plant.plantPrice
            
            total += Int(amount)*Int(price)
        }
        totalPriceAllItemsLabel.text = total.description
    }
    
    func viewPastPurchases(sender: AnyObject) {
        performSegue(withIdentifier: purchasesSegue, sender: self)
    }
    
    func configureButton(button: UIButton) {
        button.tintColor = Colors.darkGreenColor
        button.setTitleColor(.white, for: .normal)
        button.layer.backgroundColor = Colors.darkGreenColor.cgColor
        button.layer.cornerRadius = 1.0
        button.layer.borderWidth = 1
        button.layer.borderColor = Colors.shadowGreenColor.cgColor
        button.imageView?.tintColor = .white
        button.showsTouchWhenHighlighted = true
        button.setTitleColor(Colors.darkGreenColor, for: .disabled)
    }
    
    func setNavigationButtons() {
        let pastPurchasesButton = UIBarButtonItem(image: pastPurchasesImage, style: .plain, target: self, action: #selector(viewPastPurchases(sender:)))
        pastPurchasesButton.tintColor = Colors.grayColor
        navigationItem.setRightBarButtonItems([pastPurchasesButton], animated: true)
    }
    
    // MARK: - Actions
    
    @IBAction func returnToShopping(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func checkoutCart(_ sender: Any) {
        // dictionary to hold plants purchased and number of plants for logging event
        var plantsPurchased : [String:Int] = [:]
        var plantsRepeatPurchase: [String:Int] = [:]
        
        for plant in allSavedPlants {
            
            plantsPurchased[plant.plantName!] = Int(plant.numberPlantsSaved)
            if  plant.numberPlantsPurchased > 0 {
                plantsRepeatPurchase[plant.plantName!] = Int(plant.numberPlantsSaved)
            }
            plant.numberPlantsPurchased += plant.numberPlantsSaved
            
            // Add plant to list of plants being purchased with the current number of plants that are being purchased
            plantsPurchased[plant.plantName!] = Int(plant.numberPlantsSaved)
            
            plant.numberPlantsSaved = 0
            
        }
        
        do {
            try managedContext.save()
            loadData()
            configureTotal()
        } catch let error as NSError {
            print("Saving error: \(error), description: \(error.userInfo)")
        }
        
        Alerts.showAlert(title: "Done", message: "Purchased Items", viewController: self)
    }
}

// MARK: - UITAbleViewTelegate, UITableViewDataSource

extension ShoppingCartViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if allSavedPlants.count == 0 {
            purchaseButton.isEnabled = false
        } else {
            purchaseButton.isEnabled = true
        }
        return allSavedPlants.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cartCell, for: indexPath) as! CartTableViewCell
        currentPlant = allSavedPlants[indexPath.item]
        cell.currentPlant = currentPlant
        cell.populateCartCell(currentPlant: currentPlant!)
        configureTotal()
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        currentPlant = allSavedPlants[indexPath.item]
        guard let plantToRemove = currentPlant, editingStyle == .delete else { return }
        
        // delete plant and refresh table
        managedContext.delete(plantToRemove)
        do {
            try managedContext.save()
            loadData()
        } catch let error as NSError {
            print("Saving error: \(error), description: \(error.userInfo)")
        }
        configureTotal()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
}
