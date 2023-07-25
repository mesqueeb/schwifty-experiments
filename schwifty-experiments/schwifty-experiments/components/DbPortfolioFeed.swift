import SwiftUI

struct DbPortfolioFeed: View {
  @Environment(PathVC.self) private var pathVC

  var body: some View {
    VStack {
      List(dbPortfolios.values, id: \.username) { p in
        HStack {
          Button(action: {
            pathVC.pushAfter(parent: .portfolioFeed,
                             path: StackPath.publicPortfolio(p.username))
          }) { Text(p.username).foregroundColor(.primary) }
        }
      }
    }.navigationTitle("Portfolios")
  }
}

#Preview {
  DbPortfolioFeed()
}
