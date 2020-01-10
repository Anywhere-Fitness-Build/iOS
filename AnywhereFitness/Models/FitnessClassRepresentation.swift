//
//  ClassRepresentation.swift
//  AnywhereFitness
//
//  Created by Lambda_School_Loaner_219 on 1/6/20.
//  Copyright © 2020 Lambda_School_Loaner_219. All rights reserved.
//

import Foundation
struct FitnessClassRepresentation: Codable, Equatable {
    var name:String
    var type:String
    var startTime:String
    var duration:String
    var intensity: Int
    var location:String
    var maxSize: Int
    var classId:Int
    var instructorName:String 
    //var instructorId:Int 
}
enum CodingKeys:String, CodingKey {
    case classId = "id"
    case instructorName = "instructor_name"
   // case instructorId = "instructor_id"
}
