import SwiftUI

/// Returns a SwiftUI view for a given `StackPath`.
@ViewBuilder func pathToView(_ path: StackPath) -> some View {
  switch path {
  case .portfolioFeed:
    SPortfolioFeed(path: .portfolioFeed)
  case .publicPortfolio(let username):
    SPublicPortfolio(path: .publicPortfolio(username), username: username)
  case .publicPortfolioCv(let username):
    SPublicPortfolioCv(path: .publicPortfolioCv(username), username: username)
  case .publicPortfolioCvEntry(let username, let entryId):
    SPublicPortfolioCvEntry(path: .publicPortfolioCvEntry(username, entryId), username: username, entryId: entryId)
  case .pageWeather:
    SWeather(path: .pageWeather)
  case .pageFrameworks:
    SFrameworks(path: .pageFrameworks)
  case .pageAccount:
    SAccount(path: .pageAccount)
  case .pageAccountForm:
    SAccountForm(path: .pageAccountForm)
  case .barcodeScanner:
    SBarcodeScanner(path: .barcodeScanner)
  case ._404:
    Text("404 🍕🧑🏼‍💻")
  }
}
