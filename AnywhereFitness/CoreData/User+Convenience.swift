//
//  User+Convenience.swift
//  AnywhereFitness
//
//  Created by Lambda_School_Loaner_219 on 1/6/20.
//  Copyright © 2020 Lambda_School_Loaner_219. All rights reserved.
//

import Foundation
import CoreData

extension User {
    var userRepresentation: UserRepresentation? {
        
        guard let
            username = username,
            let password = password else {return nil}
        
        return UserRepresentation(username:username, password:password, isInstructor:isInstructor)
    }
    @discardableResult convenience init(username:String,
                                        password:String,
                                        isInstructor: Bool,
                                        context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        self.init(context:context)
        self.username = username
        self.password = password
    }
    
    @discardableResult convenience init?(userRepresentation: UserRepresentation,  context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        self.init(username: userRepresentation.username,
                  password: userRepresentation.password,
                  isInstructor: userRepresentation.isInstructor)
            
                  
    }
}
