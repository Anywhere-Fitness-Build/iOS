//
//  DatabaseController.swift
//  AnywhereFitness
//
//  Created by Lambda_School_Loaner_219 on 1/8/20.
//  Copyright © 2020 Lambda_School_Loaner_219. All rights reserved.
//

import Foundation
import CoreData

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

enum NetworkError: Error {
    case noAuth
    case badAuth
    case otherError
    case badData
    case noDecode
}

class DatabaseController {
    static let sharedDatabaseController = DatabaseController()
    
    private let baseUrl = URL(string: "https://anywhere-fitness-bw.herokuapp.com")!
    private let signUpUrl = URL(string:"https://anywhere-fitness-bw.herokuapp.com/auth/register/")!
    
    let createClassURL = URL(string: "https://anywhere-fitness-bw.herokuapp.com/classes")!
    
    var loginStruct:LoginStruct?
    var roleID:RoleID? //user receives a roleID on signup
    
    
    func signUp(with user: UserRepresentation, completion: @escaping (Error?) -> ()) {
       
        
        var request = URLRequest(url: signUpUrl)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let jsonEncoder = JSONEncoder()
        do {
            let jsonData = try jsonEncoder.encode(user)
            request.httpBody = jsonData
        } catch {
            print("Error encoding user object: \(error)")
            completion(error)
            return
        }
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let response = response as? HTTPURLResponse,
                response.statusCode != 200 {
                completion(NSError(domain: "", code: response.statusCode, userInfo:nil))
                return
            }
            
            if let error = error {
                completion(error)
                return
            }
            guard let data = data else {
                completion(NSError())
                return
            }
            
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    do {
                        self.loginStruct = try decoder.decode(LoginStruct.self, from: data)
                        print("Success signing up  your role_id is: \(String(describing: self.roleID?.roleId))")
                        
                    } catch {
                        print("Error decoding id object: \(error)")
                        completion(error)
                        return
                    }
                    
                    completion(nil)
                }.resume()
            
            
    }
      
    
    
    func signIn(with user: UserRepresentation, completion: @escaping (Error?) -> ()) {
        let loginUrl = baseUrl.appendingPathComponent("/auth/login")
        
        var request = URLRequest(url: loginUrl)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let jsonEncoder = JSONEncoder()
        do {
            let jsonData = try jsonEncoder.encode(user)
            request.httpBody = jsonData
        } catch {
            print("Error encoding user object: \(error)")
            completion(error)
            return
        }
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let response = response as? HTTPURLResponse,
                response.statusCode != 200 {
                completion(NSError(domain: "", code: response.statusCode, userInfo:nil))
                return
            }
            
            if let error = error {
                completion(error)
                return
            }
            
            guard let data = data else {
                completion(NSError())
                return
            }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            do {
                self.loginStruct = try decoder.decode(LoginStruct.self, from: data) //self.bearer = try decoder.decode(Bearer.self, from: data)
                print("Success logging in your token is: \(String(describing: self.loginStruct?.token))")
                
            } catch {
                print("Error decoding id object: \(error)")
                completion(error)
                return
            }
            
            completion(nil)
        }.resume()
    }


    func getAllClasses(completion: @escaping ([FitnessClassRepresentation]?, Error?) -> Void) {
        guard let token = loginStruct?.token else {
            completion(nil, NSError())
            return
        }

        let allClassesURL = baseUrl.appendingPathComponent("classes")

        var request = URLRequest(url: allClassesURL)
        request.httpMethod = HTTPMethod.get.rawValue
        request.addValue(token, forHTTPHeaderField: "Authorization")

        URLSession.shared.dataTask(with: request) { data, _, error in
            if let _ = error {
                print("Error")
                completion(nil, error)
                return
            }
            guard let data = data else {
                print("Bad Data")
                return
            }

            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            do {
                let fitnessClasses = try decoder.decode([FitnessClassRepresentation].self, from: data)
                completion(fitnessClasses, nil)
            } catch {
                print("Error decoding")
                completion(nil, error)
            }
        }.resume()
    }
}

