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
        ScrollView {
          pathToView(.portfolioFeed)
        }
        .navigationDestination(for: StackPath.self) { path in
          pathToView(path)
        }
      }
    } else {
      GeometryReader { geometry in
        ZStack(alignment: .topLeading) {
          Button(action: { stackVC.sidenavShown = .all }) {
            Image(systemName: "sidebar.left")
              .font(.title2)
              .fontWeight(.semibold)
              .foregroundColor(.primary)
          }
          .opacity(stackVC.sidenavShown != .all ? 1 : 0)
          .zIndex(stackVC.sidenavShown != .all ? 1 : -1)

          HStack {
            if stackVC.stacks1.count < 2 {
              ScrollView { pathToView(stackVC.stackPathPerRootIndex[1]) }
                .id(stackVC.stackPathPerRootIndex[1])
                .frame(width: stackVC.stacks1.count == 0 ? geometry.size.width : geometry.size.width * 0.5)
                .transition(.move(edge: .leading))
                .animation(.smooth, value: stackVC.stacks1.count)
            }

            ForEach(stackVC.stacks1, id: \.id) { path in
              if stackVC.stacks1.last == path || stackVC.stacks1.suffix(2).first == path {
                ScrollView { pathToView(path) }
                  .id(path)
                  .frame(width: geometry.size.width * 0.5)
                  .transition(.move(edge: stackVC.stacks1.last == path ? .trailing : .leading))
              }
            }
          }
          .navigationBarHidden(true)
        }
      }
    }
  }
}

#Preview {
  let stackPathPerRootIndex: [StackPath] = [.pageWeather, .portfolioFeed, .pageFrameworks, .pageAccount]

  @StateObject var stackVC = StackVC(initialRootIndex: 1, stackPathPerRootIndex)
  @ViewBuilder func pathToView(_ path: StackPath) -> some View {
    Text("404")
  }

  return PagePortfolios()
    .environmentObject(stackVC)
}
