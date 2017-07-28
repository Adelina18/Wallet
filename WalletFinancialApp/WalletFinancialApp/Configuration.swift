//
//  Configuration.swift
//  WalletFinancialApp
//
//  Created by Admin on 7/27/17.
//  Copyright © 2017 Adelina. All rights reserved.
//

import UIKit

class Configuration: NSObject {
    
    static let kBorderWidth = 2
    static let kTextFieldInset = 10
    static let kCornerRadius = 20
    
    static let kBorderColor = UIColor.white
    
    static let sharedInstance = Configuration()
    
    func borderWidth() -> CGFloat {
        return CGFloat(Configuration.kBorderWidth)
    }
    
    func textFieldInset() -> CGFloat {
        return CGFloat(Configuration.kTextFieldInset)
    }
    
    func cornerRadius() -> CGFloat {
        return CGFloat(Configuration.kCornerRadius)
    }
    
    func borderColor() -> UIColor {
        return Configuration.kBorderColor
    }

}
