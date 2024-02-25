//
//  SwiftUIView.swift
//  
//
//  Created by Jood Areabi on 18/02/2024.
//
import SwiftUI
import Vapor 

struct AbsenceController: RouteCollection {
    func boot(routes: Vapor.RoutesBuilder) throws {
        
        let absences = routes.grouped("absences")
        
        absences.post(use: create)
        absences.get(use: read)
        absences.put(use: update)
        //http://127.0.0.1:8080/attendence/1234567890
        absences.delete(":id", use: delete)
    }
    
        //create
        func create(req: Request) async throws -> String{
            return "new absence record added"
        }
        
        //read
        func read(req: Request) async throws -> String{
            return "absence number = 123"
        }
        
        //update
        func update(req: Request) async throws -> String{
            return "update the absence time"
        }
        
        //delete
        func delete (req: Request) async throws -> String{
            let id = req.parameters.get("id", as: UUID.self)
            return "delete absence"
        }
        
    }

