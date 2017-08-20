//
//  DetailsViewController.swift
//  WalletFinancialApp
//
//  Created by Admin on 8/20/17.
//  Copyright © 2017 Adelina. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
    
    @IBOutlet weak var okButton: UIButton!
    
    @IBAction func okButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    var detailedExpense: Expense?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTitle()
        setupAmount()
        setupDate()
        setupDetails()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func setupExpense(expense: Expense) {
        detailedExpense = expense
    }
    
    func setupTitle() {
        let attributedString = NSMutableAttributedString()

        let attributedTitle = NSMutableAttributedString(string: "Title: ",
                                                        attributes: [NSForegroundColorAttributeName : Configuration.sharedInstance.greenColor()])
        let attributedValue = NSMutableAttributedString(string: (detailedExpense?.title!)!,
                                                        attributes: [NSForegroundColorAttributeName : Configuration.sharedInstance.textColor()])
        
        attributedString.append(attributedTitle)
        attributedString.append(attributedValue)
        
        titleLabel.attributedText = attributedString
    }

    func setupAmount() {
        let attributedString = NSMutableAttributedString()
        
        let attributedTitle = NSMutableAttributedString(string: "Amount: ",
                                                        attributes: [NSForegroundColorAttributeName : Configuration.sharedInstance.greenColor()])
        
        let amount = detailedExpense?.amount.formattedWithSeparator as String!
        let attributedValue = NSMutableAttributedString(string: amount!,
                                                        attributes: [NSForegroundColorAttributeName : Configuration.sharedInstance.textColor()])
        
        attributedString.append(attributedTitle)
        attributedString.append(attributedValue)
        
        amountLabel.attributedText = attributedString
    }
    
    func setupDate() {
        //formatted date
        let attributedString = NSMutableAttributedString()
        
        let attributedTitle = NSMutableAttributedString(string: "Date: ",
                                                        attributes: [NSForegroundColorAttributeName : Configuration.sharedInstance.greenColor()])
        
        let date = detailedExpense?.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        let dateString = dateFormatter.string(from: (date as Date?)!)
        
        let attributedValue = NSMutableAttributedString(string: dateString,
                                                        attributes: [NSForegroundColorAttributeName : Configuration.sharedInstance.textColor()])
        
        attributedString.append(attributedTitle)
        attributedString.append(attributedValue)
        
        dateLabel.attributedText = attributedString
    }
    
    func setupDetails() {
        let attributedString = NSMutableAttributedString()
        
        let attributedTitle = NSMutableAttributedString(string: "Details: ",
                                                        attributes: [NSForegroundColorAttributeName : Configuration.sharedInstance.greenColor()])
       
        var attributedValue: NSMutableAttributedString
        let details = detailedExpense?.details
        if (details?.characters.count)! > 0 {
            attributedValue = NSMutableAttributedString(string: (detailedExpense?.details!)!,
                                                         attributes: [NSForegroundColorAttributeName : Configuration.sharedInstance.textColor()])
        } else {
            attributedValue = NSMutableAttributedString(string: "-",
                                                         attributes: [NSForegroundColorAttributeName : Configuration.sharedInstance.textColor()])
        }
        
        attributedString.append(attributedTitle)
        attributedString.append(attributedValue)
        
        detailsLabel.attributedText = attributedString
    }

}
