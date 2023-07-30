import SwiftUI

struct CNavigationHeader: View {
  // ╔═══════╗
  // ║ Props ║
  // ╚═══════╝
  let path: StackPath
  let title: String

  init(_ path: StackPath, _ title: String) {
    self.path = path
    self.title = title
  }

  // ╔═══════╗
  // ║ Setup ║
  // ╚═══════╝
  @Environment(StackVC.self) private var stackVC
  @Environment(\.horizontalSizeClass) private var horizontalSizeClass

  var isLeadingStack: Bool { stackVC.isLeadingStack(path) }
  var isTrailingStack: Bool { stackVC.isTrailingStack(path) }
  var isCurrentStack: Bool { stackVC.isCurrentStack(path) }
  var isRootStack: Bool { stackVC.isRootStack(path) }

  // ╔══════════╗
  // ║ Template ║
  // ╚══════════╝
  var body: some View {
    if horizontalSizeClass == .compact {
      VStack {}
        .navigationTitle(title)
    } else {
      VStack {
        HStack {
          if isLeadingStack && !isRootStack {
            Button(action: { stackVC.back() }) {
              Image(systemName: "arrow.left")
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(.primary)
            }
          }
          Text(title)
            .font(.largeTitle)
            .fontWeight(.semibold)
            .foregroundColor(.primary)
          Spacer()
          if isTrailingStack {
            Button(action: { stackVC.back() }) {
              Image(systemName: "xmark")
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(.primary)
            }
          }
        }
      }
    }
  }
}

#Preview {
  CNavigationHeader(.pageAccount, "Joe")
}
