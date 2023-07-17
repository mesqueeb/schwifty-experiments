import SwiftUI

struct PageWeather: View {
  @EnvironmentObject var stackVC: StackVC

  var body: some View {
    CResponsiveStacksView(stacks: $stackVC.stacks) {
      CWeather()
    }
  }
}

#Preview {
  @ViewBuilder
  func pathToView(_ path: StackPath) -> some View {
    Text("404")
  }

  return PageWeather()
}
