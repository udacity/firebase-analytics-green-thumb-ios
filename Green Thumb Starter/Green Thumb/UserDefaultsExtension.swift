//
//  UserDefaultsExtension.swift
//  Green Thumb
//
//  Created by Jennifer Person on 1/27/17.
//  Copyright © 2017 Jennifer Person. All rights reserved.
//

import Foundation

extension UserDefaults {
    
    // set firstLaunchFlag to nil, which will trigger the pop-up about gardening experience to appear
    static func setFirstLaunch() {
        let firstLaunchFlag = "FirstLaunchFlag"

        UserDefaults.standard.set(nil, forKey: firstLaunchFlag)
        UserDefaults.standard.synchronize()

    }

    // check for is first launch - only true on first invocation after app install, false on all further invocations
    static func isFirstLaunch() -> Bool {
        let firstLaunchFlag = "FirstLaunchFlag"
        let isFirstLaunch = UserDefaults.standard.string(forKey: firstLaunchFlag) == nil
        
        if (isFirstLaunch) {
            UserDefaults.standard.set("false", forKey: firstLaunchFlag)
            UserDefaults.standard.synchronize()
        }
        
        return isFirstLaunch
    }
}
