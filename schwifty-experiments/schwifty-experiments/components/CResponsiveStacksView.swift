import SwiftUI

struct CResponsiveStacksView<Content: View>: View {
  @Binding var stacks: [StackPath]
  let pathToView: (StackPath) -> AnyView
  let content: Content

  init(stacks: Binding<[StackPath]>, pathToView: @escaping (StackPath) -> AnyView, @ViewBuilder content: () -> Content) {
    self._stacks = stacks
    self.pathToView = pathToView
    self.content = content()
  }

  @Environment(\.horizontalSizeClass) private var horizontalSizeClass

  var body: some View {
    if horizontalSizeClass == .compact {
      NavigationStack(path: $stacks) {
        content
          .navigationDestination(for: StackPath.self) { path in
            pathToView(path)
          }
      }
    } else {
      HStack {
        content
        ForEach(stacks, id: \.self) { path in
          NavigationStack {
            pathToView(path)
          }
        }
      }
    }
  }
}

#Preview {
  @State var stacks: [StackPath] = [.publicPortfolio("Michael"), .publicPortfolioCv("Michael")]

  func pathToView(_ path: StackPath) -> AnyView {
    if case let .publicPortfolio(username) = path {
      return AnyView(Text(textIf(username) { "\($0)'s Portfolio'" }))
    }
    if case let .publicPortfolioCv(username) = path {
      return AnyView(Text(textIf(username) { "\($0)'s Cv" }))
    }
    return AnyView(Text("404"))
  }

  return CResponsiveStacksView(stacks: $stacks, pathToView: pathToView) {
    DbPortfolioFeed()
  }
}
