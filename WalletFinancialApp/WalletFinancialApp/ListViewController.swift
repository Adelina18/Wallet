//
//  ListViewController.swift
//  WalletFinancialApp
//
//  Created by Admin on 7/22/17.
//  Copyright © 2017 Adelina. All rights reserved.
//

import UIKit

enum AddFormType {
    case AddTypeExpense
    case AddTypeIncome
}

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addIncome: UIButton!
    @IBOutlet weak var addExpense: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func addIncomePressed(_ sender: Any) {
        setupAddFormWithType(type: .AddTypeIncome)
    }
    
    @IBAction func addExpensePressed(_ sender: Any) {
        setupAddFormWithType(type: .AddTypeExpense)
    }
    
    // MARK: Table View
    func numberOfSections(in tableView: UITableView) -> Int {
        //number on months
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath) as? ListTableViewCell {
            cell.amount.text = "100"
            return cell
        } else {
            return ListTableViewCell()
        }
    }
    
    func setupAddFormWithType(type: AddFormType) {
        let form = AddIncomeExpense()
        form.frame = CGRect.init(x: 20,
                                 y: 90,
                                 width: UIScreen.main.bounds.size.width - 40,
                                 height: UIScreen.main.bounds.size.height - 110)
        
        if type == .AddTypeExpense {
            
        }
        
        if type == .AddTypeIncome {
            
        }
        
        self.view.addSubview(form)
    }

}
