import SwiftUI

struct DbPortfolioFeed: View {
  // ╔═══════╗
  // ║ Props ║
  // ╚═══════╝
  let path: StackPath

  // ╔═══════╗
  // ║ Setup ║
  // ╚═══════╝
  @EnvironmentObject var stackVC: StackVC

  var title: String {
    return "Portfolios"
  }

  // ╔══════════╗
  // ║ Template ║
  // ╚══════════╝
  var body: some View {
    VStack {
      CNavigationHeader(path, title)

      List(dbPortfolios.values, id: \.username) { p in
        HStack {
          Button(action: {
            stackVC.pushTo(.portfolioFeed, StackPath.publicPortfolio(p.username))
          }) { Text(p.username).foregroundColor(.primary) }
        }
      }
    }
  }
}

#Preview {
  @StateObject var stackVC = StackVC(initialRootIndex: 1)

  return DbPortfolioFeed(path: .portfolioFeed)
    .environmentObject(stackVC)
}
