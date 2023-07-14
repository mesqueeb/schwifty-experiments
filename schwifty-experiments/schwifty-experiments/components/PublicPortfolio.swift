import SwiftUI

struct PublicPortfolio: View {
  @EnvironmentObject var stackVC: StackVC

  let username: String?

  var portfolio: Portfolio? {
    return dbPortfolios.doc(username)?.data
  }

  var body: some View {
    VStack {
      Text("\(portfolio?.username ?? "")'s place")
      Button(action: {
        stackVC.pushTo(parent: .publicPortfolio(portfolio?.username),
                       path: StackPath.publicPortfolioCv(username))
      }) { Text("See CV") }
    }
    .navigationTitle(portfolio?.username ?? "-")
  }
}

#Preview {
  PublicPortfolio(username: nil)
}
