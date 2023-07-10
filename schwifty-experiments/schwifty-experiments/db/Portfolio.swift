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

class DbPortfolio {
  private(set) var data: Portfolio
  private let onUpdate: (Portfolio) -> Void

  init(data: Portfolio, onUpdate: @escaping (Portfolio) -> Void) {
    self.data = data
    self.onUpdate = onUpdate
  }

  func replace(_ portfolio: Portfolio) {
    data = portfolio
    onUpdate(portfolio)
  }
}

class DbPortfolios {
  private var portfolioMap: [String: Portfolio]

  var data: [String: Portfolio] {
    portfolioMap
  }

  var values: [Portfolio] {
    Array(portfolioMap.values)
  }

  init(initialData: [Portfolio]) {
    self.portfolioMap = initialData.reduce(into: [String: Portfolio]()) { $0[$1.username] = $1 }
  }

  func doc(_ username: String?) -> DbPortfolio? {
    guard let username = username else { return nil }
    guard let portfolio = portfolioMap[username] else { return nil }
    return DbPortfolio(data: portfolio) { self.portfolioMap[username] = $0 }
  }
}

let dbPortfolios = DbPortfolios(initialData: [
  Portfolio(username: "Michael", cv: [CvEntry(year: 2018, month: 12, description: "Hearts Beat Loud"), CvEntry(year: 2016, month: 9, description: "The Good Place")]),
  Portfolio(username: "Eleanor", cv: [CvEntry(year: 2019, month: 3, description: "Frozen II"), CvEntry(year: 2016, month: 9, description: "The Good Place")]),
  Portfolio(username: "Chidi", cv: [CvEntry(year: 2016, month: 9, description: "The Good Place")]),
])
