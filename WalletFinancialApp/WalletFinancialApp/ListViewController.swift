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
    
    @IBOutlet weak var addIncome: UIButton!
    @IBOutlet weak var addExpense: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var form: FormView? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        setupFormView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func addExpensePressed(_ sender: Any) {
        setupAddFormWithType(type: .AddTypeExpense)
    }
    
    @IBAction func addIncomePressed(_ sender: Any) {
        setupAddFormWithType(type: .AddTypeIncome)
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
            cell.amount.text = "100"//test
            return cell
        } else {
            return ListTableViewCell()
        }
    }
    
    func setupFormView() {
        form = Bundle.main.loadNibNamed("FormView", owner: nil, options: nil)?.first as? FormView
        form?.center = CGPoint(x: self.view.center.x, y: self.view.center.y)
        form?.layer.borderColor = Configuration.sharedInstance.borderColor().cgColor
        form?.layer.borderWidth = Configuration.sharedInstance.borderWidth()
        form?.layer.cornerRadius = Configuration.sharedInstance.cornerRadius()
        
        form?.delegate = self
    }
    
    func setupAddFormWithType(type: AddFormType) {
        self.view.addSubview(form!)
        
        if type == .AddTypeExpense {
            form?.setType(type: .AddTypeExpense)
        }
        
        if type == .AddTypeIncome {
            form?.setType(type: .AddTypeIncome)
        }
    }
}

extension ListViewController: FormViewDelegate {
    
    func didCancel() {
        form?.removeFromSuperview()
    }
    
}
