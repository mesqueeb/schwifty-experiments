import Foundation

struct CvEntry: Identifiable {
  let id: UUID
  let year: Int
  let month: Int
  let description: String

  init(year: Int, month: Int, description: String) {
    self.id = UUID()
    self.year = year
    self.month = month
    self.description = description
  }
}

class Portfolio: Hashable {
  let username: String
  let cv: [CvEntry]

  init(username: String, cv: [CvEntry]) {
    self.username = username
    self.cv = cv
  }

  static func == (lhs: Portfolio, rhs: Portfolio) -> Bool {
    lhs.username == rhs.username
  }

  func hash(into hasher: inout Hasher) {
    hasher.combine(username)
  }
}
