import SwiftUI

struct AppLayout: View {
  // ╔═══════╗
  // ║ Setup ║
  // ╚═══════╝
  let tabs: [TabItem] = [
    TabItem(title: "Appetizers", icon: "fork.knife.circle", index: 0),
    TabItem(title: "Order", icon: "takeoutbag.and.cup.and.straw", index: 1),
    TabItem(title: "Portfolios", icon: "doc.text.image", index: 2),
    TabItem(title: "Account", icon: "person", index: 3),
  ]
  @ViewBuilder func tabIndexToView(_ index: Int) -> some View {
    CResponsiveStacks(forRootIndex: index, pathToView: pathToView)
  }

  @State var stackVC = StackVC(initialRootIndex: 0, [.appetizerList, .appetizerOrder, .portfolioFeed, .account])
  @State var safari = Safari()
  @State var dbAppetizers = Collection<Appetizer>(fetchFn: NetworkManager<Appetizer>(fetchUrl: "https://seanallen-course-backend.herokuapp.com/swiftui-fundamentals/appetizers").fetch)

  @Environment(\.horizontalSizeClass) private var horizontalSizeClass

  // ╔══════════╗
  // ║ Template ║
  // ╚══════════╝
  var body: some View {
    CResponsiveTabView(tabs: tabs, tabIndexToView: tabIndexToView, currentIndex: $stackVC.rootIndex, sidenavShown: $stackVC.sidenavShown)
      .environment(stackVC)
      .environment(safari)
      .environment(dbAppetizers)
      .onChange(of: horizontalSizeClass) { _, newSize in
        if newSize == .compact {
          stackVC.backupAndResetStacks()
        }
      }
  }
}

#Preview {
  let stackPathPerRootIndex: [StackPath] = [.appetizerList, .appetizerOrder, .portfolioFeed, .account]

  @State var stackVC = StackVC(initialRootIndex: 0, stackPathPerRootIndex)

  return AppLayout()
    .environment(stackVC)
}
