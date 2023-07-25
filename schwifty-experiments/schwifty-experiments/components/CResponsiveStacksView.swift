// import SwiftUI
//
// struct CResponsiveStacksView<Content: View>: View {
//  @Binding var stacks: [StackPath]
//  let content: Content
//
//  init(stacks: Binding<[StackPath]>, @ViewBuilder content: () -> Content) {
//    self._stacks = stacks
//    self.content = content()
//  }
//
//  @Environment(\.horizontalSizeClass) private var horizontalSizeClass
//
//  var body: some View {
//    if horizontalSizeClass == .compact {
//      NavigationStack(path: $stacks) {
//        content
//          .navigationDestination(for: StackPath.self) { path in
//            pathToView(path)
//          }
//      }
//    }
//    else {
//      HStack {
//        content
//        ForEach(stacks, id: \.self) { path in
//          NavigationStack {
//            pathToView(path)
//          }
//        }
//      }
//    }
//  }
// }
//
// #Preview {
//  @State var stacks: [StackPath] = [.publicPortfolio("Michael"), .publicPortfolioCv("Michael")]
//
//  @ViewBuilder
//  func pathToView(_ path: StackPath) -> some View {
//    if case let .publicPortfolio(username) = path {
//      Text(textIf(username) { "\($0)'s Portfolio'" })
//    }
//    else if case let .publicPortfolioCv(username) = path {
//      Text(textIf(username) { "\($0)'s Cv" })
//    }
//    else {
//      Text("404")
//    }
//  }
//
//  return CResponsiveStacksView(stacks: $stacks) {
//    DbPortfolioFeed()
//  }
// }
