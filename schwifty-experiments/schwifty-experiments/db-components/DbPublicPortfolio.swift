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
        stackVC.pushTo(parent: .publicPortfolio(portfolio?.username ?? ""),
                       path: StackPath.publicPortfolioCv(username ?? ""))
      }) { Text("See CV") }
    }
  }
}

#Preview {
  DbPublicPortfolio(path: .publicPortfolio("Michael"), username: "Michael")
}
