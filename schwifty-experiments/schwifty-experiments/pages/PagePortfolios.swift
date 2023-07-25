import SwiftUI

struct PagePortfolios: View {
  let rootVC: RootVC
  @State var pathVC: PathVC

  init(rootVC: RootVC) {
    self.rootVC = rootVC
    _pathVC = State(initialValue: .init(initialStacks: [], rootVC: rootVC))
  }

  var body: some View {
    CResponsiveStacksView(stacks: $pathVC.stacks) {
      DbPortfolioFeed()
    }
    .environment(pathVC)
    .onAppear {
      rootVC.registerPathVC(root: .rootPortfolios, pathVC: pathVC)
    }
  }
}

#Preview {
  @ViewBuilder
  func pathToView(_ path: StackPath) -> some View {
    Text("404")
  }
  @State var rootVC: RootVC = .init(initialRoot: .rootAccount)

  return PagePortfolios(rootVC: rootVC)
}
