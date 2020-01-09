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

    // MARK: - Set functions
    func setUser(user: UserRepresentation) { self.user = user }

    // MARK: - Get functions
    func getUser() -> UserRepresentation? { return user }

    func getAllClasses() -> [FitnessClass] { return classes }

    func getClassesAttending() -> [FitnessClass] { return classesAttending }

    func getClass(_ index: Int) -> FitnessClass { return classes[index] }

    func getClassAttending(_ index: Int) -> FitnessClass { return classesAttending[index] }
    
    // MARK: - CRUD Methods
}
