import SwiftUI

struct AppLayout: View {
  // ╔═══════╗
  // ║ Setup ║
  // ╚═══════╝
  let tabs: [TabItem] = [
    TabItem(title: "Weather", icon: "house", index: 0),
    TabItem(title: "Portfolios", icon: "house", index: 1),
    TabItem(title: "Frameworks", icon: "gear", index: 2),
    TabItem(title: "Account", icon: "person", index: 3),
  ]
  @ViewBuilder func tabIndexToView(_ index: Int) -> some View {
    CResponsiveStacks(forRootIndex: index, pathToView: pathToView)
  }

  @StateObject private var safari = Safari()
  @StateObject private var stackVC = StackVC(initialRootIndex: 1, [.pageWeather, .portfolioFeed, .pageFrameworks, .pageAccount])

  @Environment(\.horizontalSizeClass) private var horizontalSizeClass

  // ╔══════════╗
  // ║ Template ║
  // ╚══════════╝
  var body: some View {
    CResponsiveTabView(tabs: tabs, tabIndexToView: tabIndexToView, currentIndex: $stackVC.rootIndex, sidenavShown: $stackVC.sidenavShown)
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
  let stackPathPerRootIndex: [StackPath] = [.pageWeather, .portfolioFeed, .pageFrameworks, .pageAccount]

  @StateObject var stackVC = StackVC(initialRootIndex: 1, stackPathPerRootIndex)

  return AppLayout()
    .environmentObject(stackVC)
}
