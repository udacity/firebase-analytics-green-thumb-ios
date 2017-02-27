//
//  PurchasesTableViewCell.swift
//  Green Thumb
//
//  Created by Jennifer Person on 1/6/17.
//  Copyright © 2017 Jennifer Person. All rights reserved.
//

import UIKit
import CoreData

class PurchasesTableViewCell: UITableViewCell {

    // MARK: - Properties
    
    var currentPlant : SavedPlant?
    
    // MARK: - Outlets
    
    @IBOutlet weak var amountOfPlantPurchased: UILabel!
    @IBOutlet weak var plantNameLabel: UILabel!

    // add one of the plant type to the cart
    func incrementItemInCart() {
        currentPlant?.numberPlantsSaved += 1

    }
    
    func populatePurchasesCell(currentPlant: SavedPlant) {
        let currentPlantName = currentPlant.plantName ?? "Name Missing"
        let currentPlantNumber = currentPlant.numberPlantsPurchased
        amountOfPlantPurchased.text = currentPlantNumber.description
        plantNameLabel.text = currentPlantName
    }

}
