import SwiftUI

struct DbPublicPortfolioCv: View {
  @EnvironmentObject var stackVC: StackVC

  let username: String?

  var portfolio: Portfolio? {
    return dbPortfolios.doc(username)?.data
  }

  var body: some View {
    VStack {
      List(portfolio?.cv ?? []) { entry in
        HStack {
          Text("\(entry.year)/\(entry.month)")
          Spacer()
          Text("\(entry.description)")
        }
      }
    }
    .navigationTitle(textIf(portfolio?.username) { "\($0)'s CV" })
  }
}

#Preview {
  DbPublicPortfolioCv(username: "Michael")
}
