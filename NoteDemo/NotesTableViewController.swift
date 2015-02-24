//
//  NotesTableViewController.swift
//  NoteDemo
//
//  Created by Cristian Garner on 2/24/15.
//  Copyright (c) 2015 Cristian Garner. All rights reserved.
//

import UIKit

class NotesTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var notesData = []
    
    @IBOutlet var notesTableView: UITableView!
    override func viewDidLoad() {
        //When the page is loaded we call parse using our identifier and get all the notes, and we save them in our array of notesData
        let defaults = NSUserDefaults.standardUserDefaults()
        if let identifier = defaults.stringForKey("UserIdentifier")
        {
            var query = PFQuery(className:"Note")
            query.whereKey("UserIdentifier", equalTo:identifier)
            query.findObjectsInBackgroundWithBlock {
                (objects: [AnyObject]!, error: NSError!) -> Void in
                if error == nil {
                    self.notesData = objects
                    self.notesTableView.reloadData()
                    // The find succeeded.
                    println(self.notesData)
                } else {
                    // Log details of the failure
                    NSLog("Error: %@ %@", error, error.userInfo!)
                }
            }

        }
                super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //Defines how big is the tableView
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notesData.count
    }
    
    //Asigns a value to each table cell
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //we create a row data with the value of the index on our notes array and then assing the values
        var rowData: AnyObject = self.notesData[indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier("noteIdentifier", forIndexPath: indexPath) as UITableViewCell
        cell.textLabel?.text = (rowData["title"] as String)
        cell.detailTextLabel?.text = (rowData["note"] as String)
        // Configure the cell...
        
        return cell
    }

   
}
