//
//  SwiftUIView.swift
//  
//
//  Created by Shahad Alzowaid on 05/08/1445 AH.
//


import SwiftUI
import Vapor

struct AttendenceController: RouteCollection {
    func boot(routes: Vapor.RoutesBuilder) throws {
        
        let attendances = routes.grouped("attendances")
        
        attendances.post(use: post)
        attendances.get(use: index)
        attendances.put(use: update)
        //http://127.0.0.1:8080/attendence/1234567890
        attendances.delete(":id", use: delete)
    }

    //read
    func index( req:Request) async throws -> [Attendance] {
        return try await Attendance.query(on:req.db).all()
    }
    //create
    func post(req: Request) async throws -> Attendance {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let newAttendance = try req.content.decode(Attendance.self, using: decoder)
        newAttendance.check_in
        
        
        //
        try await newAttendance.create(on: req.db)
        return newAttendance
    }
    
    func update(req: Request) async throws -> Attendance{
        let newAttendance = try req.content.decode(Attendance.self)
        guard let AttendanceInDB = try await Attendance.find(newAttendance.id, on: req.db) else {
            throw Abort(.notFound)
        }
//        AttendanceInDB.DoB = newAttendance.DoB
        try await AttendanceInDB.save(on: req.db)
        return newAttendance
    }
 
    //delete
    func delete (req: Request) async throws -> Users{
        let UserID = req.parameters.get("id", as:UUID.self)
        guard let UserInDB = try await Users.find(UserID, on: req.db) else {
            throw Abort(.notFound)
        }
        try await UserInDB.delete(on:req.db)
        return UserInDB
    }

}


