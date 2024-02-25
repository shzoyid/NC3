//
//  SwiftUIView.swift
//  
//
//  Created by Shahad Alzowaid on 08/08/1445 AH.
//

import Fluent
import Vapor

final class Absence: Model, Content {
    static let schema = "absences"
    
    @ID
    var id: UUID?
    
    @Parent(key: "user_id")
    var user: Users
    
    
    init() { }
    
    init(id: UUID? = nil, user_id: Users.IDValue) {
        self.id = id
        self.$user.id = user_id
        

    }
  
}
