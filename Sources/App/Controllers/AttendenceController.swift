import SwiftUI
import Vapor

struct AttendenceController: RouteCollection {
    func boot(routes: Vapor.RoutesBuilder) throws {
        
        let attendances = routes.grouped("attendances")
        
        attendances.post(use: post)
        attendances.get(use: index)
        attendances.put(use: update)
        //http://127.0.0.1:8080/attendence/1234567890
     //   attendances.delete(":id", use: delete)
    }

    //read
    func index( req:Request) async throws -> [Attendance] {
        return try await Attendance.query(on:req.db).all()
    }
    //create
    //create
      func post(req: Request) async throws -> Attendance {
          let decoder = JSONDecoder()
          decoder.dateDecodingStrategy = .iso8601
          let newAttendance = try req.content.decode(Attendance.self, using: decoder)
          
          let checkInTime = newAttendance.check_in
          let lateThreshold = Calendar.current.date(bySettingHour: 14, minute: 15, second: 0, of: checkInTime)!
          
          // Check if check-in is late
          if checkInTime > lateThreshold {
              let lateMinutes = Calendar.current.dateComponents([.minute], from: lateThreshold, to: checkInTime).minute ?? 0
              newAttendance.early_late_min = lateMinutes
          }

          // Check if there's no check-out time and the current time is past 6 PM
          let now = Date()
          let endOfWorkDay = Calendar.current.date(bySettingHour: 18, minute: 0, second: 0, of: now)!
          if newAttendance.check_out == nil && now > endOfWorkDay {
              // Assuming that the Absence model has an initializer that takes a user ID
              let absence = Absence(user_id: newAttendance.$user.id)
              try await absence.create(on: req.db)
          }

          try await newAttendance.create(on: req.db)
          return newAttendance
      }
    
    func update(req: Request) async throws -> Attendance{
        let newAttendance = try req.content.decode(Attendance.self)
        guard let AttendanceInDB = try await Attendance.find(newAttendance.id, on: req.db) else {
            throw Abort(.notFound)
        }
        try await AttendanceInDB.save(on: req.db)
        return newAttendance
    }
 
//    //delete
//    func delete (req: Request) async throws -> Users{
//        let UserID = req.parameters.get("id", as:UUID.self)
//        guard let UserInDB = try await Users.find(UserID, on: req.db) else {
//            throw Abort(.notFound)
//        }
//        try await UserInDB.delete(on:req.db)
//        return UserInDB
//    }

}
