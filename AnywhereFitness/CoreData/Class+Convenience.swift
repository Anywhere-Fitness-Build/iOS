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
            let type = type,
            let startTime = startTime,
            let duration = duration,
            let intensity = intensity,
            let location = location,
            let maxSize = maxSize else {return nil}
                
            
            
         
            
            
            return FitnessClassRepresentation(name: name, type:type, startTime:startTime, duration:duration, intensity:intensity, location:location, maxSize:maxSize)
        }
        @discardableResult convenience init(name:String,
                                            type:String,
                                            startTime: String,
                                            duration:String,
                                            intensity:Int16,
                                            location:String,
                                            maxSize:Int16,
                                            context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
            self.init(context:context)
            self.name = name
            self.type = type
            self.startTime = startTime
            self.duration = duration
            self.intensity = intensity
            self.location = location
            self.maxSize = maxSize
            
        }
        
        @discardableResult convenience init?(fitnessClassRepresentation: FitnessClassRepresentation,  context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
            self.init(name: FitnessClassRepresentation.name,
                      type: FitnessClassRepresentation.type,
                      startTime: FitnessClassRepresentation.startTime,
                      isInstructor: FitnessClassRepresentation.isInstructor)
                
                      
        }
    }


