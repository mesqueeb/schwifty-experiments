import SwiftUI

struct PagePortfolios: View {
  let pathToView: (StackPath) -> AnyView

  @EnvironmentObject var stackVC: StackVC

  var body: some View {
    CResponsiveStacksView(stacks: $stackVC.stacks, pathToView: pathToView) {
      DbPortfolioFeed()
    }
  }
}

#Preview {
  func pathToView(_ path: StackPath) -> AnyView {
    return AnyView(Text("404"))
  }

  return PagePortfolios(pathToView: pathToView)
}
