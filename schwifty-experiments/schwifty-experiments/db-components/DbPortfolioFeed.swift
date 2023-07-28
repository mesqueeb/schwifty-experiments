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

      ForEach(dbPortfolios.values, id: \.username) { p in
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
  let stackPathPerRootIndex: [StackPath] = [.pageWeather, .portfolioFeed, .pageFrameworks, .pageAccount]

  @StateObject var stackVC = StackVC(initialRootIndex: 1, stackPathPerRootIndex)

  return DbPortfolioFeed(path: .portfolioFeed)
    .environmentObject(stackVC)
}
