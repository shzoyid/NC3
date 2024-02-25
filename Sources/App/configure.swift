import Vapor
import Fluent
import FluentPostgresDriver

// configures your application
public func configure(_ app: Application) async throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
    
    app.databases.use(.postgres(configuration:
                                    SQLPostgresConfiguration(hostname: "localhost",
                                                             username: "postgres", password: "",
                                                             database: "nc3",
                                                             tls:.prefer(try .init(configuration: .clientDefault)))), as: .psql)
    app.migrations.add(CreateUsers())
    app.migrations.add(CreateAbsence())
    app.migrations.add(CreateAttendance())
    try await app.autoMigrate()
    try routes(app)
}
