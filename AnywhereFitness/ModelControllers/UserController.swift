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
    private var classes = [FitnessClassRepresentation]()
    private var classesAttending = [FitnessClassRepresentation]()

    // MARK: - Set functions
    func setUser(user: UserRepresentation, fitnessClasses: [FitnessClassRepresentation]) {
        self.user = user
        self.classes = fitnessClasses
    }

    // MARK: - Get functions
    func getUser() -> UserRepresentation? { return user }

    func getAllClasses() -> [FitnessClassRepresentation] { return classes }

    func getClassesAttending() -> [FitnessClassRepresentation] { return classesAttending }

    func getClass(_ index: Int) -> FitnessClassRepresentation { return classes[index] }

    func getClassAttending(_ index: Int) -> FitnessClassRepresentation { return classesAttending[index] }

    // MARK: - CRUD Methods
    
    func createFitnessClass(fitnessClass:FitnessClass, completion: @escaping () -> Void) {
       guard let token = DatabaseController.sharedDatabaseController.loginStruct?.token else { print ("putClass returning with either nill token or userID"); return }
        
        let requestURL = DatabaseController.sharedDatabaseController.createClassURL
        var request = URLRequest(url:requestURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(token, forHTTPHeaderField: "Authorization")
        
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

            self.classes.append(fitnessClassRepresentation)
            completion()
        }.resume()
        
    }

    func joinAClass(_ fitnessClass: FitnessClassRepresentation) {
        classesAttending.append(fitnessClass)
    }

    func updateClass(_ fitnessClass: FitnessClass) {

    }

//    func deleteClass(_ fitnessClass: FitnessClass) {
//        guard let fitnessClassRep = fitnessClass.fitnessClassRepresentation,
//            let index = classes.firstIndex(of:fitnessClassRep) else {return}
//        classes.remove(at:index)
//
//        CoreDataStack.shared.mainContext.delete(fitnessClass)
//        CoreDataStack.shared.save()
    
    func deleteClass(_ fitnessClassRep: FitnessClassRepresentation) {
       
        guard let index = classesAttending.firstIndex(of:fitnessClassRep) else {print("returning nill out of deleteClass"); return}
        classesAttending.remove(at:index)
        
  
        
        

    }
}
