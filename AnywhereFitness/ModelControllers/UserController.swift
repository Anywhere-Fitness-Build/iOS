//
//  UserController.swift
//  AnywhereFitness
//
//  Created by Lambda_School_Loaner_219 on 1/8/20.
//  Copyright © 2020 Lambda_School_Loaner_219. All rights reserved.
//

import Foundation
import CoreData

class UserController {

    private var user: UserRepresentation?
    private var classes = [FitnessClass]()
    private var classesAttending = [FitnessClass]()

    func setUser(user: UserRepresentation) {
        self.user = user
    }

    func getUser() -> UserRepresentation? { return user }
    
    // MARK: - CRUD Methods
}
