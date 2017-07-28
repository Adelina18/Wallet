//
//  CategoriesViewController.swift
//  WalletFinancialApp
//
//  Created by Admin on 7/28/17.
//  Copyright © 2017 Adelina. All rights reserved.
//

import UIKit

class CategoriesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    var formMovedUp = false
    
    var form: UIView? = nil
    var categories: NSMutableArray? = nil
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var newCategoryButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
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
        
        let textField = UITextField.init(frame: CGRect.init(x: inset,
                                                            y: inset,
                                                            width: 200,
                                                            height: formHeight - 2 * inset))
        textField.attributedPlaceholder = NSAttributedString(string: "Category",
                                                             attributes: [NSForegroundColorAttributeName: UIColor.white.withAlphaComponent(0.7)])
        textField.backgroundColor = Configuration.sharedInstance.backgroundColor()
        textField.delegate = self
        
        let cancelButton = UIButton.init(frame: CGRect.init(x: formWidth - inset - buttonWidth,
                                                  y: inset,
                                                  width: buttonWidth,
                                                  height: buttonWidth))
        cancelButton.addTarget(self, action:#selector(cancelButtonPressed), for: .touchUpInside)
        cancelButton.layer.cornerRadius = buttonWidth / 2
        cancelButton.backgroundColor = UIColor.green
        
        let okButton = UIButton.init(frame: CGRect.init(x: formWidth - 2 * inset - 2 * buttonWidth,
                                                        y: inset,
                                                        width: buttonWidth,
                                                        height: buttonWidth))
        okButton.addTarget(self, action:#selector(okButtonPressed), for: .touchUpInside)
        okButton.layer.cornerRadius = buttonWidth / 2
        okButton.backgroundColor = UIColor.red
        
        form?.addSubview(textField)
        form?.addSubview(okButton)
        form?.addSubview(cancelButton)
    }
    
    func cancelButtonPressed() {
        moveForm()
        form?.removeFromSuperview()
    }
    
    func okButtonPressed() {
        //save category
        
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
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if categories != nil {
            return (categories?.count)!
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as? CategoryTableViewCell {
            return cell
        } else {
            return CategoryTableViewCell()
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
