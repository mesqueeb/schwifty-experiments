import SwiftUI

struct TabItem: Identifiable, Hashable, Equatable {
  let title: String
  let icon: String
  var id: String { title + icon }

  func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }
}

struct CTabViewCompact: View {
  @Binding var currentTab: StackRoot
  let tabs: [StackRoot]
  let tabItemDic: [StackRoot: TabItem]

  var body: some View {
    TabView(selection: $currentTab) {
      ForEach(tabs, id: \.self) { tab in
        rootToView(tab)
          .id(tab.id)
          .tabItem {
            if let item = tabItemDic[tab] {
              Image(systemName: item.icon)
              Text(item.title)
            }
          }
          .tag(tab)
      }
    }
  }
}

///// This component doesn't seem to work in preview, but it works in simulator.
struct CTabViewWide: View {
  @Binding var currentTab: StackRoot
  let tabs: [StackRoot]
  let tabItemDic: [StackRoot: TabItem]

  /// Required fix to get the correct overload that requires the selection to be optional
  var currentTabOptional: Binding<StackRoot?> {
    Binding<StackRoot?>(
      get: { self.currentTab },
      set: { newValue in
        if let newValue {
          self.currentTab = newValue
        }
      }
    )
  }

  var body: some View {
    NavigationSplitView {
      List(tabs, id: \.id, selection: currentTabOptional) { tab in
        if let item = tabItemDic[tab] {
          NavigationLink(value: tab) {
            HStack {
              Image(systemName: item.icon)
              Text(item.title)
            }
          }
        }
      }
      .navigationTitle("Get Schwifty")
      .listStyle(SidebarListStyle())
    } detail: {
      rootToView(currentTab).id(currentTab.id)
    }
  }
}

struct CResponsiveTabView: View {
  @Binding var currentTab: StackRoot
  let tabs: [StackRoot]
  let tabItemDic: [StackRoot: TabItem]

  @Environment(\.horizontalSizeClass) private var horizontalSizeClass

  var body: some View {
    if horizontalSizeClass == .compact {
      CTabViewCompact(currentTab: $currentTab, tabs: tabs, tabItemDic: tabItemDic)
    } else {
      CTabViewWide(currentTab: $currentTab, tabs: tabs, tabItemDic: tabItemDic)
    }
  }
}

#Preview {
  let tabs: [StackRoot] = [
    .rootWeather,
    .rootPortfolios,
    .rootFrameworks,
    .rootAccount,
  ]
  let tabItemDic: [StackRoot: TabItem] = [
    .rootWeather: TabItem(title: "Weather", icon: "house"),
    .rootPortfolios: TabItem(title: "Portfolios", icon: "house"),
    .rootFrameworks: TabItem(title: "Frameworks", icon: "gear"),
    .rootAccount: TabItem(title: "Account", icon: "person"),
  ]

  @ViewBuilder
  func rootToView(_ root: StackRoot) -> some View {
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
  @State var t: StackRoot = .rootAccount

  // - CTabViewCompact works in preview
  // - CTabViewWide doesn't work in preview
  // - Both work in simulator
  return CResponsiveTabView(currentTab: $t, tabs: tabs, tabItemDic: tabItemDic)
}
