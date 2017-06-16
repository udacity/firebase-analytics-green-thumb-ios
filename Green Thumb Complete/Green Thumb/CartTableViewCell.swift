//
//  TableViewCell.swift
//  Green Thumb
//
//  Created by Jennifer Person on 1/3/17.
//  Copyright © 2017 Jennifer Person. All rights reserved.
//

import UIKit
import CoreData

class CartTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    var currentPlant : SavedPlant?
    var pickerData = [1,2,3,4,5,6,7,8,9,10]
    
    // MARK: - Outlets
    
    @IBOutlet weak var creditsSymbolImageView: UIImageView!
    @IBOutlet weak var plantName: UILabel!
    @IBOutlet weak var totalPrice: UILabel!
    @IBOutlet weak var selectNumOfPlantPicker: UIPickerView!
    
    // Update number of plant in cart and price displayed
    func changeItemAmount(row: Int) {
        currentPlant?.numberPlantsSaved = Int16(row)
        let currentPlantNumber = currentPlant?.numberPlantsSaved
        let currentPlantPrice = currentPlant?.plantPrice
        totalPrice.text = String(currentPlantNumber!*currentPlantPrice!)
        NotificationCenter.default.post(name: Notification.Name(rawValue: shoppingNotificationKey), object: nil)
    }
    
    func populateCartCell(currentPlant: SavedPlant) {
        configureLabel(label: plantName)
        configureLabel(label: totalPrice)
        let currentPlantName = currentPlant.plantName ?? "Name Missing"
        let currentPlantNumber = currentPlant.numberPlantsSaved
        let currentPlantPrice = currentPlant.plantPrice
        plantName.text = currentPlantName
        totalPrice.text = String(currentPlantNumber*currentPlantPrice)
        selectNumOfPlantPicker.selectRow(Int((currentPlant.numberPlantsSaved)-1), inComponent: 0, animated: true)
    }
    
    func configureLabel(label: UILabel) {
        label.font = UIFont(descriptor: UIFontDescriptor(name: "Roboto", size: 18), size: 18)
        label.textColor = Colors.darkGreenColor
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        creditsSymbolImageView.tintColor = Colors.darkGreenColor
        guard let superview = contentView.superview else {
            return
        }
        for subview in superview.subviews {
            if String(describing: type(of: subview)).hasSuffix("SeparatorView") {
                subview.isHidden = false
            }
        }
    }
}

// MARK: - UIPickerViewDelegate, UIPickerViewDataSource

extension CartTableViewCell: UIPickerViewDelegate, UIPickerViewDataSource {
    
    //MARK: - Data Sources
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    //MARK: - Delegates
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(pickerData[row]+1)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        changeItemAmount(row: pickerData[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 25
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 25
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var pickerLabel = view as! UILabel!
        
        if view == nil {
            pickerLabel = UILabel()
            pickerLabel?.backgroundColor = .gray
            pickerLabel?.textColor = .white
            pickerLabel?.layer.borderWidth = 3
            pickerLabel?.layer.borderColor = UIColor.black.cgColor
        }
        
        let titleData = pickerData[row]
        pickerLabel?.text = titleData.description
        pickerLabel!.textAlignment = .center
        return pickerLabel!
    }
    
}
