import SwiftUI

struct PagePorfolios: View {
  @State private var fullPath: [StackPathPortolios] = []
  @State private var currentPath: StackPathPortolios?

  var body: some View {
    NavigationStack(path: $fullPath) {
      PagePortfoliosRoot(fullPath: $fullPath, currentPath: $currentPath)
        // #if os(macOS)
        // .frame(minWidth: 600, minHeight: 450)
        // #endif
        .navigationDestination(for: StackPathPortolios.self) { path in
          switch path {
          case .root:
            PagePortfoliosRoot(fullPath: $fullPath, currentPath: $currentPath)
          case .portfolio(let username):
            PagePortfolio(username: username)
          case .portfolio_cv(let username):
            PagePortfolioCv(username: username)
          }
        }
    }
  }
}

struct PagePortfoliosRoot: View {
  @Binding var fullPath: [StackPathPortolios]
  @Binding var currentPath: StackPathPortolios?

  var body: some View {
    VStack {
      List(dbPortfolios.values, id: \.username) { p in
        NavigationLink(p.username, value: StackPathPortolios.portfolio(p.username))
      }
    }.navigationTitle("Portfolios")
  }
}

struct PagePortfolio: View {
  let username: String?

  var portfolio: Portfolio? {
    return dbPortfolios.doc(username)?.data
  }

  var body: some View {
    VStack {
      NavigationLink(value: StackPathPortolios.portfolio_cv(portfolio?.username)) {
        Text("See CV")
      }
    }
    .navigationTitle(portfolio?.username ?? "-")
  }
}

struct PagePortfolioCv: View {
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
      .navigationTitle("\(portfolio?.username ?? "")'s CV")
    }
  }
}

#Preview {
  PagePorfolios()
}
