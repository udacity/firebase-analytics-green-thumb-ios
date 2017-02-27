//
//  AppDelegate.swift
//  Green Thumb
//
//  Created by Jennifer Person on 11/16/16.
//  Copyright © 2016 Jennifer Person. All rights reserved.
//

import UIKit
import Firebase
import CoreData
import FirebaseDynamicLinks

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    lazy var coreDataStack = CoreDataStack(modelName: "SavedPlants")
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
                FIRApp.configure()
        guard let navController = window?.rootViewController as? UINavigationController,
            let viewController = navController.topViewController as? PlantTableViewController else {
                return true
        }
        
        viewController.managedContext = coreDataStack.managedContext
        return true
    }
    
    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([Any]?) -> Void) -> Bool {
        guard let dynamicLinks = FIRDynamicLinks.dynamicLinks() else {
            return false
        }
        
        if let incomingURL = userActivity.webpageURL {
            let linkHandled = dynamicLinks.handleUniversalLink(incomingURL, completion: { (dynamicLink, error) in
                if let dynamicLink = dynamicLink {
                    self.handleIncomingDynamicLink(dynamicLink: dynamicLink)
                }
            })
            return linkHandled
        }
        return false
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        coreDataStack.saveContext()
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        coreDataStack.saveContext()
    }

    func handleIncomingDynamicLink(dynamicLink: FIRDynamicLink) {
        let lastComponent = dynamicLink.url!.lastPathComponent
        
        if let rowIndex = Int(lastComponent) {

            let currentPlant = plantsArray[rowIndex]
        
            let storyboard = UIStoryboard.init(name: "Main", bundle: nil)

            let viewController = storyboard.instantiateViewController(withIdentifier: "PlantDetail") as! PlantDetailViewController
            viewController.plantname = currentPlant.name
            viewController.plantDescription = currentPlant.details
            viewController.plantPrice = currentPlant.price
            
            let rootViewController = self.window!.rootViewController as! UINavigationController
            rootViewController.pushViewController(viewController, animated: true)

        }
    }
}

