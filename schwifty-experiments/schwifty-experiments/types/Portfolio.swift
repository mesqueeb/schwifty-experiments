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

final class Portfolio: Hashable, DocProtocol {
  let id: String
  let username: String
  let cv: [CvEntry]

  init(username: String, cv: [CvEntry]) {
    self.id = UUID().uuidString
    self.username = username
    self.cv = cv
  }

  static func == (lhs: Portfolio, rhs: Portfolio) -> Bool {
    lhs.id == rhs.id
  }

  func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }
}
