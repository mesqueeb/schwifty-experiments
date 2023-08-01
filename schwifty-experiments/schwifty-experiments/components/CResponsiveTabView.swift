import SwiftUI

struct TabItem: Identifiable, Hashable, Equatable {
  let title: String
  let icon: String
  let index: Int
  var id: String { title + icon }

  func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }
}

struct CTabViewCompact<Content: View>: View {
  // ╔═══════╗
  // ║ Props ║
  // ╚═══════╝
  let tabs: [TabItem]
  let tabIndexToView: (Int) -> Content
  @Binding var currentIndex: Int

  // ╔══════════╗
  // ║ Template ║
  // ╚══════════╝
  var body: some View {
    TabView(selection: $currentIndex) {
      ForEach(tabs, id: \.self) { tab in
        tabIndexToView(tab.index)
          .id(tab.id)
          .tabItem {
            Image(systemName: tab.icon)
            Text(tab.title)
          }
          .tag(tab.index)
      }
    }
  }
}

struct CTabViewWide<Content: View>: View {
  // ╔═══════╗
  // ║ Props ║
  // ╚═══════╝
  let tabs: [TabItem]
  let tabIndexToView: (Int) -> Content
  @Binding var currentIndex: Int
  @Binding var sidenavShown: NavigationSplitViewVisibility

  // ╔═══════╗
  // ║ Setup ║
  // ╚═══════╝
  /// Required fix to get the correct overload that requires the selection to be optional
  var currentIndexOptional: Binding<Int?> {
    Binding<Int?>(
      get: { self.currentIndex },
      set: { newValue in
        if let newValue {
          self.currentIndex = newValue
        }
      }
    )
  }

  // ╔══════════╗
  // ║ Template ║
  // ╚══════════╝
  var body: some View {
    NavigationSplitView(columnVisibility: $sidenavShown) {
      List(tabs.indices, id: \.self, selection: currentIndexOptional) { tabIndex in
        let tab = tabs[tabIndex]
        NavigationLink(value: tabIndex) {
          HStack {
            Image(systemName: tab.icon)
            Text(tab.title)
          }
        }
      }
      #if os(iOS)
      .navigationBarHidden(true)
      #endif
      .listStyle(SidebarListStyle())
      .onChange(of: currentIndex) { _, _ in
        self.sidenavShown = .detailOnly
      }
    } detail: {
      tabIndexToView(currentIndex)
        .id(currentIndex)
    }
  }
}

struct CResponsiveTabView<Content: View>: View {
  // ╔═══════╗
  // ║ Props ║
  // ╚═══════╝
  let tabs: [TabItem]
  let tabIndexToView: (Int) -> Content
  @Binding var currentIndex: Int
  @Binding var sidenavShown: NavigationSplitViewVisibility

  // ╔═══════╗
  // ║ Setup ║
  // ╚═══════╝
  @Environment(\.horizontalSizeClass) private var horizontalSizeClass

  // ╔══════════╗
  // ║ Template ║
  // ╚══════════╝
  var body: some View {
    if horizontalSizeClass == .compact {
      CTabViewCompact(tabs: tabs, tabIndexToView: tabIndexToView, currentIndex: $currentIndex)
    } else {
      CTabViewWide(tabs: tabs, tabIndexToView: tabIndexToView, currentIndex: $currentIndex, sidenavShown: $sidenavShown)
    }
  }
}

#Preview {
  let stackPathPerRootIndex: [StackPath] = [.weather, .portfolioFeed, .frameworks, .account]
  @State var stackVC = StackVC(initialRootIndex: 0, stackPathPerRootIndex)
  @State var safari = Safari()

  let tabs: [TabItem] = [
    TabItem(title: "Weather", icon: "house", index: 0),
    TabItem(title: "Portfolios", icon: "house", index: 1),
    TabItem(title: "Frameworks", icon: "gear", index: 2),
    TabItem(title: "Account", icon: "person", index: 3),
  ]
  @ViewBuilder func tabIndexToView(_ index: Int) -> some View {
    switch index {
    case 0:
      Text("Weather 🍕🧑🏼‍💻")
    case 1:
      Text("Portfolios 🍕🧑🏼‍💻")
    case 2:
      Text("Frameworks 🍕🧑🏼‍💻")
    case 3:
      Text("Account 🍕🧑🏼‍💻")
    default:
      Text("404 🍕🧑🏼‍💻")
    }
  }
  @State var t: Int = 0
  @State var sidenavShown: NavigationSplitViewVisibility = .detailOnly

  return CResponsiveTabView(tabs: tabs, tabIndexToView: tabIndexToView, currentIndex: $t, sidenavShown: $sidenavShown)
    .environment(stackVC)
    .environment(safari)
}
