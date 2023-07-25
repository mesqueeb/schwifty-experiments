import SwiftUI

struct PageWeather: View {
  let rootVC: RootVC
  @State var pathVC: PathVC

  init(rootVC: RootVC) {
    self.rootVC = rootVC
    _pathVC = State(initialValue: .init(initialStacks: [], rootVC: rootVC))
  }

  var body: some View {
    CResponsiveStacksView(stacks: $pathVC.stacks) {
      CWeather()
    }
    .environment(pathVC)
    .onAppear {
      rootVC.registerPathVC(root: .rootWeather, pathVC: pathVC)
    }
  }
}

#Preview {
  @ViewBuilder
  func pathToView(_ path: StackPath) -> some View {
    Text("404")
  }
  @State var rootVC: RootVC = .init(initialRoot: .rootAccount)

  return PageWeather(rootVC: rootVC)
}
