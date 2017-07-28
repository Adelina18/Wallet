//
//  FormView.swift
//  WalletFinancialApp
//
//  Created by Admin on 7/22/17.
//  Copyright © 2017 Adelina. All rights reserved.
//

import UIKit

protocol FormViewDelegate: class {
    func didCancel()
}

class FormView: UIView, UITextFieldDelegate {
    
    weak var delegate:FormViewDelegate?
    
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
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupView() {
        saveButton.layer.borderWidth = Configuration.sharedInstance.borderWidth()
        saveButton.layer.borderColor = Configuration.sharedInstance.borderColor().cgColor
        
        cancelButton.layer.borderWidth = Configuration.sharedInstance.borderWidth()
        cancelButton.layer.borderColor = Configuration.sharedInstance.borderColor().cgColor
        
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
            dropdown.isHidden = false
        }
        
        if type == .AddTypeIncome {
            formTypeLabel.text = "Income"
            categoryButton.isHidden = true
            dropdown.isHidden = true
        }
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
