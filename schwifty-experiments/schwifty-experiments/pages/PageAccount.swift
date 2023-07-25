import SwiftUI

struct PageAccount: View {
  @EnvironmentObject var stackVC: StackVC
  @Environment(\.horizontalSizeClass) private var horizontalSizeClass

  var body: some View {
    if horizontalSizeClass == .compact {
      NavigationStack(path: $stackVC.stacks3) {
        CAccount()
          .navigationDestination(for: StackPath.self) { path in
            pathToView(path)
          }
      }
    }
    else {
      HStack {
        CAccount()
        ForEach(stackVC.stacks3, id: \.self) { path in
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

  return PageAccount()
}
