import SwiftUI

struct SlidingTransition: AnimatableModifier {
  var isActive: Bool
  var animatableData: CGFloat {
    didSet {
      if animatableData == 1 {
        isActive = true
      } else if animatableData == 0 {
        isActive = false
      }
    }
  }

  func body(content: Content) -> some View {
    content
      .offset(x: isActive ? 0 : UIScreen.main.bounds.width)
  }
}

extension AnyTransition {
  static var sliding: AnyTransition {
    .modifier(active: SlidingTransition(isActive: false, animatableData: 0),
              identity: SlidingTransition(isActive: true, animatableData: 1))
  }
}

struct PagePortfolios: View {
  // ╔═══════╗
  // ║ Setup ║
  // ╚═══════╝
  @EnvironmentObject var stackVC: StackVC
  @Environment(\.horizontalSizeClass) private var horizontalSizeClass

  var leadingPath: StackPath {
    stackVC.openBookStacks[0]
  }

  var trailingPath: StackPath? {
    stackVC.openBookStacks.count == 2
      ? stackVC.openBookStacks[1]
      : nil
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
            ScrollView {
              pathToView(leadingPath)
            }
            .id(leadingPath)
            .frame(width: trailingPath != nil ? geometry.size.width * 0.5 : geometry.size.width)
            .navigationBarHidden(true)
            .transition(.move(edge: .leading))

            if trailingPath != nil {
              ScrollView {
                pathToView(trailingPath!)
              }
              .id(trailingPath)
              .frame(width: geometry.size.width * 0.5)
              .navigationBarHidden(true)
              .transition(.move(edge: .trailing))
            }

//            ForEach(stackVC.openBookStacks, id: \.self) { path in
//              ScrollView {
//                pathToView(path)
//              }.id(path)
//                .frame(width: geometry.size.width * 0.5)
//                .navigationBarHidden(true)
//                .transition(.sliding)
//                .animation(.easeInOut, value: stackVC.openBookStacks)
//            }
          }
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
