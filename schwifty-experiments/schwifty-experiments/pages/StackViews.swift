import SwiftUI

/// Returns a SwiftUI view for a given `StackPath`.
@ViewBuilder func pathToView(_ path: StackPath) -> some View {
  switch path {
  case .portfolioFeed:
    DbPortfolioFeed(path: .portfolioFeed)
  case .publicPortfolio(let username):
    DbPublicPortfolio(path: .publicPortfolio(username), username: username)
  case .publicPortfolioCv(let username):
    DbPublicPortfolioCv(path: .publicPortfolioCv(username), username: username)
  case .publicPortfolioCvEntry(let username, let entryId):
    DbPublicPortfolioCvEntry(path: .publicPortfolioCvEntry(username, entryId), username: username, entryId: entryId)
  case .pageWeather:
    DbWeather(path: .pageWeather)
  case .pageFrameworks:
    DbFrameworks(path: .pageFrameworks)
  case .pageAccount:
    DbAccount(path: .pageAccount)
  case .pageAccountForm:
    DbAccountForm(path: .pageAccountForm)
  case .barcodeScanner:
    DbBarcodeScanner(path: .barcodeScanner)
  case ._404:
    Text("404 🍕🧑🏼‍💻")
  }
}
