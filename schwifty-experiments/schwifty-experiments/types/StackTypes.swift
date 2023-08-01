import SwiftUI

enum StackPath: Hashable, Identifiable, Equatable {
  case weather
  case portfolioFeed
  case frameworks
  case account
  case publicPortfolio(String?)
  case publicPortfolioCv(String?)
  case publicPortfolioCvEntry(String?, UUID?)
  case barcodeScanner
  case accountForm
  case _404

  var id: String {
    switch self {
    case .weather:
      return "weather"
    case .portfolioFeed:
      return "portfolioFeed"
    case .frameworks:
      return "frameworks"
    case .account:
      return "account"
    case .accountForm:
      return "accountForm"
    case .publicPortfolio(let username):
      return "publicPortfolio(\(username ?? ""))"
    case .publicPortfolioCv(let username):
      return "publicPortfolioCv(\(username ?? ""))"
    case .publicPortfolioCvEntry(let username, let entryId):
      return "publicPortfolioCvEntry(\(username ?? ""), \(String(describing: entryId))"
    case .barcodeScanner:
      return "barcodeScanner"
    case ._404:
      return "404"
    }
  }
}
