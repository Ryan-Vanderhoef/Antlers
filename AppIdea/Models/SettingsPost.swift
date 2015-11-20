//
//  SettingsPost.swift
//  AppIdea
//
//  Created by Ryan Vanderhoef on 8/10/15.
//  Copyright (c) 2015 Ryan Vanderhoef. All rights reserved.
//

import Foundation
import Parse

class SettingsPost : PFObject, PFSubclassing {
    
    @NSManaged var BookSort: String
    @NSManaged var MovieSort: String
    @NSManaged var GameSort: String
    @NSManaged var user: PFUser?
    
    
    
    //MARK: PFSubclassing Protocol
    
    static func parseClassName() -> String {
        return "SettingsPost"
    }
    
    override init () {
        super.init()
    }
    
    override class func initialize() {
        var onceToken : dispatch_once_t = 0;
        dispatch_once(&onceToken) {
            // inform Parse about this subclass
            self.registerSubclass()
        }
    }
    
}
