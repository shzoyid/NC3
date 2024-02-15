//
//  SwiftUIView.swift
//  
//
//  Created by Shahad Alzowaid on 05/08/1445 AH.
//

import SwiftUI
import Vapor

struct UserController: RouteCollection {
    func boot(routes: Vapor.RoutesBuilder) throws {
        //http://127.0.0.1:8080/users
        let users = routes.grouped("users")
        
        users.post(use: create)
        users.get(use: read)
        users.put(use: update)
        users.delete(use: delete)
    }

    func create(req: Request) async throws -> String{
        return "new user added"
    }

    //read
    func read(req: Request) async throws -> String{
        return "user = shahad"
    }

    //update
    func update(req: Request) async throws -> String{
        return "users new DoB is= 27/1/2003"
    }

    //delet
    func delete (req: Request) async throws -> String{
        return "user been deleted"
    }


}

