//
//  LoginStruct.swift
//  AnywhereFitness
//
//  Created by Lambda_School_Loaner_219 on 1/8/20.
//  Copyright © 2020 Lambda_School_Loaner_219. All rights reserved.
//

import Foundation
struct LoginStruct: Codable {
    var message:String
    var token:String
    var id:Int
    var roleId: Int
}
