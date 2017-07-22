//
//  DashboardViewController.swift
//  WalletFinancialApp
//
//  Created by Admin on 7/22/17.
//  Copyright © 2017 Adelina. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController {
    
    @IBOutlet weak var currentMonth: UILabel!
    @IBOutlet weak var currentIncome: UILabel!
    @IBOutlet weak var currentExpense: UILabel!
    @IBOutlet weak var currentBallance: UILabel!
    @IBOutlet weak var totalBallance: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        updateValues()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func updateValues() {
        let income = 0.0
        let expense = 0.0
        let ballance = income - expense
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM YYYY"
        let formattedDate = formatter.string(from: date)
        currentMonth.text = formattedDate
        
        currentIncome.text = "\(income)"
        currentExpense.text = "\(expense)"
        
        currentBallance.text = "\(ballance)"
        
        totalBallance.text = "0"
    }

}
