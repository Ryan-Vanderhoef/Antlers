//
//  SettingsViewController.swift
//  AppIdea
//
//  Created by Ryan Vanderhoef on 7/23/15.
//  Copyright (c) 2015 Ryan Vanderhoef. All rights reserved.
//

import UIKit
import Parse
//import Realm

class SettingsViewController: UIViewController {
    
//    var pref = Preferences()
    
//    var orderBookFirst: String = "Title"
//    var orderBookSecond: String = "Author"
    
//    var orderMovieFirst: String 
//    var orderMovieSecond: String
//    
//    var orderGameFirst: String
//    var OrderGameSecond: String
    
    var userSettings : [SettingsPost] = []
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var tabBarSegmentedControl: UISegmentedControl!
    
    
    @IBOutlet weak var bookOrderSegmentedControl: UISegmentedControl!
    @IBAction func bookOrderSegmentedControlAction(sender: AnyObject) {
        if bookOrderSegmentedControl.selectedSegmentIndex == 0 {
//            self.orderBookFirst = "Title"
//            self.orderBookSecond = "Author"
//            pref.orderBookFirst = "Title"
//            pref.orderBookSecond = "Author"
        }
        else {
//            pref.orderBookFirst = "Author"
//            pref.orderBookSecond = "Title"
//            self.orderBookFirst = "Author"
//            self.orderBookSecond = "Title"
        }
    }
    
    @IBOutlet weak var movieOrderSegmentedControl: UISegmentedControl!
    
    
    @IBOutlet weak var gameOrderSegmentedControl: UISegmentedControl!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameLabel.text = "Username: \((PFUser.currentUser()!.username)!)"
        
        let settingsQuery = PFQuery(className: "SettingsPost")
        settingsQuery.whereKey("user", equalTo: PFUser.currentUser()!)
        settingsQuery.findObjectsInBackgroundWithBlock{(results: [AnyObject]?, error: NSError?) -> Void in
//            println("results: \(results!)")
            
            
            if results?.isEmpty == true {
//                println("No settings for current user")
                let newSettings = PFObject(className: "SettingsPost")
                newSettings["BookSort"] = "Title"
                newSettings["MovieSort"] = "Title"
                newSettings["GameSort"] = "Title"
                newSettings["user"] = PFUser.currentUser()
                newSettings.saveInBackgroundWithBlock{(success: Bool, error: NSError?) -> Void in
//                    println("saving newsettings")
                    self.viewDidLoad()
                }
            }
            else {
                self.userSettings = results as? [SettingsPost] ?? []
            }
//            println("\(self.userSettings)")
            if self.userSettings.isEmpty == false {
                if self.userSettings[0].BookSort == "Title" {
                    self.bookOrderSegmentedControl.selectedSegmentIndex = 0;
                }
                else {
                    self.bookOrderSegmentedControl.selectedSegmentIndex = 1;
                }
                
                if self.userSettings[0].MovieSort == "Title" {
                    self.movieOrderSegmentedControl.selectedSegmentIndex = 0;
                }
                else {
                    self.movieOrderSegmentedControl.selectedSegmentIndex = 1;
                }
                
                if self.userSettings[0].GameSort == "Title" {
                    self.gameOrderSegmentedControl.selectedSegmentIndex = 0;
                }
                else {
                    self.gameOrderSegmentedControl.selectedSegmentIndex = 1;
                }
            }
            
        }
        
        
        
        

        // Do any additional setup after loading the view.
    }

    @IBAction func LogOutButtonAction(sender: AnyObject) {
//        println("logout is happening")
//        PFUser.logOutInBackgroundWithBlock({
//            (Error: NSError?) -> Void in
//            println("logging out")
//            // Segue to login view
//            println("made it here")
//        
//        })
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func unwindToSegueSettings(segue: UIStoryboardSegue) {
//        println("unwindToSegueSettings")
    }
    
    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
//        println("here \(segue.identifier)")
        if segue.identifier == "Done" {
            println("The Done Button was pressed")
            
            if self.bookOrderSegmentedControl.selectedSegmentIndex == 0 {
                self.userSettings[0].BookSort = "Title"
            }
            else {
                self.userSettings[0].BookSort = "Author"
            }
            
            if self.movieOrderSegmentedControl.selectedSegmentIndex == 0 {
                self.userSettings[0].MovieSort = "Title"
            }
            else {
                self.userSettings[0].MovieSort = "Year"
            }
            
            if self.gameOrderSegmentedControl.selectedSegmentIndex == 0 {
                self.userSettings[0].GameSort = "Title"
            }
            else {
                self.userSettings[0].GameSort = "Console"
            }
            
            self.userSettings[0].saveInBackgroundWithBlock{(success: Bool, error: NSError?) -> Void in
                println("settings saved")
            }
            
        }
//        println("SETTINGS PREPAREFORSEGUE")
        if segue.identifier == "LogOutSegue" {
//                println("logout is happening")
                PFUser.logOutInBackgroundWithBlock({
                    (Error: NSError?) -> Void in
//                    println("logging out")
                    // Segue to login view
//                    println("made it here")
                
                })
        }
//        println("LOGOUT DONE?")
    }


}
