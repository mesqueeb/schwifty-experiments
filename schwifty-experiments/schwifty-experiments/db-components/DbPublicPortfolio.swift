import SwiftUI

struct DbPublicPortfolio: View {
  // ╔═══════╗
  // ║ Props ║
  // ╚═══════╝
  let path: StackPath
  let username: String?

  // ╔═══════╗
  // ║ Setup ║
  // ╚═══════╝
  @EnvironmentObject var stackVC: StackVC
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

  @StateObject var stackVC = StackVC(initialRootIndex: 1, stackPathPerRootIndex)

  return DbPublicPortfolio(path: .publicPortfolio("Michael"), username: "Michael")
    .environmentObject(stackVC)
}
