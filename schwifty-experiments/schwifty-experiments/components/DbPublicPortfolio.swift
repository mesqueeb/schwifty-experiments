import SwiftUI

struct DbPublicPortfolio: View {
  @Environment(PathVC.self) private var pathVC

  let username: String?

  var portfolio: Portfolio? {
    return dbPortfolios.doc(username)?.data
  }

  var body: some View {
    VStack {
      Text(textIf(portfolio?.username) { "Welcome to \($0)'s place" })
      Button(action: {
        pathVC.pushAfter(parent: .publicPortfolio(portfolio?.username ?? ""),
                       path: StackPath.publicPortfolioCv(username ?? ""))
      }) { Text("See CV") }
    }
    .navigationTitle(portfolio?.username ?? "")
  }
}

#Preview {
  DbPublicPortfolio(username: "Michael")
}
