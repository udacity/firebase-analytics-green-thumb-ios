//
//  GardensTableViewCell.swift
//  Green Thumb
//
//  Created by Jennifer Person on 12/1/16.
//  Copyright © 2016 Jennifer Person. All rights reserved.
//

import Foundation
import Firebase

class PlantsTableViewCell: UITableViewCell {
    
    
    
    static func boundingRect(forText text: String, maxWidth: CGFloat) -> CGRect {
        let attributes = [NSFontAttributeName: PlantsTableViewCell.messageFont]
        let rect = text.boundingRect(with: CGSize(width: maxWidth, height: CGFloat.greatestFiniteMagnitude),
                                     options: [.usesLineFragmentOrigin],
                                     attributes: attributes,
                                     context: nil)
        return rect
    }
    
    static var messageFont: UIFont {
        return UIFont.systemFont(ofSize: UIFont.systemFontSize)
    }
    
    /// Creates variables from the data in the data snapshot to pass into the UITableViewCell
    func showPlant(plantInfo: PlantObject) {
        // pull name of garden from the data snapshot
        let name = plantInfo.name
        
        // populate UITableViewCell with garden name and plants
        populateCellWithGarden(name: name)
    }

    /// Adds the name and plant list to the UITableViewCell
    func populateCellWithGarden(name: String) {
        self.textLabel?.adjustsFontSizeToFitWidth = true
        self.textLabel?.numberOfLines = 0
        self.textLabel?.updateConstraintsIfNeeded()
        self.textLabel?.text = name
        self.imageView?.image = UIImage(named: name)
    }
}

