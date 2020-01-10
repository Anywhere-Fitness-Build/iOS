//
//  id.swift
//  AnywhereFitness
//
//  Created by Lambda_School_Loaner_219 on 1/8/20.
//  Copyright © 2020 Lambda_School_Loaner_219. All rights reserved.
//

import Foundation

struct FitnessClassRequest: Codable {
    var name:String
    var type:String
    var startTime:String
    var duration:String
    var intensity: Int
    var location:String
    var maxSize: Int

    init(_ fitnessClassRep: FitnessClassRepresentation) {
        self.name = fitnessClassRep.name
        self.type = fitnessClassRep.type
        self.startTime = fitnessClassRep.startTime
        self.duration = fitnessClassRep.duration
        self.intensity = fitnessClassRep.intensity
        self.location = fitnessClassRep.location
        self.maxSize = fitnessClassRep.maxSize
    }

}


