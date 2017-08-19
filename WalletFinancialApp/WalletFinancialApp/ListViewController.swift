//
//  ListViewController.swift
//  WalletFinancialApp
//
//  Created by Admin on 7/22/17.
//  Copyright © 2017 Adelina. All rights reserved.
//

import UIKit
import CoreData

enum AddFormType {
    case AddTypeExpense
    case AddTypeIncome
}

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate {
    
    @IBOutlet weak var addIncome: UIButton!
    @IBOutlet weak var addExpense: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var fetchedResultsController: NSFetchedResultsController<Expense>!

    var form: FormView? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        fetch()
        setupFormView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        fetchedResultsController = nil
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
        
        form?.amountTextField.text = nil
        form?.titleTextField.text = nil
        form?.detailsTextField.text = nil
        form?.categoryButton.setTitle("Category", for: UIControlState.normal)
    }
    
    
    // MARK: Table View
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if let sections = fetchedResultsController.sections {
            return sections.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = fetchedResultsController.sections {
            let sectionInfo = sections[section]
            return sectionInfo.numberOfObjects
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath) as! ListTableViewCell
        configureCell(cell: cell, indexPath: indexPath as NSIndexPath)
        return cell
    }
    
    func configureCell(cell: ListTableViewCell, indexPath: NSIndexPath) {
        let expense = fetchedResultsController.object(at: indexPath as IndexPath)
        cell.configureCell(expense: expense)
    }
    
    
    // MARK: core data
    
    func fetch() {
        let fetchRequest: NSFetchRequest<Expense> = Expense.fetchRequest()
        
        //sort expenses by date
        let sort = NSSortDescriptor(key: "date", ascending: false)
        fetchRequest.sortDescriptors = [sort]
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                              managedObjectContext: context,
                                                              sectionNameKeyPath: nil,
                                                              cacheName: nil)
        fetchedResultsController.delegate = self
        
        do {
            try fetchedResultsController.performFetch()
        } catch {
            let error = error as NSError
            print("Error: \(error)")
        }
    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
        case .insert:
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .fade)
            }
            break
            
        case .delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            break
            
        case .update:
            if let indexPath = indexPath {
                let cell = tableView.cellForRow(at: indexPath) as! ListTableViewCell
                configureCell(cell: cell, indexPath: indexPath as NSIndexPath)
            }
            break
            
        case .move:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .fade)
            }
            break
        }
    }
}


// MARK: delegates

extension ListViewController: FormViewDelegate {
    
    func didCancel() {
        form?.removeFromSuperview()
    }
    
    func didSave(type: NSString, amount: NSString, title: NSString, details: NSString, category: NSNumber) {
        let expense = Expense(context: context)
        expense.amount = Int16(amount as String)!
        expense.title = title as String
        expense.details = details as String
        expense.date = NSDate()
        expense.id = Int64(NSDate().timeIntervalSince1970)
        expense.type = type as String
        
        //category - fetch category with id        
        let request: NSFetchRequest<Category> = Category.fetchRequest()
        let predicate = NSPredicate.init(format: "id == %@", category)
        request.entity = NSEntityDescription.entity(forEntityName: "Category", in: context)
        request.predicate = predicate
        
        do {
            let categories = try context.fetch(request)
            if categories.count > 0 {
                expense.category = categories[0]
            }
        } catch {
            print("error while fetching category")
        }
        
        appDelegate.saveContext()
        calculateBallance(type: type, amount: Double(amount as String)!)
        form?.removeFromSuperview()
    }
    
    func calculateBallance(type: NSString, amount: Double) {
        var ballance = 0
        if let oldBallance = UserDefaults.standard.value(forKey: "ballance") {
            ballance = oldBallance as! Int
        }
                
        if type == "Expense" {
            ballance -= Int(amount)
        } else {
            ballance += Int(amount)
        }
        
        UserDefaults.standard.set(ballance, forKey: "ballance")
    }
    
}
