//
//  Class+Convenience.swift
//  AnywhereFitness
//
//  Created by Lambda_School_Loaner_219 on 1/6/20.
//  Copyright © 2020 Lambda_School_Loaner_219. All rights reserved.
//

import Foundation
import CoreData

extension FitnessClass{
  var fitnessClassRepresentation: FitnessClassRepresentation? {
     
    guard let name = name,
    let type = classType,
    let startTime = startTime,
    let duration = duration,
    let location = location,
    let instructorName = instructorName
 
    else {return nil}
     
     /* struct FitnessClassRepresentation: Codable, Equatable {
     var name:String
     var type:String
     var startTime:String
     var duration:String
     var intensity: Int
     var location:String
     var maxSize: Int
     var classId:Int
     var instructorId:Int
     var instructorName:String*/
   
     
    return FitnessClassRepresentation(name:name, type:classType!, startTime:startTime, duration:duration, intensity:Int(intensity),location:location, maxSize:Int(maxSize), classId:Int(classId), instructorName:instructorName)
  }
  @discardableResult convenience init(name:String,
                    classType:String,
                    startTime: String,
                    duration:String,
                    intensity:Double?,
                    location:String,
                    maxSize:Double?,
                    classId:Double,
                    instructorName:String,
                    
                    context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
    self.init(context:context)
    self.name = name
    self.classType = classType
    self.startTime = startTime
    self.duration = duration
    self.intensity = intensity ?? 0
    self.location = location
    self.maxSize = maxSize ?? 0
    self.classId = classId
    
  }
   
  @discardableResult convenience init?(fitnessClassRepresentation: FitnessClassRepresentation, context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
    
    self.init(
        name: fitnessClassRepresentation.name,
        classType: fitnessClassRepresentation.type,
        startTime: fitnessClassRepresentation.startTime,
        duration: fitnessClassRepresentation.duration,
        intensity:Double(fitnessClassRepresentation.intensity),
        location: fitnessClassRepresentation.location,
        maxSize:Double(fitnessClassRepresentation.maxSize),
        classId: Double(fitnessClassRepresentation.classId),
        instructorName : fitnessClassRepresentation.instructorName
       )
        
        
        
        
    
   
       
          
  }
}
