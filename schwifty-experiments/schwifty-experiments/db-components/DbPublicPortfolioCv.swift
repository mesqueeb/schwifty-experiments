import SwiftUI

struct DbPublicPortfolioCv: View {
  // ╔═══════╗
  // ║ Props ║
  // ╚═══════╝
  let path: StackPath
  let username: String?

  // ╔═══════╗
  // ║ Setup ║
  // ╚═══════╝
  @EnvironmentObject var stackVC: StackVC

  var portfolio: Portfolio? {
    return dbPortfolios.doc(username)?.data
  }

  var title: String {
    return textIf(portfolio?.username) { "\($0)'s CV" }
  }

  // ╔══════════╗
  // ║ Template ║
  // ╚══════════╝
  var body: some View {
    VStack {
      CNavigationHeader(path, title)

      VStack {
        ForEach(portfolio?.cv ?? [], id: \.id) { entry in
          HStack {
            Text("\(entry.year)/\(entry.month)")
            Spacer()
            Text("\(entry.description)")
          }
        }
      }

      // this just won't show up on non-compact... why?
//      List(portfolio?.cv ?? [], id: \.id) { entry in
//        HStack {
//          Text("\(entry.year)/\(entry.month)")
//          Spacer()
//          Text("\(entry.description)")
//        }
//      }
    }
  }
}

#Preview {
  DbPublicPortfolioCv(path: .publicPortfolioCv("Michael"), username: "Michael")
}
