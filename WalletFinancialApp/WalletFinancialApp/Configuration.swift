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
    static let kInset = 10
    static let kCornerRadius = 20
    static let kNewCategoryFormHeight = 50
    static let kCategoryHeight = 30
    static let kButtonWidth = 30
    
    static let kBorderColor = UIColor.white
    static let kTextColor = UIColor.white
    static let kBackgroundColor = UIColor.black
    static let kYellowColor = UIColor.init(red: 255/255.0, green: 209/255.0, blue: 99/255.0, alpha: 1.0)
    static let kGreenColor = UIColor.init(red: 80/255.0, green: 191/255.0, blue: 36/255.0, alpha: 1.0)
    
    static let sharedInstance = Configuration()
    
    func borderWidth() -> CGFloat {
        return CGFloat(Configuration.kBorderWidth)
    }
    
    func inset() -> CGFloat {
        return CGFloat(Configuration.kInset)
    }
    
    func cornerRadius() -> CGFloat {
        return CGFloat(Configuration.kCornerRadius)
    }
    
    func categoryHeight() -> CGFloat {
        return CGFloat(Configuration.kCategoryHeight)
    }
    
    func newCategoryFormHeight() -> CGFloat {
        return CGFloat(Configuration.kNewCategoryFormHeight)
    }
    
    func buttonWidth() -> CGFloat {
        return CGFloat(Configuration.kButtonWidth)
    }
    
    func borderColor() -> UIColor {
        return Configuration.kBorderColor
    }
    
    func textColor() -> UIColor {
        return Configuration.kTextColor
    }
    
    func backgroundColor() -> UIColor {
        return Configuration.kBackgroundColor
    }
    
    func yellowColor() -> UIColor {
        return Configuration.kYellowColor
    }
    
    func greenColor() -> UIColor {
        return Configuration.kGreenColor
    }

}
