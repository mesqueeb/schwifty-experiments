enum StackPathAccount: String, CaseIterable {
  case root = "/account"
  case settings = "/accout/settings"
  case settings_notifications = "/accout/settings/notifications"
  case about = "/account/about"
}

enum StackPathPortolios: Hashable {
  case root
  case portfolio(String?)
  case portfolio_cv(String?)

  var path: String {
    switch self {
    case .root:
      return "/portfolios"
    case .portfolio(let username):
      return "/portfolios/\(username ?? "")"
    case .portfolio_cv(let username):
      return "/portfolios/\(username ?? "")/cv"
    }
  }
}

enum StackPath: String, CaseIterable {
  case weather = "/weather"
  case account = "/account"
  case portfolios = "/portfolios"
  case frameworks = "/frameworks"
}
