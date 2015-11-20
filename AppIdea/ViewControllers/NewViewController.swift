//
//  NewViewController.swift
//  AppIdea
//
//  Created by Ryan Vanderhoef on 7/29/15.
//  Copyright (c) 2015 Ryan Vanderhoef. All rights reserved.
//

import UIKit
import Parse
import ParseUI







class NewViewController: UIViewController, PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate {
    
    var logInViewController = MyPFLogInViewController() //PFLogInViewController()
    var signUpViewController = MyPFSignUpViewController() //PFSignUpViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        
//        println("view appeared NEWVIEWCONTROLLER")
        
//        println("\(PFUser.currentUser())")
        
                if PFUser.currentUser() == nil {
        
//                   var logInViewController = MyPFLogInViewController() //PFLogInViewController()
                    logInViewController.delegate = self
//                    var signUpViewController = MyPFSignUpViewController() //PFSignUpViewController()
                    signUpViewController.delegate = self
        
                    logInViewController.signUpController = signUpViewController
                    logInViewController.fields = (PFLogInFields.UsernameAndPassword
                        | PFLogInFields.LogInButton
                        | PFLogInFields.SignUpButton
                        | PFLogInFields.PasswordForgotten
                        /*| PFLogInFields.DismissButton*/
                        /*| PFLogInFields.Facebook*/)
                    
                    self.presentViewController(logInViewController, animated: true, completion: nil)
        
        
                }
                else {
                    
                    // Present BooksViewController if User is already Logged In
//                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
//                    let BooksViewController = storyboard.instantiateViewControllerWithIdentifier("BooksViewController") as! UIViewController
//                    self.presentViewController(BooksViewController, animated:true, completion:nil)
                    
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let tabBarController = storyboard.instantiateViewControllerWithIdentifier("TabBarController") as! UIViewController
                    // 3
                    //                    self.window?.rootViewController!.presentViewController(tabBarController, animated:true, completion:nil)
                    self.presentViewController(tabBarController, animated:true, completion:nil)
                }
        
    }
    
    func logInViewController(logInController: PFLogInViewController, shouldBeginLogInWithUsername username: String, password: String) -> Bool {
        
        if (!username.isEmpty || !password.isEmpty) {
//            println("done with shouldBeginLogInWithUsername true")
            
            
            return true
        }
        else {
//            println("done with shouldBeginLogInWithUsername false")
            
            return false
        }
        
    }
    
    func logInViewController(logInController: PFLogInViewController, didLogInUser user: PFUser) {
//        println("didLogInUser")
        self.dismissViewControllerAnimated(true, completion: nil)
//        println("done with didLogInUser")
        
//        // Present BooksViewController when Log In is completed
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let BooksViewController = storyboard.instantiateViewControllerWithIdentifier("BooksViewController") as! UIViewController
//        self.presentViewController(BooksViewController, animated:true, completion:nil)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let tabBarController = storyboard.instantiateViewControllerWithIdentifier("TabBarController") as! UIViewController
        // 3
        //                    self.window?.rootViewController!.presentViewController(tabBarController, animated:true, completion:nil)
        self.presentViewController(tabBarController, animated:true, completion:nil)
        
    }
    
    func logInViewController(logInController: PFLogInViewController, didFailToLogInWithError error: NSError?) {
        
//        println("Failed to Login")
        
        let alertController = UIAlertController(title: "Log In Error", message: "Incorrect Username or Password. Please try again.", preferredStyle: .Alert)
        
        let okayAction = UIAlertAction(title: "Okay", style: .Default, handler: {(UIAlertAction) -> Void in
            //            println("Canceled Flag Request")
        })
        
        alertController.addAction(okayAction)
        logInViewController.presentViewController(alertController, animated: true, completion: nil)
        
    }
    
    func signUpViewController(signUpController: PFSignUpViewController, shouldBeginSignUp info: [NSObject : AnyObject]) -> Bool {
//        println("in hereh")
        let username = info["username"] as? String
        let pass = info["password"] as? String
        let email = info["email"] as? String
        
//        println("username empty: \(username?.isEmpty)")
//            println("password empty: \(pass?.isEmpty)")
//                println("email empty: \(email?.isEmpty)")
//        println("if statement: \(((username?.isEmpty != nil) || (pass?.isEmpty != nil) || (email?.isEmpty != nil)))")
        
//        if ((username?.isEmpty != nil) || (pass?.isEmpty != nil) || (email?.isEmpty != nil)){
//            println("\(username), \(pass), \(email)")
//            let alertController = UIAlertController(title: "Sign Up Failed", message: "Username, Password, or Email not entered. Please try again.", preferredStyle: .Alert)
//            
//            let okayAction = UIAlertAction(title: "Okay", style: .Default, handler: {(UIAlertAction) -> Void in
//                //            println("Canceled Flag Request")
//            })
//            
//            alertController.addAction(okayAction)
//            signUpViewController.presentViewController(alertController, animated: true, completion: nil)
//        }
        
        if let password = info["password"] as? String {
//            println("done with shouldBeginSignUp true")
            if count(password) < 8 {
//                println("too short of pasword")
                
                
                
                let alertController = UIAlertController(title: "Sign Up Error", message: "Password must be at least 8 characters long. Please try again.", preferredStyle: .Alert)
                
                let okayAction = UIAlertAction(title: "Okay", style: .Default, handler: {(UIAlertAction) -> Void in
                    //            println("Canceled Flag Request")
                })
                
                alertController.addAction(okayAction)
                signUpViewController.presentViewController(alertController, animated: true, completion: nil)
                
                
            }
            else {
//                println("password good length")
            }
            return count(password) >= 8 //!password.isEmpty //> ""  //password.utf16Count >= 8
        }
        else {
//            println("done with should BeginSignUp false")
            return false
        }
    }
    
    func signUpViewController(signUpController: PFSignUpViewController, didSignUpUser user: PFUser) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
//        println("done with didSignUpUser")
        
//        // Present BooksViewController when Sign Up is completed
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let BooksViewController = storyboard.instantiateViewControllerWithIdentifier("BooksViewController") as! UIViewController
//        self.presentViewController(BooksViewController, animated:true, completion:nil)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let tabBarController = storyboard.instantiateViewControllerWithIdentifier("TabBarController") as! UIViewController
        // 3
        //                    self.window?.rootViewController!.presentViewController(tabBarController, animated:true, completion:nil)
        self.presentViewController(tabBarController, animated:true, completion:nil)
        
        
        
                

                

  
        
        
    }
    
    func signUpViewController(signUpController: PFSignUpViewController, didFailToSignUpWithError error: NSError?) {
        
//        println("Failed to sign up")
        
    }
    
    func signUpViewControllerDidCancelSignUp(signUpController: PFSignUpViewController) {
        
//        println("User dismissed sign up")
        
    }
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
