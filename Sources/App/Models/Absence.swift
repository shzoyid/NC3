//
//  File.swift
//  
//
//  Created by Jood Areabi on 19/02/2024.
//

import Fluent
import Vapor

final class Absence: Model, Content {
    static let schema = "absence"
    
    @ID(key: "abs_id")
    var id: UUID?
    
    @Parent(key: "user_id")
    var user: Users
    
    init() { }
    
    init(id: UUID? = nil, user_id: Users.IDValue) {
        self.id = id
        self.$user.id = user_id
        

    }
  
}
