import SwiftUI

struct DbPortfolioFeed: View {
  @EnvironmentObject var stackVC: StackVC

  var body: some View {
    VStack {
      List(dbPortfolios.values, id: \.username) { p in
        HStack {
          Button(action: {
            stackVC.pushTo(parent: .portfolioFeed,
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
