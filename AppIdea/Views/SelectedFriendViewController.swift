//
//  SelectedFriendViewController.swift
//  AppIdea
//
//  Created by Ryan Vanderhoef on 8/11/15.
//  Copyright (c) 2015 Ryan Vanderhoef. All rights reserved.
//

import UIKit
import Parse

class SelectedFriendViewController: UIViewController {
    
    var friend : PFUser?
    var bookSortMain : String = "Title"
    var bookSortSecondary : String = "Author"
    var movieSortMain : String = "Title"
    var movieSortSecondary : String = "Year"
    var gameSortMain : String = "Title"
    var gameSortSecondary : String = "Console"
    
    
    @IBOutlet weak var postTableView: UITableView!
    var posts : [PFObject] = []
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBAction func segmentedControlAction(sender: AnyObject) {
        viewDidLoad()
    }
    
    @IBOutlet weak var friendNameLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
//        println("SelectedFriendViewController viewDidLoad")
//        println("Selected Friend is: \(friend)")
//        println("objtecId is: \(friend?.objectId)")
//        println("Selected Segment: \(segmentedControl.selectedSegmentIndex)")
        
        friendNameLabel.text = friend?.username

        // Do any additional setup after loading the view.
        var userSettingsArray: [SettingsPost] = []
        let settingsQuery = PFQuery(className: "SettingsPost")
        settingsQuery.whereKey("user", equalTo: PFUser.currentUser()!)
        settingsQuery.findObjectsInBackgroundWithBlock{(results: [AnyObject]?, error: NSError?) -> Void in
            userSettingsArray = results as? [SettingsPost] ?? []
            if userSettingsArray.isEmpty == false {
                //                println("settings exist")
                if userSettingsArray[0].BookSort == "Title" {
                    self.bookSortMain = "Title"
                    self.bookSortSecondary = "Author"
                }
                else {
                    self.bookSortMain = "Author"
                    self.bookSortSecondary = "Title"
                }
                if userSettingsArray[0].MovieSort == "Title" {
                    self.movieSortMain = "Title"
                    self.movieSortSecondary = "Year"
                }
                else {
                    self.movieSortMain = "Year"
                    self.movieSortSecondary = "Title"
                }
                if userSettingsArray[0].GameSort == "Title" {
                    self.gameSortMain = "Title"
                    self.gameSortSecondary = "Console"
                }
                else {
                    self.gameSortMain = "Console"
                    self.gameSortSecondary = "Title"
                }
            }
            else {
                //                println("settings don't exist")
            }
            
//            println("sort books by \(self.bookSortMain)")
//            println("sort movies by \(self.movieSortMain)")
//            println("sort games by \(self.gameSortMain)")
            
            
            self.postQueryFunction()
        }
        
//        var postQuery = PFQuery()
//        if segmentedControl.selectedSegmentIndex == 0 {
//            postQuery = PFQuery(className: "BookPost")
//            postQuery.whereKey("user", equalTo: friend!)
//            postQuery.findObjectsInBackgroundWithBlock{(result: [AnyObject]?, error: NSError?) -> Void in
//                self.posts = result as? [BookPost] ?? []
//                self.postTableView.reloadData()
////                println("Results: \(self.posts)")
//            }
//        }
//        else if segmentedControl.selectedSegmentIndex == 1 {
//            postQuery = PFQuery(className: "MoviePost")
//            postQuery.whereKey("user", equalTo: friend!)
//            postQuery.findObjectsInBackgroundWithBlock{(result: [AnyObject]?, error: NSError?) -> Void in
//                self.posts = result as? [MoviePost] ?? []
//                self.postTableView.reloadData()
////                println("Results: \(self.posts)")
//            }
//        }
//        else {
//            postQuery = PFQuery(className: "GamePost")
//            postQuery.whereKey("user", equalTo: friend!)
//            postQuery.findObjectsInBackgroundWithBlock{(result: [AnyObject]?, error: NSError?) -> Void in
//                self.posts = result as? [GamePost] ?? []
//                self.postTableView.reloadData()
////                println("Results: \(self.posts)")
//            }
//        }
        
    }
    
    func postQueryFunction() {
        var postQuery = PFQuery()
        if segmentedControl.selectedSegmentIndex == 0 {
            postQuery = PFQuery(className: "BookPost")
            postQuery.whereKey("user", equalTo: friend!)
            postQuery.orderByAscending(bookSortMain)
            postQuery.addAscendingOrder(bookSortSecondary)
            postQuery.findObjectsInBackgroundWithBlock{(result: [AnyObject]?, error: NSError?) -> Void in
                self.posts = result as? [BookPost] ?? []
                self.postTableView.reloadData()
//                println("Results: \(self.posts[0])")
            }
        }
        else if segmentedControl.selectedSegmentIndex == 1 {
            postQuery = PFQuery(className: "MoviePost")
            postQuery.whereKey("user", equalTo: friend!)
            postQuery.orderByAscending(movieSortMain)
            postQuery.addAscendingOrder(movieSortSecondary)
            postQuery.findObjectsInBackgroundWithBlock{(result: [AnyObject]?, error: NSError?) -> Void in
                self.posts = result as? [MoviePost] ?? []
                self.postTableView.reloadData()
//                println("Results: \(self.posts[0])")
            }
        }
        else {
            postQuery = PFQuery(className: "GamePost")
            postQuery.whereKey("user", equalTo: friend!)
            postQuery.orderByAscending(gameSortMain)
            postQuery.addAscendingOrder(gameSortSecondary)
            postQuery.findObjectsInBackgroundWithBlock{(result: [AnyObject]?, error: NSError?) -> Void in
                self.posts = result as? [GamePost] ?? []
                self.postTableView.reloadData()
//                println("Results: \(self.posts[0])")
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        println("PREPARE FOR SEGUE!!!")
        println("SEGUE IDENTIFIER: \(segue.identifier)")
        
    }
    

}


extension SelectedFriendViewController : UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        println("post count = \(posts.count)")
        return posts.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("FriendPostCell") as! FriendPostTableViewCell
        
        if segmentedControl.selectedSegmentIndex == 0 {
            var newPosts = posts as! [BookPost]
//            println("\(newPosts[0].Title)")
            
            cell.titleLabel.text = "\(newPosts[indexPath.row].Title)"
            cell.extraInfoLabel.text = "\(newPosts[indexPath.row].Author)"
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            
            if newPosts[indexPath.row].Status == "To Read" {
                cell.backgroundColor = UIColor(red: 128/255, green: 128/255, blue: 128/255, alpha: 0.06)
                cell.statusLabel.text = "Wants To Read"
                cell.ratingLabel!.text = ""
            }
            else {
                cell.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.16)
                cell.statusLabel.text = "Has Read"
                var rate = newPosts[indexPath.row].Rating
                if rate == 1      {cell.ratingLabel!.text = "Rating: ★☆☆☆☆"}
                else if rate == 2 {cell.ratingLabel!.text = "Rating: ★★☆☆☆"}
                else if rate == 3 {cell.ratingLabel!.text = "Rating: ★★★☆☆"}
                else if rate == 4 {cell.ratingLabel!.text = "Rating: ★★★★☆"}
                else if rate == 5 {cell.ratingLabel!.text = "Rating: ★★★★★"}
                else              {cell.ratingLabel!.text = "Not Yet Rated"}
            }
            
            
            
            
            
        }
        else if segmentedControl.selectedSegmentIndex == 1 {
            var newPosts = posts as! [MoviePost]
//            println("\(newPosts[0].Title)")
            
            cell.titleLabel.text = "\(newPosts[indexPath.row].Title)"
            cell.extraInfoLabel.text = "\(newPosts[indexPath.row].Year)"
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            
            if newPosts[indexPath.row].Status == "To Watch" {
                cell.backgroundColor = UIColor(red: 128/255, green: 128/255, blue: 128/255, alpha: 0.06)
                cell.statusLabel.text = "Wants To Watch"
                cell.ratingLabel!.text = ""
            }
            else {
                cell.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.16)
                cell.statusLabel.text = "Has Watched"
                var rate = newPosts[indexPath.row].Rating
                if rate == 1      {cell.ratingLabel!.text = "Rating: ★☆☆☆☆"}
                else if rate == 2 {cell.ratingLabel!.text = "Rating: ★★☆☆☆"}
                else if rate == 3 {cell.ratingLabel!.text = "Rating: ★★★☆☆"}
                else if rate == 4 {cell.ratingLabel!.text = "Rating: ★★★★☆"}
                else if rate == 5 {cell.ratingLabel!.text = "Rating: ★★★★★"}
                else              {cell.ratingLabel!.text = "Not Yet Rated"}
            }
            
            
            
            
        }
        else {
            var newPosts = posts as! [GamePost]
//            println("\(newPosts[0].Title)")
            
            cell.titleLabel.text = "\(newPosts[indexPath.row].Title)"
            cell.extraInfoLabel.text = "\(newPosts[indexPath.row].Console)"
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            
            if newPosts[indexPath.row].Status == "To Play" {
                cell.backgroundColor = UIColor(red: 128/255, green: 128/255, blue: 128/255, alpha: 0.06)
                cell.statusLabel.text = "Wants To Play"
                cell.ratingLabel!.text = ""
            }
            else {
                cell.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.16)
                cell.statusLabel.text = "Has Played"
                var rate = newPosts[indexPath.row].Rating
                if rate == 1      {cell.ratingLabel!.text = "Rating: ★☆☆☆☆"}
                else if rate == 2 {cell.ratingLabel!.text = "Rating: ★★☆☆☆"}
                else if rate == 3 {cell.ratingLabel!.text = "Rating: ★★★☆☆"}
                else if rate == 4 {cell.ratingLabel!.text = "Rating: ★★★★☆"}
                else if rate == 5 {cell.ratingLabel!.text = "Rating: ★★★★★"}
                else              {cell.ratingLabel!.text = "Not Yet Rated"}
            }
            
            
            
            
            
        }
        
        
        return cell
    }
}


extension SelectedFriendViewController : UITableViewDelegate {
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
//
//    
////        func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
////            if editingStyle == .Delete {
////                // Get MoviePost(PFObject) of selected cell
////                var delMovie = PFQuery(className: "MoviePost").getObjectWithId(moviePosts[indexPath.row].objectId!) as! MoviePost
////                delMovie.deleteInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
////    //                println("Movie has been deleted.")
////                    self.viewDidAppear(true)
////                }
////            }
////        }
//    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
//        if editingStyle == .Delete {
//            println("deleting")
//            
//        }
//    }

    
//    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        println("seleced row is \(indexPath.row)")
//        
//        let alertController = UIAlertController(title: "Flag Content", message: "Are you sure?", preferredStyle: .Alert)
//        
//        let cancelAction = UIAlertAction(title: "Cancel", style: .Default, handler: nil/*({println("cancel")})*/)
//        alertController.addAction(cancelAction)
//        
//        let flagAction = UIAlertAction(title: "Submit", style: .Default, handler: nil)
//        alertController.addAction(flagAction)
//        
//        presentViewController(alertController, animated: true, completion: nil)
//    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath/*didHighlightRowAtIndexPath*/ indexPath: NSIndexPath) {
//        println("\(posts[indexPath.row])")
        var textTitle : String = ""
        var textMess : String = ""
        var object : String = ""
        if segmentedControl.selectedSegmentIndex == 0 {
            var thisPost = posts[indexPath.row] as! BookPost
            var object = thisPost.objectId
            textTitle = "Flag Book?"
            textMess = "\(thisPost.Title)"
//            println("\(thisPost.Title)")
        }
        else  if segmentedControl.selectedSegmentIndex == 1 {
            var thisPost = posts[indexPath.row] as! MoviePost
            var object = thisPost.objectId
            textTitle = "Flag Movie?"
            textMess = "\(thisPost.Title)"
        }
        else  if segmentedControl.selectedSegmentIndex == 2 {
            var thisPost = posts[indexPath.row] as! GamePost
            var object = thisPost.objectId
            textTitle = "Flag Game?"
            textMess = "\(thisPost.Title)"
        }
        
        let alertController = UIAlertController(title: textTitle, message: textMess, preferredStyle: .Alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Default, handler: {(UIAlertAction) -> Void in
//            println("Canceled Flag Request")
        })
        
        alertController.addAction(cancelAction)
        
        let flagAction = UIAlertAction(title: "Flag", style: .Default, handler: {(UIAlertAction) -> Void in
//            println("Flagging Content")
            var content = FlagPost()
            content.fromUser = PFUser.currentUser()
            if self.segmentedControl.selectedSegmentIndex == 0 {
                content.toBook = self.posts[indexPath.row]
            }
            else if self.segmentedControl.selectedSegmentIndex == 1 {
                content.toMovie = self.posts[indexPath.row]
            }
            else if self.segmentedControl.selectedSegmentIndex == 2 {
                content.toGame = self.posts[indexPath.row]
            }
            content.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
//                println("content flagged!")
            }
        })
        alertController.addAction(flagAction)
        
        presentViewController(alertController, animated: true, completion: nil)
    }

}


