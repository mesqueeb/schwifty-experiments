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
  @Environment(StackVC.self) private var stackVC

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
          Button(action: {
            stackVC.pushTo(path, .publicPortfolioCvEntry(username, entry.id))
          }) {
            HStack {
              Text("\(entry.year)/\(entry.month)")
              Spacer()
              Text("\(entry.description)")
            }
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
  let stackPathPerRootIndex: [StackPath] = [.pageWeather, .portfolioFeed, .pageFrameworks, .pageAccount]

  @State var stackVC = StackVC(initialRootIndex: 1, stackPathPerRootIndex)

  return DbPublicPortfolioCv(path: .publicPortfolioCv("Michael"), username: "Michael")
    .environment(stackVC)
}
