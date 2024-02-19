//
//  File.swift
//  
//
//  Created by Jood Areabi on 18/02/2024.
//

import Fluent
import Vapor

final class Attendance: Model, Content {
    
    static let schema: String = "attendances"
    @ID(key: "att_id ")
    var id: UUID?
    @Field(key: "check_in")
    var check_in: Date
    
    @Field(key: "check_out")
    var check_out: Date?
    
    @Parent(key: "user_id")
    var user: Users
    
    @Field(key: "early_late_min")
    var early_late_min: Int?
    
    init() {}

    init(id: UUID? = nil, check_in: Date, check_out: Date?, user_id: Users.IDValue, early_late_min: Int?) {
        self.id = id
        self.check_in = check_in
        self.check_out = check_out
        self.$user.id = user_id
        self.early_late_min = early_late_min
    }
}
