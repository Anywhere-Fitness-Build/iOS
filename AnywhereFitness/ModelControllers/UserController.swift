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
        
        guard var fitnessClassRepresentation = fitnessClass.fitnessClassRepresentation
            else {
                print("Failed to assign a fitnessClassRepresentation line 44 UserController")
                return
        }
        
        do {
            let fitnessClassRequestBody = FitnessClassRequest(fitnessClassRepresentation)
            request.httpBody = try JSONEncoder().encode(fitnessClassRequestBody)
            
        } catch {
            print("Error encoding the fitnessClassrepresentation line 52 UserController")
            completion()
            return
        }
        
        URLSession.shared.dataTask(with:request){ ( data,_, error) in
            
            if let error = error {
                print("Error putting this class: \(error) line 60 UserController")
                completion()
            }

            guard let data = data else {
                print("Bad Data")
                return
            }

            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            do {
                let fitnessClass = try decoder.decode(FitnessClassRepresentation.self, from: data)
                fitnessClassRepresentation.id = fitnessClass.id
                self.classes.append(fitnessClassRepresentation)
                completion()

            } catch {
                print("Error decoding")
                completion()
            }
        }.resume()
        
    }

    func joinAClass(_ fitnessClass: FitnessClassRepresentation) {
        classesAttending.append(fitnessClass)
    }

    func updateClass(for fitnessClassRep: FitnessClassRepresentation, with fitnessClass: FitnessClass) -> FitnessClassRepresentation {

        guard let index = classes.firstIndex(of:fitnessClassRep) else { return fitnessClassRep }

        classes[index].name = fitnessClass.name ?? ""
        classes[index].type = fitnessClass.classType ?? ""
        classes[index].startTime = fitnessClass.startTime ?? ""
        classes[index].duration = fitnessClass.duration ?? ""
        classes[index].intensity = Int(fitnessClass.intensity)
        classes[index].location = fitnessClass.location ?? ""
        classes[index].maxSize = Int(fitnessClass.maxSize)
        return classes[index]
    }
    
    func updateServerClass(_ fitnessClass: FitnessClassRepresentation, completion: @escaping (Error?) -> Void) {

        guard let token = DatabaseController.sharedDatabaseController.loginStruct?.token else { print ("putClass returning with either nill token or userID"); return }

        var requestURL = DatabaseController.sharedDatabaseController.createClassURL
        requestURL.appendPathComponent("\(fitnessClass.id)")

        var request = URLRequest(url: requestURL)
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(token, forHTTPHeaderField: "Authorization")

        do {
            let jsonEncoder = JSONEncoder()
            request.httpBody = try jsonEncoder.encode(fitnessClass)
        } catch {
            print("Error encoding class")
            completion(error)
            return
        }

        URLSession.shared.dataTask(with: request) { _, response, error in
            if let response = response {
                print(response)
            }
            if let _ = error {
                print("Error")
                completion(error)
                return
            }
            completion(nil)
        }.resume()
    }


    func deleteClass(_ fitnessClassRep: FitnessClassRepresentation) {
        //deletes a class that the user is attending from classesAttending.
        guard let index = classesAttending.firstIndex(of:fitnessClassRep) else {print("returning nill out of deleteClass"); return}
        classesAttending.remove(at:index)
    }

    func deleteClassFromServer(_ fitnessClassRep:FitnessClassRepresentation, completion: @escaping (Error?) -> Void){

        guard let token = DatabaseController.sharedDatabaseController.loginStruct?.token else { print ("putClass returning with either nill token or userID"); return }

        var requestURL = DatabaseController.sharedDatabaseController.createClassURL
        requestURL.appendPathComponent("\(fitnessClassRep.id)")

        var request = URLRequest(url: requestURL)
        request.httpMethod = "DELETE"
        request.addValue(token, forHTTPHeaderField: "Authorization")

        URLSession.shared.dataTask(with: request) { _, response, error in
            if let response = response {
                print(response)
            }
            if let _ = error {
                print("Error")
                completion(error)
                return
            }
            guard let index = self.classes.firstIndex(of: fitnessClassRep) else
            {print("returning nill out of deleteClassFromSever"); return}
            self.classes.remove(at:index)
            completion(nil)
        }.resume()
    }
}
