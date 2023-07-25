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
  @EnvironmentObject var stackVC: StackVC
  @Environment(\.horizontalSizeClass) private var horizontalSizeClass

  var isTrailingStack: Bool { stackVC.isTrailingStack(path) }
  var isLeadingStack: Bool { stackVC.isLeadingStack(path) }
  var isCurrentStack: Bool { stackVC.isCurrentStack(path) }

  // ╔══════════╗
  // ║ Template ║
  // ╚══════════╝
  var body: some View {
    if horizontalSizeClass == .compact {
      VStack {}
        .navigationTitle(title)
    } else {
      HStack {
        HStack {
          if isTrailingStack {
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
        }
        Spacer()
        if isLeadingStack {
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

#Preview {
  CNavigationHeader(.pageAccount, "Joe")
}
