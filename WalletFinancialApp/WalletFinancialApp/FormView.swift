//
//  FormView.swift
//  WalletFinancialApp
//
//  Created by Admin on 7/22/17.
//  Copyright © 2017 Adelina. All rights reserved.
//

import UIKit
import CoreData

protocol FormViewDelegate: class {
    func didCancel()
}

class FormView: UIView, UITextFieldDelegate {
    
    weak var delegate:FormViewDelegate?
    
    var fetchedResultsController: NSFetchedResultsController<Category>!
    var selectedCategoryId = 0
    
    @IBOutlet weak var formTypeLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var detailsTextField: UITextField!
    @IBOutlet weak var categoryButton: UIButton!
    @IBOutlet weak var dropdown: UIView!
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        saveObject()
        self.delegate?.didCancel()
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        self.delegate?.didCancel()
    }
    
    @IBAction func categoryButtonPressed(_ sender: Any) {
        if dropdown.isHidden {
            dropdown.isHidden = false
        } else {
            dropdown.isHidden = true
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupView() {
        setupButtons()
        setupTextFields()
        setupDropdown()
    }
    
    func fetchCategories() -> [Category] {
        var results = Array<Category>()
        let fetchRequest: NSFetchRequest<Category> = Category.fetchRequest()
        
        let sort = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sort]
        
        do {
            results = try context.fetch(fetchRequest)
        } catch {
            print("Error while fetching categories")
        }
        
        return results
    }
    
    func setupDropdown() {
        let categories = fetchCategories()
        let numberOfCategories = categories.count
        
        dropdown.isHidden = true
        dropdown.layer.borderWidth = 1
        dropdown.layer.borderColor = Configuration.sharedInstance.borderColor().cgColor
        
        let scrollView = UIScrollView.init(frame: CGRect.init(x: 0,
                                                              y: 0,
                                                              width: dropdown.frame.size.width,
                                                              height: dropdown.frame.size.height))
        scrollView.contentSize = CGSize.init(width: scrollView.frame.size.width,
                                             height: CGFloat(numberOfCategories) * Configuration.sharedInstance.categoryHeight())
        
        for i in 0..<categories.count {
            let category = categories[i]
            
            let categoryButton = UIButton.init(frame: CGRect.init(x: 0,
                                                                  y: CGFloat(i) * Configuration.sharedInstance.categoryHeight(),
                                                                  width: scrollView.frame.size.width,
                                                                  height: Configuration.sharedInstance.categoryHeight()))
            categoryButton.tag = Int(category.id)
            categoryButton.setTitle(category.name, for: UIControlState.normal)
            categoryButton.setTitleColor(Configuration.sharedInstance.textColor(),
                                         for: UIControlState.normal)
            categoryButton.layer.borderColor = Configuration.sharedInstance.borderColor().cgColor
            categoryButton.layer.borderWidth = 0.25
            categoryButton.addTarget(self, action:#selector(selectedCategory), for: .touchUpInside)
            
            scrollView.addSubview(categoryButton)
        }
        
        dropdown.addSubview(scrollView)
    }
    
    func setupButtons() {
        saveButton.layer.borderWidth = Configuration.sharedInstance.borderWidth()
        saveButton.layer.borderColor = Configuration.sharedInstance.borderColor().cgColor
        
        cancelButton.layer.borderWidth = Configuration.sharedInstance.borderWidth()
        cancelButton.layer.borderColor = Configuration.sharedInstance.borderColor().cgColor
    }
    
    func setupTextFields() {
        amountTextField.delegate = self
        titleTextField.delegate = self
        detailsTextField.delegate = self
        
        amountTextField.layer.sublayerTransform = CATransform3DMakeTranslation(Configuration.sharedInstance.inset(), 0, 0);
        titleTextField.layer.sublayerTransform = CATransform3DMakeTranslation(Configuration.sharedInstance.inset(), 0, 0);
        detailsTextField.layer.sublayerTransform = CATransform3DMakeTranslation(Configuration.sharedInstance.inset(), 0, 0);
        
        amountTextField.attributedPlaceholder = NSAttributedString(string: "Amount",
                                                                   attributes: [NSForegroundColorAttributeName: UIColor.white.withAlphaComponent(0.7)])
        titleTextField.attributedPlaceholder = NSAttributedString(string: "Title",
                                                                  attributes: [NSForegroundColorAttributeName: UIColor.white.withAlphaComponent(0.7)])
        detailsTextField.attributedPlaceholder = NSAttributedString(string: "Details...",
                                                                    attributes: [NSForegroundColorAttributeName: UIColor.white.withAlphaComponent(0.7)])
    }
    
    func setType(type: AddFormType) {
        setupView()
        
        if type == .AddTypeExpense {
            formTypeLabel.text = "Expense"
            categoryButton.isHidden = false
        }
        
        if type == .AddTypeIncome {
            formTypeLabel.text = "Income"
            categoryButton.isHidden = true
        }
    }
    
    func selectedCategory(sender: UIButton!) {
        selectedCategoryId = sender.tag
        categoryButton.setTitle(sender.titleLabel?.text, for: UIControlState.normal)
        dropdown.isHidden = true
    }
    
    func saveObject() {
        //save to core data
    }
    
    // MARK: textfields
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    

}
