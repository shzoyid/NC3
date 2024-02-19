//
//  File.swift
//  
//
//  Created by Jood Areabi on 18/02/2024.
//

import Fluent

struct CreateAbsence: AsyncMigration {
    func prepare(on database: Database) async throws {
        try await database.schema("absences")
            .id()
            .field("user_id", .uuid, .required, .references("users", "id"))
            .field("date", .date, .required)
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema("absences").delete()
    }
}


