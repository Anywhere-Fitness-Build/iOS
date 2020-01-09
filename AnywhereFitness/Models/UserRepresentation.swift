//
//  UserRepresentation.swift
//  AnywhereFitness
//
//  Created by Lambda_School_Loaner_219 on 1/6/20.
//  Copyright © 2020 Lambda_School_Loaner_219. All rights reserved.
//

import Foundation
struct UserRepresentation: Codable {
    var username:String
    var password: String
    var isInstructor: Bool?
     
}
