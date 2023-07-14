import SwiftUI

struct AppStacksView: View {
  @EnvironmentObject var stackVC: StackVC
  @Environment(\.horizontalSizeClass) private var horizontalSizeClass

  var body: some View {
    if horizontalSizeClass == .compact {
      NavigationStack(path: $stackVC.fullPath) {
        stackVC.currentPath?.view ?? StackPath._404.view
          .navigationDestination(for: StackPath.self) { path in
            path.view
          } as! AnyView
      }
    } else {
      HStack {
        ForEach(stackVC.fullPath, id: \.self) { path in
          NavigationStack {
            path.view
          }
        }
      }
    }
  }
}

#Preview {
  AppStacksView()
}
