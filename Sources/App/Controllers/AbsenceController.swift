import Vapor
import Fluent

struct AbsenceController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let absences = routes.grouped("absences")
        
        absences.get(use: read)
//        absences.put(":id", use: update) // Notice the ":id" parameter in the route.
        absences.delete(":id", use: delete)
        absences.post(use: post)

    }
    
    // Read all absences
    func read(req: Request) async throws -> Int {
           return try await Absence.query(on: req.db).count()
       }
    
    func post(req: Request) async throws -> Absence {
        let newAbsence = try req.content.decode(Absence.self)
        try await newAbsence.create(on: req.db)
        return newAbsence
    }

//    // Update an absence with an excuse
//    func update(req: Request) async throws -> Absence {
//        let absenceUpdate = try req.content.decode(AbsenceUpdate.self)
//        guard let absenceID = req.parameters.get("id", as: UUID.self) else {
//            throw Abort(.badRequest, reason: "Absence ID is required.")
//        }
//        
//        // Find the absence record in the database
//        guard let absenceInDB = try await Absence.find(absenceID, on: req.db) else {
//            throw Abort(.notFound, reason: "Absence record not found for the provided ID.")
//        }
//        
//        // Update the excuse property
//        absenceInDB.date = absenceUpdate.date
//        // You can add other properties to update as needed
//
//        // Save the updated absence record
//        try await absenceInDB.save(on: req.db)
//        return absenceInDB
//    }
    
  func delete(req: Request) async throws -> HTTPStatus {
        guard let absenceID = req.parameters.get("id", as: UUID.self) else {
            throw Abort(.badRequest, reason: "Missing or invalid absence ID")
        }
        
        guard let absenceInDB = try await Absence.find(absenceID, on: req.db) else {
            throw Abort(.notFound, reason: "Absence record not found")
        }
        
        try await absenceInDB.delete(on: req.db)
        return .ok // Return HTTP status 200 OK
    }
}

// Define a helper struct to decode the update data
struct AbsenceUpdate: Content {
    let excuse: String?
    // Include other properties that can be updated if necessary
}
