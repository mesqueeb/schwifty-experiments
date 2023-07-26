import SwiftUI

let tabs: [TabItem] = [
  TabItem(title: "Weather", icon: "house", index: 0),
  TabItem(title: "Portfolios", icon: "house", index: 1),
  TabItem(title: "Frameworks", icon: "gear", index: 2),
  TabItem(title: "Account", icon: "person", index: 3),
]

struct AppLayout: View {
  // ╔═══════╗
  // ║ Setup ║
  // ╚═══════╝
  @StateObject private var safari = Safari()
  @StateObject private var stackVC = StackVC(initialRootIndex: 1)

  @Environment(\.horizontalSizeClass) private var horizontalSizeClass

  // ╔══════════╗
  // ║ Template ║
  // ╚══════════╝
  var body: some View {
    CResponsiveTabView(currentIndex: $stackVC.rootIndex, tabs: tabs)
      .environmentObject(safari)
      .environmentObject(stackVC)
      .onChange(of: horizontalSizeClass) { _, newSize in
        if newSize == .compact {
          stackVC.backupAndResetStacks()
        }
      }
  }
}

#Preview {
  @StateObject var stackVC = StackVC(initialRootIndex: 1)

  return AppLayout()
    .environmentObject(stackVC)
}
