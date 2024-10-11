import GRDB
import Testing

struct User: Codable, PersistableRecord, FetchableRecord {
  var id: Int64?
}

@MainActor
@Test
func observation() throws {
  let database = try DatabaseQueue()
  try database.write { db in
    try db.create(table: "user") { table in
      table.autoIncrementedPrimaryKey("id")
    }
  }

  try database.write { db in
    try User().insert(db)
  }

  var users: [User] = []
  let cancellable = ValueObservation.tracking { db in
    try User.fetchAll(db)
  }
  .start(in: database, scheduling: .immediate) { error in
  } onChange: {
    users = $0
  }

  #expect(users.count == 1)

  try database.write { db in
    try User().insert(db)
  }

  #expect(users.count == 2)

  _ = cancellable
}
