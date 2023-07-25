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
  let rootVC: RootVC
  let tabs: [StackRoot]
  let tabItemDic: [StackRoot: TabItem]

  var body: some View {
    @Bindable var rootVC = rootVC
    TabView(selection: $rootVC.currentRoot) {
      ForEach(tabs, id: \.self) { tab in
        rootToView(rootVC)
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

struct CTabViewWide: View {
  let rootVC: RootVC
  let tabs: [StackRoot]
  let tabItemDic: [StackRoot: TabItem]

  /// Required fix to get the correct overload that requires the selection to be optional
  var currentTabOptional: Binding<StackRoot?> {
    Binding<StackRoot?>(
      get: { self.rootVC.currentRoot },
      set: { newValue in
        if let newValue {
          self.rootVC.currentRoot = newValue
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
      rootToView(rootVC).id(rootVC.currentRoot.id)
    }
  }
}

struct CResponsiveTabView: View {
  let rootVC: RootVC
  let tabs: [StackRoot]
  let tabItemDic: [StackRoot: TabItem]

  @Environment(\.horizontalSizeClass) private var horizontalSizeClass

  var body: some View {
    if horizontalSizeClass == .compact {
      CTabViewCompact(rootVC: rootVC, tabs: tabs, tabItemDic: tabItemDic)
    } else {
      CTabViewWide(rootVC: rootVC, tabs: tabs, tabItemDic: tabItemDic)
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
  func rootToView(_ rootVC: RootVC) -> some View {
    switch rootVC.currentRoot {
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
  @State var rootVC: RootVC = .init(initialRoot: .rootAccount)

  // - CTabViewCompact works in preview
  // - CTabViewWide doesn't work in preview
  // - Both work in simulator
  return CResponsiveTabView(rootVC: rootVC, tabs: tabs, tabItemDic: tabItemDic)
}
