import SwiftUI

struct TabItem: Identifiable, Hashable {
  let title: String
  let icon: String
  var id: String { title + icon }

  func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }
}

struct CCompactView: View {
  @Binding var currentTab: StackRoot?
  let tabs: [StackRoot]
  let tabItemDic: [StackRoot: TabItem]
  let rootToView: (StackRoot) -> AnyView

  var body: some View {
    TabView(selection: $currentTab) {
      ForEach(tabs) { tab in
        rootToView(tab)
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

/// This component doesn't seem to work in preview, but it works in simulator.
struct CWideView: View {
  @Binding var currentTab: StackRoot?
  let tabs: [StackRoot]
  let tabItemDic: [StackRoot: TabItem]
  let rootToView: (StackRoot) -> AnyView

  var body: some View {
    NavigationSplitView {
      List(tabs, selection: $currentTab) { tab in
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
      if let currentTab {
        rootToView(currentTab)
      } else {
        rootToView(._404)
      }
    }
  }
}

struct CResponsiveTabView: View {
  @Binding var currentTab: StackRoot?
  let tabs: [StackRoot]
  let tabItemDic: [StackRoot: TabItem]
  let rootToView: (StackRoot) -> AnyView

  @Environment(\.horizontalSizeClass) private var horizontalSizeClass

  var body: some View {
    if horizontalSizeClass == .compact {
      CCompactView(currentTab: $currentTab, tabs: tabs, tabItemDic: tabItemDic, rootToView: rootToView)
    } else {
      CWideView(currentTab: $currentTab, tabs: tabs, tabItemDic: tabItemDic, rootToView: rootToView)
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
  func rootToView(_ root: StackRoot) -> AnyView {
    switch root {
    case .rootWeather:
      return AnyView(Text("Weather 🍕🧑🏼‍💻"))
    case .rootPortfolios:
      return AnyView(Text("Portfolios 🍕🧑🏼‍💻"))
    case .rootFrameworks:
      return AnyView(Text("Frameworks 🍕🧑🏼‍💻"))
    case .rootAccount:
      return AnyView(Text("Account 🍕🧑🏼‍💻"))
    case ._404:
      return AnyView(Text("404 🍕🧑🏼‍💻"))
    }
  }
  @State var t: StackRoot? = .rootAccount

  // - CCompactView works in preview
  // - CWideView doesn't work in preview
  // - Both work in simulator
  return CResponsiveTabView(currentTab: $t, tabs: tabs, tabItemDic: tabItemDic, rootToView: rootToView)
}
