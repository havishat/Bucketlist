//
//  ViewController.swift
//  BucketList
//
//  Created by havisha tiruvuri on 9/11/17.
//  Copyright © 2017 havisha tiruvuri. All rights reserved.
//

import UIKit
import CoreData

class BucketListViewController: UITableViewController, AddItemTableViewControllerDelegate {
    
//    var items = ["Go to the moon", "Eat a candy bar", "Swim in the Amazon", "Rid a motobike in Tokyo"]
    
    var items = [BucketListItem]()
    
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext //scrach pad where we can add and delete stuff
    
    
    override func viewDidLoad() {
      
        super.viewDidLoad()
        fetchAllItems()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "ListItemCell", for: indexPath)
        
    cell.textLabel?.text = items[indexPath.row].text
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected")
    }
    

    @IBAction func addButton(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "EditItemSegue", sender: sender)
        
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let item = items[indexPath.row]
        managedObjectContext.delete(item)
        do {
            try managedObjectContext.save()
        } catch {
            print("\(error)")
        }
        items.remove(at: indexPath.row)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath:IndexPath) {
    
        performSegue(withIdentifier: "EditItemSegue", sender: indexPath)
    
    }
    
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if type(of: sender!) == NSIndexPath.self {
            print(sender!)
            print("2")
            
            let navigationController = segue.destination as! UINavigationController
            let addItemTableViewController = navigationController.topViewController as! AddItemTableViewController
            addItemTableViewController.delegate = self
            
            let indexPath = sender as! NSIndexPath
            
            let item = items[indexPath.row]
            addItemTableViewController.item = item.text!
            addItemTableViewController.indexPath = indexPath

        } else {

            print("1")
            
            let navigationController = segue.destination as! UINavigationController
            let addItemTableViewController = navigationController.topViewController as! AddItemTableViewController
            addItemTableViewController.delegate = self
            
        }
    }
    
    func fetchAllItems() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "BucketListItem")
        do {
            let result = try managedObjectContext.fetch(request)
            items = result as! [BucketListItem]
        } catch {
            print("\(error)")
        }
        
    }
    
    
    func cancelButtonPressed(by controller: AddItemTableViewController){
        print("I'm the hidden controller, But I am responding to the cancel button press on the top view controller.")
        dismiss(animated: true, completion: nil)
    }
    
    func itemSaved(by controller: AddItemTableViewController, with text: String, at indexPath: NSIndexPath?){
        print("Recived Text from top view: \(text)")
        if let ip = indexPath {
            let item = items[ip.row]
            item.text = text
        } else {
            let item = NSEntityDescription.insertNewObject(forEntityName: "BucketListItem", into: managedObjectContext) as! BucketListItem
            item.text = text
            items.append(item)
        }
        
        do {
            try managedObjectContext.save()
        } catch {
            print("\(error)")
        }

        tableView.reloadData()
        dismiss(animated: true, completion: nil)
        
    }
    
//    func addItemTableController(controller: addItemTableController, didFinishAddingItem item: String) {
//        dismiss(animated: ture, completion: nil)
//        items.append(item)
//        tableView.reloadData()
//    }

}

