import SwiftUI

struct PageFrameworks: View {
  @EnvironmentObject var stackVC: StackVC

  var body: some View {
    CResponsiveStacksView(stacks: $stackVC.stacks) {
      CFrameworks()
    }
  }
}

#Preview {
  @ViewBuilder
  func pathToView(_ path: StackPath) -> some View {
    Text("404")
  }

  return PageFrameworks()
}
