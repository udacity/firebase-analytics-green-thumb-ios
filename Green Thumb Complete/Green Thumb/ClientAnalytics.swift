//
//  ClientAnalytics.swift
//  Green Thumb
//
//  Created by Jennifer Person on 1/9/17.
//  Copyright © 2017 Jennifer Person. All rights reserved.
//

import Firebase

class ClientAnalytics {
    
    // MARK: - Constants
    
    static let paramBuyAgain = "buyAgain"
    static let logItemPurchased = "itemPurchased"
    static let eventPurchaseAgain = "repeat_purchase"
    static let logNumberOfItem = "numberOfItem"
    static let removeFromCart = "remove_from_cart"
    static let gardeningExp = "gardening_experience"
    static let itemCategory = "plants"

    // log when a plant is added to a cart and which plant is added
    static func sendAddToCartEvent(itemAdded: String, buyAgain: Bool) {
        Analytics.logEvent(AnalyticsEventAddToCart, parameters: [AnalyticsParameterItemCategory: itemCategory as NSObject,
            AnalyticsParameterItemID: itemAdded as NSObject])
    }
    
    // log when a plant is selected from the list of plants
    static func sendPlantViewedEvent(itemViewed: String) {
        Analytics.logEvent(AnalyticsEventViewItem, parameters: [AnalyticsParameterItemName: itemViewed as NSObject])
    }
    
    // log when plants are purchased and which plants were purchased and how many of each plant was purchased
    static func sendPurchaseItemsEvent(itemsPurchased: [String: Int]) {
        for item in itemsPurchased {
            Analytics.logEvent(AnalyticsEventEcommercePurchase, parameters: [AnalyticsParameterItemName: item.key as NSObject, AnalyticsParameterValue: item.value as NSObject, AnalyticsParameterCurrency: "XXX" as NSObject])
        }
    }
    
    // log when a user purchases a plant they had purchased in the past
    static func sendPurchaseItemsAgainEvent(itemsPurchased: [String: Int]) {
        for item in itemsPurchased {
            Analytics.logEvent(eventPurchaseAgain, parameters: [logItemPurchased: item.key as NSObject, logNumberOfItem: item.value as NSObject])
        }
    }
    
    // log when a plant is removed from the shopping cart.
    static func sendRemoveFromCartEvent(itemRemoved: String) {
        Analytics.logEvent(removeFromCart, parameters: [AnalyticsParameterItemID: itemRemoved as NSObject])
    }
    
    // log gardening_experience user property
    static func sendUserPropertyGardeningAbility(gardeningExperience: String) {
        Analytics.setUserProperty(gardeningExperience.description, forName: ClientAnalytics.gardeningExp)
    }
    
}
