import SwiftUI

struct SPortfolioFeed: View {
  // ╔═══════╗
  // ║ Props ║
  // ╚═══════╝
  let path: StackPath

  // ╔═══════╗
  // ║ Setup ║
  // ╚═══════╝
  @Environment(StackVC.self) private var stackVC

  var title: String {
    return "Portfolios"
  }

  // ╔══════════╗
  // ║ Template ║
  // ╚══════════╝
  var body: some View {
    CStack(scrollView: true, padding: .a) {
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
  let stackPathPerRootIndex: [StackPath] = [.weather, .portfolioFeed, .frameworks, .account]

  @State var stackVC = StackVC(initialRootIndex: 1, stackPathPerRootIndex)

  return SPortfolioFeed(path: .portfolioFeed)
    .environment(stackVC)
}
