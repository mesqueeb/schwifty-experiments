import SwiftUI

struct PortfolioFeed: View {
  @EnvironmentObject var stackVC: StackVC

  var body: some View {
    VStack {
      List(dbPortfolios.values, id: \.username) { p in
        HStack {
          Button(action: {
            stackVC.pushTo(parent: .pagePortfolios,
                           path: StackPath.publicPortfolio(p.username))
          }) { Text(p.username).foregroundColor(.primary) }
        }
      }
    }.navigationTitle("Portfolios")
  }
}

#Preview {
  PortfolioFeed()
}
