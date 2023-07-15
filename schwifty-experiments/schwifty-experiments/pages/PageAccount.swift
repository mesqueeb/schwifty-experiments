import SwiftUI

struct PageAccount: View {
  let pathToView: (StackPath) -> AnyView

  @EnvironmentObject var stackVC: StackVC

  var body: some View {
    CResponsiveStacksView(stacks: $stackVC.stacks, pathToView: pathToView) {
      CAccount()
    }
  }
}

#Preview {
  func pathToView(_ path: StackPath) -> AnyView {
    return AnyView(Text("404"))
  }

  return PageAccount(pathToView: pathToView)
}
