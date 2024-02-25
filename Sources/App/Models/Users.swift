//
//  SwiftUIView.swift
//  
//
//  Created by Shahad Alzowaid on 08/08/1445 AH.
//

import Fluent
import Vapor

final class Users: Model, Content {
    static let schema = "users"
    
    @ID
    var id: UUID?
    
    @Field(key: "name")
    var name: String
    
//    @Field(key: "DoB")
//    var DoB: Date
    
    init() { }
    
    init(id: UUID? = nil, name: String, DoB : Date) {
        self.id = id
        self.name = name
//        self.DoB = DoB

    }
  
}

