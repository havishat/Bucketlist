//
//  AdditemTableViewController.swift
//  BucketList
//
//  Created by havisha tiruvuri on 9/11/17.
//  Copyright © 2017 havisha tiruvuri. All rights reserved.
//

import UIKit

class AddItemTableViewController: UITableViewController {
   
    @IBOutlet weak var itemTextField: UITextField!
    weak var delegate: AddItemTableViewControllerDelegate?
    
    var item: String?
    var indexPath: NSIndexPath?
    
//    @IBOutlet weak var itemTextField: UITextField!
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        let text = itemTextField.text!
        delegate?.itemSaved(by: self, with: text, at: indexPath)
    }
    
    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
         delegate?.cancelButtonPressed(by: self)
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        itemTextField.text = item
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


