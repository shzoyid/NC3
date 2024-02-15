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
        
        let Attendene = routes.grouped("attendence")
        
        Attendene.post(use: create)
        Attendene.get(use: read)
        Attendene.put(use: update)
        //http://127.0.0.1:8080/attendence/1234567890
        Attendene.delete(":id", use: delete)
    }

    func create(req: Request) async throws -> String{
        return "new atendence recored added"
    }

    //read
    func read(req: Request) async throws -> String{
        return "attendence number = 123"
    }

    //update
    func update(req: Request) async throws -> String{
        return "update the attendence time"
    }

    //delet
    func delete (req: Request) async throws -> String{
        let id = req.parameters.get("id", as: UUID.self)
        return "delete attendence"
    }

}


