import SwiftUI

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

struct AppLayout: View {
  @StateObject private var safari = Safari()

  @StateObject private var stackVC = StackVC(initialRoot: .rootWeather, initialRootCacheDic: [
    ._404: StackCache(stacks: []),
    .rootWeather: StackCache(stacks: []),
    .rootPortfolios: StackCache(stacks: []),
    .rootFrameworks: StackCache(stacks: []),
    .rootAccount: StackCache(stacks: []),
  ])

  var body: some View {
    CResponsiveTabView(currentTab: $stackVC.currentRoot, tabs: tabs, tabItemDic: tabItemDic)
      .environmentObject(safari)
      .environmentObject(stackVC)
  }
}

#Preview {
  AppLayout()
}
