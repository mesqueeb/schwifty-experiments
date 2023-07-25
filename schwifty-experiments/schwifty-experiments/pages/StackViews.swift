import SwiftUI

@ViewBuilder
func pathToView(_ path: StackPath) -> some View {
  switch path {
  case .portfolioFeed:
    DbPortfolioFeed()
  case .publicPortfolio(let username):
    DbPublicPortfolio(username: username)
  case .publicPortfolioCv(let username):
    DbPublicPortfolioCv(username: username)
  case .pageWeather:
    CWeather()
  case .pageFrameworks:
    CFrameworks()
  case .pageAccount:
    CAccount()
  case ._404:
    Text("404 🍕🧑🏼‍💻")
  }
}

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
