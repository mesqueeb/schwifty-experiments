import SwiftUI

struct PageWeather: View {
  @EnvironmentObject var stackVC: StackVC
  @Environment(\.horizontalSizeClass) private var horizontalSizeClass

  var body: some View {
    if horizontalSizeClass == .compact {
      NavigationStack(path: $stackVC.stacks0) {
        CWeather()
          .navigationDestination(for: StackPath.self) { path in
            pathToView(path)
          }
      }
    }
    else {
      HStack {
        CWeather()
        ForEach(stackVC.stacks0, id: \.self) { path in
          NavigationStack {
            pathToView(path)
          }
        }
      }
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
