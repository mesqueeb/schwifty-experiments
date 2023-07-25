import SwiftUI

struct PagePortfolios: View {
  // ╔═══════╗
  // ║ Setup ║
  // ╚═══════╝
  @EnvironmentObject var stackVC: StackVC
  @Environment(\.horizontalSizeClass) private var horizontalSizeClass

  // ╔══════════╗
  // ║ Template ║
  // ╚══════════╝
  var body: some View {
    if horizontalSizeClass == .compact {
      NavigationStack(path: $stackVC.stacks1) {
        DbPortfolioFeed(path: .portfolioFeed)
          .navigationDestination(for: StackPath.self) { path in
            pathToView(path)
          }
      }
    }
    else {
      GeometryReader { geometry in
        HStack {
          DbPortfolioFeed(path: .portfolioFeed)
          ForEach(stackVC.openBookStacks, id: \.self) { path in
            ScrollView {
              pathToView(path)
            }
            .frame(width: geometry.size.width * 0.5)
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
