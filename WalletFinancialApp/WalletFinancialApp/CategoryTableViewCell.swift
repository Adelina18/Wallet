//
//  CategoryTableViewCell.swift
//  WalletFinancialApp
//
//  Created by Admin on 7/28/17.
//  Copyright © 2017 Adelina. All rights reserved.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var category: UILabel!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!

    @IBAction func editButtonPressed(_ sender: Any) {
    }
    
    @IBAction func deleteButtonPressed(_ sender: Any) {
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
