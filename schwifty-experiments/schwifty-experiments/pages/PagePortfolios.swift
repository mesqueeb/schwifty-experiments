import SwiftUI

struct PagePortfolios: View {
  @EnvironmentObject var stackVC: StackVC

  var body: some View {
    CResponsiveStacksView(stacks: $stackVC.stacks) {
      DbPortfolioFeed()
    }
  }
}

#Preview {
  @ViewBuilder
  func pathToView(_ path: StackPath) -> some View {
    Text("404")
  }

  return PagePortfolios()
}
