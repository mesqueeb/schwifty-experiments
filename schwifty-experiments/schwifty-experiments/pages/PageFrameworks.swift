import SwiftUI

struct PageFrameworks: View {
  let rootVC: RootVC
  @State var pathVC: PathVC

  init(rootVC: RootVC) {
    self.rootVC = rootVC
    _pathVC = State(initialValue: .init(initialStacks: [], rootVC: rootVC))
    rootVC.registerPathVC(root: .rootFrameworks, pathVC: pathVC)
  }

  var body: some View {
    CResponsiveStacksView(stacks: $pathVC.stacks) {
      CFrameworks()
    }
    .environment(pathVC)
    .onAppear {}
  }
}

#Preview {
  @ViewBuilder
  func pathToView(_ path: StackPath) -> some View {
    Text("404")
  }
  @State var rootVC: RootVC = .init(initialRoot: .rootAccount)

  return PageFrameworks(rootVC: rootVC)
}
