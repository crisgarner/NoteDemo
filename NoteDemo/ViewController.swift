//
//  ViewController.swift
//  NoteDemo
//
//  Created by Cristian Garner on 2/24/15.
//  Copyright (c) 2015 Cristian Garner. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var titleText: UITextField!
    @IBOutlet var noteText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func saveAction(sender: AnyObject) {
        //we check if we already have our identifier, if we do we save a note in parse
        let defaults = NSUserDefaults.standardUserDefaults()
        if let identifier = defaults.stringForKey("UserIdentifier")
        {
            var note = PFObject(className:"Note")
            note["title"] = titleText.text
            note["note"] = noteText.text
            note["UserIdentifier"] = identifier
            note.saveInBackgroundWithBlock {
                (success: Bool, error: NSError!) -> Void in
                if (success) {
                    // The object has been saved.
                    println("Note Saved!")
                } else {
                    // There was a problem, check error.description
                }
            }
        }
        
        
    }
    
    @IBAction func readAction(sender: AnyObject) {
        
    }

}

