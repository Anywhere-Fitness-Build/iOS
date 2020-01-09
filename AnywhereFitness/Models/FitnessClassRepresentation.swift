//
//  ClassRepresentation.swift
//  AnywhereFitness
//
//  Created by Lambda_School_Loaner_219 on 1/6/20.
//  Copyright © 2020 Lambda_School_Loaner_219. All rights reserved.
//

import Foundation
struct FitnessClassRepresentation: Codable {
    var name:String
    var classType:String
    var startTime:String
    var duration:String
    var intensity: Double
    var location:String
    var maxSize:Double
}
