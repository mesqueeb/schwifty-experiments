import SwiftUI

enum StackPath: Hashable, Identifiable, Equatable {
  case pageWeather
  case portfolioFeed
  case pageFrameworks
  case pageAccount
  case publicPortfolio(String?)
  case publicPortfolioCv(String?)
  case _404

  var id: String {
    switch self {
    case .pageWeather:
      return "pageWeather"
    case .portfolioFeed:
      return "portfolioFeed"
    case .pageFrameworks:
      return "pageFrameworks"
    case .pageAccount:
      return "pageAccount"
    case .publicPortfolio(let username):
      return "publicPortfolio(\(username ?? ""))"
    case .publicPortfolioCv(let username):
      return "publicPortfolioCv(\(username ?? ""))"
    case ._404:
      return StackRoot._404.id
    }
  }
}

enum StackRoot: Hashable, Identifiable, Equatable {
  case rootWeather
  case rootPortfolios
  case rootFrameworks
  case rootAccount
  case _404

  var id: String {
    switch self {
    case .rootWeather:
      return "rootWeather"
    case .rootPortfolios:
      return "rootPortfolios"
    case .rootFrameworks:
      return "rootFrameworks"
    case .rootAccount:
      return "rootAccount"
    case ._404:
      return "404"
    }
  }
}
