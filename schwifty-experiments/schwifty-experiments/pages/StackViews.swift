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
func rootToView(_ rootVC: RootVC) -> some View {
  switch rootVC.currentRoot {
  case .rootWeather:
    PageWeather(rootVC: rootVC)
  case .rootPortfolios:
    PagePortfolios(rootVC: rootVC)
  case .rootFrameworks:
    PageFrameworks(rootVC: rootVC)
  case .rootAccount:
    PageAccount(rootVC: rootVC)
  case ._404:
    Text("404 🍕🧑🏼‍💻")
  }
}
