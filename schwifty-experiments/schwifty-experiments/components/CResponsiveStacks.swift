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
        ScrollView { pathToView(rootPath) }
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
            if stacks.wrappedValue.count < 2 {
              ScrollView { pathToView(rootPath) }
                .id(rootPath)
                .frame(width: stacks.wrappedValue.count == 0 ? geometry.size.width : geometry.size.width * 0.5)
                .transition(.move(edge: .leading))
            }

            ForEach(stacks.wrappedValue, id: \.id) { path in
              if stackVC.isVisibleStack(path) {
                ScrollView { pathToView(path) }
                  .id(path)
                  .frame(width: geometry.size.width * 0.5)
                  .transition(.move(edge: stacks.wrappedValue.last == path ? .trailing : .leading))
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
}

#Preview {
  let stackPathPerRootIndex: [StackPath] = [.pageWeather, .portfolioFeed, .pageFrameworks, .pageAccount]

  @State var stackVC = StackVC(initialRootIndex: 1, stackPathPerRootIndex)
  @ViewBuilder func pathToView(_ path: StackPath) -> some View {
    Text("404")
  }

  return CResponsiveStacks(forRootIndex: 1, pathToView: pathToView)
    .environment(stackVC)
}
