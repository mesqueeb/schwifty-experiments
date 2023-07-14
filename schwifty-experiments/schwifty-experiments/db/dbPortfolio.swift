import Foundation

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
