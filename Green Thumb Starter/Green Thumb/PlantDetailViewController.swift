//
//  PlantDetailViewController.swift
//  Green Thumb
//
//  Created by Jennifer Person on 11/30/16.
//  Copyright © 2016 Jennifer Person. All rights reserved.
//

import UIKit
import Firebase
import CoreData

class PlantDetailViewController: UIViewController {
    
    // MARK: Properties
    
    var plantDescription: String?
    var plantname: String?
    var plantPrice: Int?
    var managedContext: NSManagedObjectContext!
    var currentPlant : SavedPlant?
    var coreDataStack: CoreDataStack!

    
    // MARK: Outlets
    
    @IBOutlet weak var plantName: UILabel!
    @IBOutlet weak var plantDetail: UILabel!
    @IBOutlet weak var addToCartButton: UIButton!
    @IBOutlet weak var plantPriceLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        coreDataStack = appDelegate.coreDataStack
        managedContext = coreDataStack.managedContext
        
        // load plant data
        plantName.text = plantname!
        plantDetail.text = plantDescription!
        plantPriceLabel.text = plantPrice?.description
        let shoppingCartButton = UIBarButtonItem(image: shoppingCartImage, style: .plain, target: self, action: #selector(checkoutShoppingCart(sender:)))
        let pastPurchasesButton = UIBarButtonItem(image: pastPurchasesImage, style: .plain, target: self, action: #selector(viewPastPurchases(sender:)))
        shoppingCartButton.tintColor = Colors.grayColor
        pastPurchasesButton.tintColor = Colors.grayColor
        navigationItem.setRightBarButtonItems([pastPurchasesButton, shoppingCartButton], animated: true)
        
    }
    
    override func viewDidLayoutSubviews() {
        // add shopping cart button to navigation bar
        configureButton(button: addToCartButton)
    }
    
    func checkoutShoppingCart(sender: AnyObject) {
        performSegue(withIdentifier:checkoutSegue, sender:self)
    }
    
    func viewPastPurchases(sender: AnyObject) {
        performSegue(withIdentifier: purchasesSegue, sender: self)
    }
    
    // add one of the plant type to the cart
    func incrementItemInCart() {
        let plantNameToSave = plantname!
        let plantsFetch: NSFetchRequest<SavedPlant> = SavedPlant.fetchRequest()
        plantsFetch.predicate = NSPredicate(format: "%K == %@", #keyPath(SavedPlant.plantName),plantNameToSave)

        do {
            let results = try managedContext.fetch(plantsFetch)
            // if the plant is already saved to cart, add 1 additional plant
            if results.count > 0 {
                currentPlant = results.first
                let currentNumberOfPlants = currentPlant?.numberPlantsSaved
                currentPlant?.numberPlantsSaved = currentNumberOfPlants! + 1
                try managedContext.save()
            } else {
                // add plant to cart with a number of plants of 1
                currentPlant = SavedPlant(context: managedContext)
                currentPlant?.plantName = plantNameToSave
                currentPlant?.numberPlantsSaved = 1
                currentPlant?.plantPrice = Int16(plantPrice!)
                try managedContext.save()
            }
            
        }  catch let error as NSError {
            print("Fetch error: \(error) description: \(error.userInfo)")
        }
    }

    @IBAction func addToCart(_ sender: Any) {
        incrementItemInCart()
        Alerts.showAlert(title: "OK", message: "\(plantname!) Added to Cart", viewController: self)
    }
}







