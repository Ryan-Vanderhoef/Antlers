//
//  FlagPost.swift
//  AppIdea
//
//  Created by Ryan Vanderhoef on 8/11/15.
//  Copyright (c) 2015 Ryan Vanderhoef. All rights reserved.
//

import Foundation
import Parse

class FlagPost : PFObject, PFSubclassing {
    
    @NSManaged var toBook: PFObject?
    @NSManaged var toMovie: PFObject?
    @NSManaged var toGame: PFObject?
    @NSManaged var fromUser: PFUser?
    
    //MARK: PFSubclassing Protocol
    
    static func parseClassName() -> String {
        return "FlagPost"
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
