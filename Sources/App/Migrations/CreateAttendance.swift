//
//  File.swift
//  
//
//  Created by Jood Areabi on 18/02/2024.
//

import Fluent

struct CreateAttendance: AsyncMigration {
    func prepare(on database: Database) async throws {
        try await database.schema("attendances")
            .id()
            .field("check_in", .datetime, .required)
            .field("check_out", .datetime)
            .field("user_id", .uuid, .required, .references("users", "id"))
            .field("early_late_min", .int)
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema("attendances").delete()
    }
}


