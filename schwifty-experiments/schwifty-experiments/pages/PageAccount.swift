import SwiftUI

struct PageAccount: View {
  @EnvironmentObject var stackVC: StackVC

  var body: some View {
    CResponsiveStacksView(stacks: $stackVC.stacks) {
      CAccount()
    }
  }
}

#Preview {
  @ViewBuilder
  func pathToView(_ path: StackPath) -> some View {
    Text("404")
  }

  return PageAccount()
}
