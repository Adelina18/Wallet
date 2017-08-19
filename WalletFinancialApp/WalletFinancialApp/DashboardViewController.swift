//
//  DashboardViewController.swift
//  WalletFinancialApp
//
//  Created by Admin on 7/22/17.
//  Copyright © 2017 Adelina. All rights reserved.
//

import UIKit
import CoreData

class DashboardViewController: UIViewController {
    
    @IBOutlet weak var currentMonth: UILabel!
    @IBOutlet weak var currentIncome: UILabel!
    @IBOutlet weak var currentExpense: UILabel!
    @IBOutlet weak var currentBallance: UILabel!
    @IBOutlet weak var totalBallance: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        updateValues()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func updateValues() {
        updateCurrentMonth()
        updateCurrentBallance()
        updateTotalBallance()
    }
    
    func updateCurrentMonth() {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM YYYY"
        let formattedDate = formatter.string(from: date)
        currentMonth.text = formattedDate
    }
    
    func updateCurrentBallance() {
        var monthlyIncome = 0
        var monthlyExpense = 0
        
        let currentDate = Date()
        let calendar = NSCalendar.current
        let month = calendar.component(.month, from: currentDate)
        let year = calendar.component(.year, from: currentDate)
        
        let startDateString = "01.\(month).\(year)"
        let endDateString = "31.\(month).\(year)"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        
        let startDate = dateFormatter.date(from: startDateString)
        let endDate = dateFormatter.date(from: endDateString)
        
        //fetch incomes
        let request: NSFetchRequest<Expense> = Expense.fetchRequest()
        var predicate = NSPredicate(format: "(date >= %@) AND (date <= %@) AND type == %@", startDate! as CVarArg, endDate! as CVarArg, "Income")
        request.predicate = predicate
        request.entity = NSEntityDescription.entity(forEntityName: "Expense", in: context)
        
        do {
            let incomes = try context.fetch(request)
            for income in incomes {
                monthlyIncome += Int(income.amount)
            }
        } catch {
            print("could not fetch incomes")
        }


        
        
        //expense for current month
        predicate = NSPredicate(format: "(date >= %@) AND (date <= %@) AND type == %@", startDate! as CVarArg, endDate! as CVarArg, "Expense")
        request.predicate = predicate
        do {
            let expense = try context.fetch(request)
            for exp in expense {
                monthlyExpense += Int(exp.amount)
            }
        } catch {
            print("could not fetch expense")
        }
        
        
        let monthlyBallance = monthlyIncome - monthlyExpense
        
        currentIncome.text = "\(monthlyIncome.formattedWithSeparator) RON"
        currentExpense.text = "\(monthlyExpense.formattedWithSeparator) RON"
        currentBallance.text = "\(monthlyBallance.formattedWithSeparator) RON"
    }
    
    func updateTotalBallance() {
        if let ballance = UserDefaults.standard.value(forKey: "ballance") {
            let ballanceValue = ballance as! Int
            totalBallance.text = "\(ballanceValue.formattedWithSeparator) RON"
        } else {
            totalBallance.text = "0 RON"
        }
    }
}

extension Formatter {
    static let withSeparator: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = " "
        formatter.numberStyle = .decimal
        return formatter
    }()
}

extension Integer {
    var formattedWithSeparator: String {
        return Formatter.withSeparator.string(for: self) ?? ""
    }
}
