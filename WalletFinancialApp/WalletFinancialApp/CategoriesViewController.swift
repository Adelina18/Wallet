//
//  CategoriesViewController.swift
//  WalletFinancialApp
//
//  Created by Admin on 7/28/17.
//  Copyright © 2017 Adelina. All rights reserved.
//

import UIKit
import CoreData

class CategoriesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, NSFetchedResultsControllerDelegate {
    
    var formMovedUp = false
    
    var form: UIView? = nil
    var nameTextField: UITextField? = nil
    var categories: NSMutableArray? = nil
    
    var fetchedResultsController: NSFetchedResultsController<Category>!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var newCategoryButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        fetch()
        setupNewCategoryForm()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func newCategoryButtonPressed(_ sender: Any) {
        let inset = Configuration.sharedInstance.inset()
        let y = newCategoryButton.frame.minY - Configuration.sharedInstance.newCategoryFormHeight()
        let formWidth = self.view.frame.size.width - 2 * inset
        let formHeight = Configuration.sharedInstance.newCategoryFormHeight()
        
        form?.frame = CGRect.init(x: inset, y: y, width: formWidth, height: formHeight)
        self.view.addSubview(form!)
    }
    
    func setupNewCategoryForm() {
        let inset = Configuration.sharedInstance.inset()
        let y = newCategoryButton.frame.minY - Configuration.sharedInstance.newCategoryFormHeight()
        let buttonWidth = Configuration.sharedInstance.buttonWidth()
        
        let formWidth = self.view.frame.size.width - 2 * inset
        let formHeight = Configuration.sharedInstance.newCategoryFormHeight()
        
        form = UIView.init(frame: CGRect.init(x: inset, y: y, width: formWidth, height: formHeight))
        form?.backgroundColor = Configuration.sharedInstance.backgroundColor()
        form?.layer.borderWidth = Configuration.sharedInstance.borderWidth()
        form?.layer.borderColor = Configuration.sharedInstance.borderColor().cgColor
        form?.layer.cornerRadius = Configuration.sharedInstance.cornerRadius()
        
        nameTextField = UITextField.init(frame: CGRect.init(x: inset,
                                                            y: inset,
                                                            width: 200,
                                                            height: formHeight - 2 * inset))
        nameTextField?.attributedPlaceholder = NSAttributedString(string: "Category",
                                                             attributes: [NSForegroundColorAttributeName: UIColor.white.withAlphaComponent(0.7)])
        nameTextField?.backgroundColor = Configuration.sharedInstance.backgroundColor()
        nameTextField?.textColor = Configuration.sharedInstance.textColor()
        nameTextField?.delegate = self
        
        let cancelButton = UIButton.init(frame: CGRect.init(x: formWidth - inset - buttonWidth,
                                                  y: inset,
                                                  width: buttonWidth,
                                                  height: buttonWidth))
        cancelButton.addTarget(self, action:#selector(cancelButtonPressed), for: .touchUpInside)
        cancelButton.layer.cornerRadius = buttonWidth / 2
        cancelButton.backgroundColor = UIColor.red
        
        let okButton = UIButton.init(frame: CGRect.init(x: formWidth - 2 * inset - 2 * buttonWidth,
                                                        y: inset,
                                                        width: buttonWidth,
                                                        height: buttonWidth))
        okButton.addTarget(self, action:#selector(okButtonPressed), for: .touchUpInside)
        okButton.layer.cornerRadius = buttonWidth / 2
        okButton.backgroundColor = UIColor.green
        
        form?.addSubview(nameTextField!)
        form?.addSubview(okButton)
        form?.addSubview(cancelButton)
    }
    
    func cancelButtonPressed() {
        moveForm()
        form?.removeFromSuperview()
    }
    
    func okButtonPressed() {
        if (nameTextField?.text?.characters.count)! > 0 {
            let category = Category(context: context)
            category.id = Int64(NSDate().timeIntervalSince1970)
            category.name = nameTextField?.text
            
            appDelegate.saveContext()
        }
        moveForm()
        form?.removeFromSuperview()
    }
    
    func moveForm() {
        let frame = form?.frame
        
        if formMovedUp {
            formMovedUp = false
            form?.frame = CGRect.init(x: (frame?.origin.x)!,
                                      y: (frame?.origin.y)! - 200,
                                      width: (frame?.size.width)!,
                                      height: (frame?.size.height)!)
        } else {
            formMovedUp = true
            form?.frame = CGRect.init(x: (frame?.origin.x)!,
                                      y: (frame?.origin.y)! + 200,
                                      width: (frame?.size.width)!,
                                      height: (frame?.size.height)!)
        }
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! CategoryTableViewCell
        configureCell(cell: cell, indexPath: indexPath as NSIndexPath)
        return cell
    }
    
    func configureCell(cell: CategoryTableViewCell, indexPath: NSIndexPath) {
        let category = fetchedResultsController.object(at: indexPath as IndexPath)
        cell.configureCell(categ: category)
    }
    
    
    // MARK: Core Data
    
    func fetch() {
        let fetchRequest: NSFetchRequest<Category> = Category.fetchRequest()
        
        //sort categories by name
        let sort = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sort]
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                    managedObjectContext: context,
                                                    sectionNameKeyPath: nil,
                                                    cacheName: nil)
        
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
            //created new category
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
                let cell = tableView.cellForRow(at: indexPath) as! CategoryTableViewCell
                configureCell(cell: cell, indexPath: indexPath as NSIndexPath)
            }
            break
            
        case .move:
            //cell dragging
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .fade)
            }
            break
        }
    }
    
    
    // MARK: textview delegate
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        formMovedUp = true
        moveForm()
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        formMovedUp = false
        moveForm()
        textField.resignFirstResponder()
        return true
    }

    

}
