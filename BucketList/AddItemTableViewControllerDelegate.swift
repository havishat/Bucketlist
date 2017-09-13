//
//  AddItemTableViewControllerDelegate.swift
//  BucketList
//
//  Created by havisha tiruvuri on 9/11/17.
//  Copyright © 2017 havisha tiruvuri. All rights reserved.
//

import UIKit

protocol AddItemTableViewControllerDelegate: class {
    func itemSaved(by controller: AddItemTableViewController, with text: String, at indexPath: NSIndexPath?)
    func cancelButtonPressed(by controller: AddItemTableViewController)
}
