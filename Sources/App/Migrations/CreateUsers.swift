//
//  File.swift
//  
//
//  Created by Jood Areabi on 18/02/2024.
//

import Fluent

struct CreateUser: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("users")
            .id()
            .field("")
        
    }
}
