import SwiftUI

struct SPublicPortfolioCv: View {
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
    CStack(scrollView: true, padding: .a) {
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
    }
  }
}

#Preview {
  let stackPathPerRootIndex: [StackPath] = [.pageWeather, .portfolioFeed, .pageFrameworks, .pageAccount]

  @State var stackVC = StackVC(initialRootIndex: 1, stackPathPerRootIndex)

  return SPublicPortfolioCv(path: .publicPortfolioCv("Michael"), username: "Michael")
    .environment(stackVC)
}
