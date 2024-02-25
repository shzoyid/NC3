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
        let users = routes.grouped("users")
        //http://127.0.0.1:8080/users

        users.get(use: index)
        users.post(use: post)
    }
    
    //read
    func index( req:Request) async throws -> [Users] {
        return try await Users.query(on:req.db).all()
    }
    //create
    func post(req: Request) async throws -> Users {
        let newUser = try req.content.decode(Users.self)
        try await newUser.create(on: req.db)
        return newUser
    }
    
}

