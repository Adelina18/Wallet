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
    static let kButtonWidth = 30
    
    static let kBorderColor = UIColor.white
    static let kBackgroundColor = UIColor.black
    
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
    
    func newCategoryFormHeight() -> CGFloat {
        return CGFloat(Configuration.kNewCategoryFormHeight)
    }
    
    func buttonWidth() -> CGFloat {
        return CGFloat(Configuration.kButtonWidth)
    }
    
    func borderColor() -> UIColor {
        return Configuration.kBorderColor
    }
    
    func backgroundColor() -> UIColor {
        return Configuration.kBackgroundColor
    }

}
