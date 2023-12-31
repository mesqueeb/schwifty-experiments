import SwiftUI

/// Returns a SwiftUI view for a given `StackPath`.
@ViewBuilder func pathToView(_ path: StackPath) -> some View {
  switch path {
  case .appetizerList: SAppetizerList(path: .appetizerList)
  case .appetizerOrder: SAppetizerOrder(path: .appetizerOrder)
  case .portfolioFeed: SPortfolioFeed(path: .portfolioFeed)
  case .publicPortfolio(let username): SPublicPortfolio(path: .publicPortfolio(username), username: username)
  case .publicPortfolioCv(let username): SPublicPortfolioCv(path: .publicPortfolioCv(username), username: username)
  case .publicPortfolioCvEntry(let username, let entryId): SPublicPortfolioCvEntry(path: .publicPortfolioCvEntry(username, entryId), username: username, entryId: entryId)
  case .weather: SWeather(path: .weather)
  case .frameworks: SFrameworks(path: .frameworks)
  case .account: SAccount(path: .account)
  case .accountForm: SAccountForm(path: .accountForm)
  case .barcodeScanner: SBarcodeScanner(path: .barcodeScanner)
  case ._404: Text("404 🍕🧑🏼‍💻")
  }
}
