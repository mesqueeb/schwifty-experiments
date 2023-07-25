import SwiftUI

@ViewBuilder
func pathToView(_ path: StackPath) -> some View {
  switch path {
  case .portfolioFeed:
    DbPortfolioFeed(path: .portfolioFeed)
  case .publicPortfolio(let username):
    DbPublicPortfolio(path: .publicPortfolio(username), username: username)
  case .publicPortfolioCv(let username):
    DbPublicPortfolioCv(path: .publicPortfolioCv(username), username: username)
  case .pageWeather:
    DbWeather(path: .pageWeather)
  case .pageFrameworks:
    DbFrameworks(path: .pageFrameworks)
  case .pageAccount:
    DbAccount(path: .pageAccount)
  case ._404:
    Text("404 🍕🧑🏼‍💻")
  }
}

let rootPathPerTabIndex: [StackPath] = [.pageWeather, .portfolioFeed, .pageFrameworks, .pageAccount]

@ViewBuilder
func rootToView(_ root: StackRoot) -> some View {
  switch root {
  case .rootWeather:
    PageWeather()
  case .rootPortfolios:
    PagePortfolios()
  case .rootFrameworks:
    PageFrameworks()
  case .rootAccount:
    PageAccount()
  case ._404:
    Text("404 🍕🧑🏼‍💻")
  }
}

let rootPerIndex: [StackRoot] = [.rootWeather, .rootPortfolios, .rootFrameworks, .rootAccount]
