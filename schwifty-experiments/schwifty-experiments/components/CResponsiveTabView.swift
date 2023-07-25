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

struct CTabViewCompact: View {
  @Binding var currentIndex: Int
  let tabs: [TabItem]

  var body: some View {
    TabView(selection: $currentIndex) {
      ForEach(tabs, id: \.self) { tab in
        rootToView(rootPerIndex[tab.index])
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

struct CTabViewWide: View {
  @Binding var currentIndex: Int
  let tabs: [TabItem]

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

  var body: some View {
    NavigationSplitView {
      List(tabs.indices, id: \.self, selection: currentIndexOptional) { tabIndex in
        let tab = tabs[tabIndex]
        NavigationLink(value: tabIndex) {
          HStack {
            Image(systemName: tab.icon)
            Text(tab.title)
          }
        }
      }
      .navigationTitle("Get Schwifty")
      .listStyle(SidebarListStyle())
    } detail: {
      rootToView(rootPerIndex[tabs[currentIndex].index])
        .id(currentIndex)
    }
  }
}

struct CResponsiveTabView: View {
  @Binding var currentIndex: Int
  let tabs: [TabItem]

  @Environment(\.horizontalSizeClass) private var horizontalSizeClass

  var body: some View {
    if horizontalSizeClass == .compact {
      CTabViewCompact(currentIndex: $currentIndex, tabs: tabs)
    } else {
      CTabViewWide(currentIndex: $currentIndex, tabs: tabs)
    }
  }
}

#Preview {
  let tabs: [TabItem] = [
    .rootWeather: TabItem(title: "Weather", icon: "house".index: 0),
    .rootPortfolios: TabItem(title: "Portfolios", icon: "house".index: 1),
    .rootFrameworks: TabItem(title: "Frameworks", icon: "gear".index: 2),
    .rootAccount: TabItem(title: "Account", icon: "person".index: 3),
  ]

  @ViewBuilder
  func rootToView(_ root: Int) -> some View {
    switch root {
    case .rootWeather:
      Text("Weather 🍕🧑🏼‍💻")
    case .rootPortfolios:
      Text("Portfolios 🍕🧑🏼‍💻")
    case .rootFrameworks:
      Text("Frameworks 🍕🧑🏼‍💻")
    case .rootAccount:
      Text("Account 🍕🧑🏼‍💻")
    case ._404:
      Text("404 🍕🧑🏼‍💻")
    }
  }
  @State var t: Int = 0

  return CResponsiveTabView(currentIndex: $t, tabs: tabs)
}
