import SwiftUI

enum StackPath: Hashable, Identifiable {
  case pageWeather
  case pagePortfolios
  case pageFrameworks
  case pageAccount
  case publicPortfolio(String?)
  case publicPortfolioCv(String?)
  case _404

  var id: String {
    switch self {
    case ._404:
      return "404"
    case .pageWeather:
      return "pageWeather"
    case .pagePortfolios:
      return "pagePortfolios"
    case .pageFrameworks:
      return "pageFrameworks"
    case .pageAccount:
      return "pageAccount"
    case .publicPortfolio(let username):
      return "publicPortfolio(\(username ?? ""))"
    case .publicPortfolioCv(let username):
      return "publicPortfolioCv(\(username ?? ""))"
    }
  }

  var view: AnyView {
    switch self {
    case ._404:
      return AnyView(Text("404"))
    case .pagePortfolios:
      return AnyView(PortfolioFeed())
    case .publicPortfolio(let username):
      return AnyView(PublicPortfolio(username: username))
    case .publicPortfolioCv(let username):
      return AnyView(PublicPortfolioCv(username: username))
    case .pageWeather:
      return AnyView(PageWeather())
    case .pageFrameworks:
      return AnyView(PageFrameworks())
    case .pageAccount:
      return AnyView(PageAccount())
    }
  }
}

struct StackRootMeta {
  let title: String
  let icon: String
}

enum StackRoot: Hashable, Identifiable {
  case rootWeather
  case rootPortfolios
  case rootFrameworks
  case rootAccount
  case _404

  var meta: StackRootMeta {
    switch self {
    case ._404:
      return StackRootMeta(title: "404", icon: "")
    case .rootWeather:
      return StackRootMeta(title: "Weather", icon: "house")
    case .rootPortfolios:
      return StackRootMeta(title: "Portfolios", icon: "house")
    case .rootFrameworks:
      return StackRootMeta(title: "Frameworks", icon: "gear")
    case .rootAccount:
      return StackRootMeta(title: "Account", icon: "person")
    }
  }

  var id: String {
    self.meta.title
  }
}
