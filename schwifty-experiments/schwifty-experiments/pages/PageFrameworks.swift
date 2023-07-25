import SwiftUI

struct PageFrameworks: View {
  @EnvironmentObject var stackVC: StackVC
  @Environment(\.horizontalSizeClass) private var horizontalSizeClass

  var body: some View {
    if horizontalSizeClass == .compact {
      NavigationStack(path: $stackVC.stacks2) {
        CFrameworks()
          .navigationDestination(for: StackPath.self) { path in
            pathToView(path)
          }
      }
    }
    else {
      HStack {
        CFrameworks()
        ForEach(stackVC.stacks2, id: \.self) { path in
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

  return PageFrameworks()
}
