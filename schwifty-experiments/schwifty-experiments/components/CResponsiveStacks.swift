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
        CResponsiveStack(stacks: stacks.wrappedValue) {
          pathToView(rootPath)
        }
        .navigationDestination(for: StackPath.self) { path in
          CResponsiveStack(stacks: stacks.wrappedValue) {
            pathToView(path)
          }
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
            CResponsiveStack(stacks: stacks.wrappedValue) {
              pathToView(rootPath)
            }
            .transition(.move(edge: .leading))
            .id(rootPath)
          }

          ForEach(stacks.wrappedValue, id: \.id) { path in
            if stackVC.isVisibleStack(path) {
              CResponsiveStack(stacks: stacks.wrappedValue) {
                pathToView(path)
              }
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
      DbPortfolioFeed(path: .portfolioFeed)
    case .publicPortfolio(let username):
      DbPublicPortfolio(path: .publicPortfolio(username), username: username)
    case .publicPortfolioCv(let username):
      DbPublicPortfolioCv(path: .publicPortfolioCv(username), username: username)
    case .publicPortfolioCvEntry(let username, let entryId):
      DbPublicPortfolioCvEntry(path: .publicPortfolioCvEntry(username, entryId), username: username, entryId: entryId)
    case .pageWeather:
      DbWeather(path: .pageWeather)
    case .pageFrameworks:
      DbFrameworks(path: .pageFrameworks)
    case .pageAccount:
      DbAccount(path: .pageAccount)
    case .pageAccountForm:
      DbAccountForm(path: .pageAccountForm)
    case .barcodeScanner:
      DbBarcodeScanner(path: .barcodeScanner)
    case ._404:
      Text("404 🍕🧑🏼‍💻")
    }
  }

  return CResponsiveStacks(forRootIndex: 1, pathToView: pathToView)
    .environment(stackVC)
}
