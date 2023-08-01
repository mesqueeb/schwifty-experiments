import SwiftUI

struct SPublicPortfolio: View {
  // ╔═══════╗
  // ║ Props ║
  // ╚═══════╝
  let path: StackPath
  let username: String?

  // ╔═══════╗
  // ║ Setup ║
  // ╚═══════╝
  @Environment(StackVC.self) private var stackVC
  @Environment(\.horizontalSizeClass) private var horizontalSizeClass

  var portfolio: Portfolio? {
    return dbPortfolios.doc(username)?.data
  }

  var title: String {
    return portfolio?.username ?? ""
  }

  // ╔══════════╗
  // ║ Template ║
  // ╚══════════╝
  var body: some View {
    VStack {
      CNavigationHeader(path, title)

      Text(textIf(portfolio?.username) { "Welcome to \($0)'s place" })
      Button(action: {
        stackVC.pushTo(.publicPortfolio(portfolio?.username ?? ""), StackPath.publicPortfolioCv(username ?? ""))
      }) { Text("See CV") }
    }
  }
}

#Preview {
  let stackPathPerRootIndex: [StackPath] = [.pageWeather, .portfolioFeed, .pageFrameworks, .pageAccount]

  @State var stackVC = StackVC(initialRootIndex: 1, stackPathPerRootIndex)

  return SPublicPortfolio(path: .publicPortfolio("Michael"), username: "Michael")
    .environment(stackVC)
}
