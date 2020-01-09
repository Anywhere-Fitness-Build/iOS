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
    
    func putClass(fitnessClass:FitnessClass, completion: @escaping () -> Void = {}) {
       guard let token = DatabaseController.sharedDatabaseController.loginStruct?.token,
        let userID = DatabaseController.sharedDatabaseController.roleID?.roleId else { print ("putClass returning with either nill token or userID"); return }
        
        let requestURL = DatabaseController.sharedDatabaseController.createClassURL
        var request = URLRequest(url:requestURL)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: token)
        
        guard let fitnessClassRepresentation = fitnessClass.fitnessClassRepresentation
            else {
                print("Failed to assign a fitnessClassRepresentation line 44 UserController")
                return
        }
        
        do {
            request.httpBody = try JSONEncoder().encode(fitnessClassRepresentation)
            
        } catch {
            print("Error encoding the fitnessClassrepresentation line 52 UserController")
            completion()
            return
        }
        
        URLSession.shared.dataTask(with:request){ (_,_, error) in
            
            if let error = error {
                print("Error putting this class: \(error) line 60 UserController")
                completion()
            }
        }.resume()
        
        
        
    }
    func createClass(_ fitnessClass: FitnessClass) {
        classes.append(fitnessClass)
    }

    func updateClass(_ fitnessClass: FitnessClass) {

    }

    func deleteClass(_ fitnessClass: FitnessClass) {

    }
}
