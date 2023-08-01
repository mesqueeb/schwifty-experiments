import SwiftUI

/// `CResponsiveStacks` is a SwiftUI view that displays different stacks of views based on the device's size class.
///
/// Relies on StackVC existence and must be able to access the stackVC via the environment.
///
/// It uses a horizontal size class environment value to determine whether to show one or two stacks of views.
struct CResponsiveStacks<Content: View>: View {
  // ╔═══════╗
  // ║ Props ║
  // ╚═══════╝
  let forRootIndex: Int
  let pathToView: (_ path: StackPath) -> Content

  // ╔═══════╗
  // ║ Setup ║
  // ╚═══════╝
  @Environment(StackVC.self) private var stackVC
  @Environment(\.horizontalSizeClass) private var horizontalSizeClass

  var rootPath: StackPath {
    stackVC.stackPathPerRootIndex[forRootIndex]
  }

  var stacks: Binding<[StackPath]> {
    switch forRootIndex {
    case 0:
      return Binding<[StackPath]>(
        get: { stackVC.stacks0 },
        set: { stackVC.stacks0 = $0 }
      )
    case 1:
      return Binding<[StackPath]>(
        get: { stackVC.stacks1 },
        set: { stackVC.stacks1 = $0 }
      )
    case 2:
      return Binding<[StackPath]>(
        get: { stackVC.stacks2 },
        set: { stackVC.stacks2 = $0 }
      )
    case 3:
      return Binding<[StackPath]>(
        get: { stackVC.stacks3 },
        set: { stackVC.stacks3 = $0 }
      )
    default:
      fatalError("Invalid root index")
    }
  }

  // ╔══════════╗
  // ║ Template ║
  // ╚══════════╝
  var body: some View {
    if horizontalSizeClass == .compact {
      NavigationStack(path: stacks) {
        pathToView(rootPath)
          .navigationDestination(for: StackPath.self) { path in
            pathToView(path)
          }
      }
    } else {
      ZStack(alignment: .topLeading) {
        Button(action: { stackVC.sidenavShown = .all }) {
          Image(systemName: "sidebar.left")
            .font(.title2)
            .fontWeight(.semibold)
            .foregroundColor(.primary)
        }
        .opacity(stackVC.sidenavShown != .all ? 1 : 0)
        .zIndex(stackVC.sidenavShown != .all ? 1 : -1)
        .padding()

        HStack(spacing: 0) {
          if stacks.wrappedValue.count < 2 {
            pathToView(rootPath)
              .containerRelativeFrame(.horizontal, count: stacks.count == 0 ? 1 : 2, spacing: 0)
              .transition(.move(edge: .leading))
              .id(rootPath)
          }

          ForEach(stacks.wrappedValue, id: \.id) { path in
            if stackVC.isVisibleStack(path) {
              pathToView(path)
                .containerRelativeFrame(.horizontal, count: stacks.count == 0 ? 1 : 2, spacing: 0)
                .transition(.move(edge: stacks.wrappedValue.last == path ? .trailing : .leading))
                .id(path)
            }
          }
        }
        #if os(iOS)
        .navigationBarHidden(true)
        #endif
      }
    }
  }
}

#Preview {
  let stackPathPerRootIndex: [StackPath] = [.pageWeather, .portfolioFeed, .pageFrameworks, .pageAccount]

  @State var stackVC = StackVC(initialRootIndex: 1, stackPathPerRootIndex, initialStacks: [[], [.publicPortfolio("Michael"), .publicPortfolioCv("Michael")]])
  @ViewBuilder func pathToView(_ path: StackPath) -> some View {
    switch path {
    case .portfolioFeed:
      SPortfolioFeed(path: .portfolioFeed)
    case .publicPortfolio(let username):
      SPublicPortfolio(path: .publicPortfolio(username), username: username)
    case .publicPortfolioCv(let username):
      SPublicPortfolioCv(path: .publicPortfolioCv(username), username: username)
    case .publicPortfolioCvEntry(let username, let entryId):
      SPublicPortfolioCvEntry(path: .publicPortfolioCvEntry(username, entryId), username: username, entryId: entryId)
    case .pageWeather:
      SWeather(path: .pageWeather)
    case .pageFrameworks:
      SFrameworks(path: .pageFrameworks)
    case .pageAccount:
      SAccount(path: .pageAccount)
    case .pageAccountForm:
      SAccountForm(path: .pageAccountForm)
    case .barcodeScanner:
      SBarcodeScanner(path: .barcodeScanner)
    case ._404:
      Text("404 🍕🧑🏼‍💻")
    }
  }

  return CResponsiveStacks(forRootIndex: 1, pathToView: pathToView)
    .environment(stackVC)
}
