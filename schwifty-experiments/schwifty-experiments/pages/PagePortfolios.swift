import SwiftUI

struct PagePortfolios: View {
  @EnvironmentObject var stackVC: StackVC
  @Environment(\.horizontalSizeClass) private var horizontalSizeClass

  var body: some View {
    if horizontalSizeClass == .compact {
      NavigationStack(path: $stackVC.stacks1) {
        VStack {
          ForEach(stackVC.stacks1, id: \.self) { Ppath in
            Text(Ppath.id)
          }
          DbPortfolioFeed()
        }
        .navigationDestination(for: StackPath.self) { path in
          VStack {
            Text("===")
            Text(path.id)
            Text("===")
            ForEach(stackVC.stacks1, id: \.self) { _path in
              Text(_path.id)
            }
            Text("===")
            pathToView(path)
          }
        }
      }
    }
    else {
      HStack {
        DbPortfolioFeed()
        ForEach(stackVC.stacks1, id: \.self) { path in
          NavigationStack {
            pathToView(path)
          }
        }
      }
    }
  }
}

#Preview {
  @ViewBuilder
  func pathToView(_ path: StackPath) -> some View {
    Text("404")
  }

  return PagePortfolios()
}
