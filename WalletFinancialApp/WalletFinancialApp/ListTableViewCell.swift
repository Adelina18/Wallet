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
        itemType.text = expense.type == "Expense" ? "-" : "+"
        amount.text = String(expense.amount)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM"
        let string = formatter.string(from: Date())
        date.text = string
        
        category.text = String(describing: expense.category)
    }

}
