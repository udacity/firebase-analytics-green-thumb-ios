//
//  ViewController.swift
//  Green Thumb
//
//  Created by Jennifer Person on 11/16/16.
//  Copyright © 2016 Jennifer Person. All rights reserved.
//

import UIKit
import Firebase
import CoreData

    typealias Payload = [String: AnyObject]

class PlantTableViewController: UIViewController {

    // MARK: Properties

    let plantCell = "plantCell"
    var managedContext: NSManagedObjectContext!
    var currentPlant : SavedPlant?
    var plantDescriptionsValue: String?
    let plantDescriptions = "plant_descriptions"
    var remoteConfig: FIRRemoteConfig!
    let basicConfig = "basic"
    let advancedConfig = "advanced"
    
    // MARK: Outlets
    
    @IBOutlet weak var plantsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Alerts.sharedInstance
            .showUserPropertyPickerAlert(viewController: self)
        
        setNavigationButtons()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        plantsTableView.reloadData()
    }
    
    override func viewDidLayoutSubviews() {

        self.title = "Green Thumb"
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: Colors.grayColor,
                                                                        NSFontAttributeName: UIFont(descriptor:UIFontDescriptor(name: "Roboto", size: 12), size: 24)]
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == plantDetailSegue) {
            guard let controller = segue.destination as? PlantDetailViewController else { return }
            let plantDetail = plantsArray[(self.plantsTableView.indexPathForSelectedRow?.item)!]
            controller.plantDescription = plantDetail.details
            controller.plantname = plantDetail.name
            controller.plantPrice = plantDetail.price
        }
    }
    
    func setNavigationButtons() {
        let shoppingCartButton = UIBarButtonItem(image: shoppingCartImage, style: .plain, target: self, action: #selector(checkoutShoppingCart(sender:)))
        let pastPurchasesButton = UIBarButtonItem(image: pastPurchasesImage, style: .plain, target: self, action: #selector(viewPastPurchases(sender:)))
        let currentGardeningLevelButton = UIBarButtonItem(image: thumbImage , style: .plain, target: self, action: #selector(viewCurrentGardeningLevel(sender:)))
        shoppingCartButton.tintColor = Colors.grayColor
        pastPurchasesButton.tintColor = Colors.grayColor
        currentGardeningLevelButton.tintColor = Colors.grayColor
        navigationItem.setRightBarButtonItems([pastPurchasesButton, shoppingCartButton], animated: true)
        navigationItem.setLeftBarButtonItems([currentGardeningLevelButton], animated: true)
        navigationController?.navigationBar.tintColor = Colors.grayColor
    }
    
    func checkoutShoppingCart(sender: AnyObject) {
        performSegue(withIdentifier:checkoutSegue, sender:self)
    }
    
    func viewPastPurchases(sender: AnyObject) {
        performSegue(withIdentifier: purchasesSegue, sender: self)
    }
    
    func viewCurrentGardeningLevel(sender: AnyObject) {
        performSegue(withIdentifier: gardeningLevelSegue, sender: self)
    }
}

// MARK: - FrontPageController: UITableViewDelegate, UITableViewDataSource

extension PlantTableViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return plantsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: plantCell, for: indexPath) as! PlantsTableViewCell
        let currentPlant = plantsArray[indexPath.item]
        
        // populate cell with plant info
        cell.showPlant(plantInfo: currentPlant)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: plantDetailSegue, sender: indexPath)
    }
}


