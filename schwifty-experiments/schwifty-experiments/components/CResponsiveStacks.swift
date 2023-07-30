import SwiftUI

struct CResponsiveStacks<Content: View>: View {
  // ╔═══════╗
  // ║ Props ║
  // ╚═══════╝
  let forRootIndex: Int
  let pathToView: (_ path: StackPath) -> Content

  // ╔═══════╗
  // ║ Setup ║
  // ╚═══════╝
  @EnvironmentObject var stackVC: StackVC
  @Environment(\.horizontalSizeClass) private var horizontalSizeClass

  var rootPath: StackPath {
    stackVC.stackPathPerRootIndex[forRootIndex]
  }

  var stacks: [StackPath] {
    switch forRootIndex {
      case 0:
        return stackVC.stacks0
      case 1:
        return stackVC.stacks1
      case 2:
        return stackVC.stacks2
      case 3:
        return stackVC.stacks3
      default:
        return [._404]
    }
  }

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
            if stacks.count < 2 {
              ScrollView { pathToView(rootPath) }
                .id(rootPath)
                .frame(width: stacks.count == 0 ? geometry.size.width : geometry.size.width * 0.5)
                .transition(.move(edge: .leading))
                .animation(.smooth, value: stacks.count)
            }

            ForEach(stacks, id: \.id) { path in
              if stacks.last == path || stacks.suffix(2).first == path {
                ScrollView { pathToView(path) }
                  .id(path)
                  .frame(width: geometry.size.width * 0.5)
                  .transition(.move(edge: stacks.last == path ? .trailing : .leading))
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

  return CResponsiveStacks(forRootIndex: 1, pathToView: pathToView)
    .environmentObject(stackVC)
}
