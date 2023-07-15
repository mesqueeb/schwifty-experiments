import SwiftUI

struct PageFrameworks: View {
  let pathToView: (StackPath) -> AnyView

  @EnvironmentObject var stackVC: StackVC

  var body: some View {
    CResponsiveStacksView(stacks: $stackVC.stacks, pathToView: pathToView) {
      CFrameworks()
    }
  }
}

#Preview {
  func pathToView(_ path: StackPath) -> AnyView {
    return AnyView(Text("404"))
  }

  return PageFrameworks(pathToView: pathToView)
}
