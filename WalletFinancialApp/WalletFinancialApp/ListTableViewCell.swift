//
//  ListTableViewCell.swift
//  WalletFinancialApp
//
//  Created by Admin on 7/22/17.
//  Copyright © 2017 Adelina. All rights reserved.
//

import UIKit

class ListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var itemType: UILabel!
    @IBOutlet weak var amount: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var category: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureCell(expense: Expense) {
        amount.text = "\(String(describing: String(expense.amount.formattedWithSeparator))) RON"
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM"
        let string = formatter.string(from: Date())
        date.text = string
        
        if expense.type == "Expense" {
            itemType.text = "-"
            category.text = expense.category?.name
            
            category.isHidden = false
            category.backgroundColor = UIColor.init(colorLiteralRed: (expense.category?.colorRed)! / 255.0,
                                                    green: (expense.category?.colorGreen)! / 255.0,
                                                    blue: (expense.category?.colorBlue)! / 255.0,
                                                    alpha: 0.8)
        } else {
            itemType.text = "+"
            category.isHidden = true
        }
    }

}
