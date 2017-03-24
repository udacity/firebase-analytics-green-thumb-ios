//
//  PlantObject.swift
//  Green Thumb
//
//  Created by Jennifer Person on 12/2/16.
//  Copyright © 2016 Jennifer Person. All rights reserved.
//

import Foundation
import UIKit
import CoreData


// MARK: - Properties

var currentItemInCart: NSManagedObjectContext!
let checkoutSegue = "checkoutSegue"
let gardeningLevelSegue = "gardeningLevelSegue"
let plantDetailSegue = "plantDetailSegue"
let purchasesSegue = "purchasesSegue"
let shoppingNotificationKey = "com.greenthumb.notificationKey"
let pastPurchasesImage = #imageLiteral(resourceName: "ic_history")
let shoppingCartImage = #imageLiteral(resourceName: "ic_shopping_cart")
let thumbImage = #imageLiteral(resourceName: "ic_thumb_up")

struct PlantObject {
    let name: String
    let details: String
    let price: Int
    
    init(name: String, details: String, price: Int) {
        self.name = name
        self.details = details
        self.price = price
    }
}

// Make a round button
public func configureButton(button: UIButton) {
    button.layer.cornerRadius = 0.5 * button.bounds.size.width
    button.layer.backgroundColor = Colors.darkGreenColor.cgColor
    button.tintColor = Colors.darkGreenColor
    button.imageView?.tintColor = .white
    button.showsTouchWhenHighlighted = true
    button.layer.borderColor = UIColor(red:0.26, green:0.42, blue:0.19, alpha:1.0).cgColor as CGColor
    button.layer.borderWidth = 2.0
    button.clipsToBounds = true
}
