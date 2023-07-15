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

  func pathToView(_ path: StackPath) -> AnyView {
    switch path {
    case .portfolioFeed:
      return AnyView(DbPortfolioFeed())
    case .publicPortfolio(let username):
      return AnyView(DbPublicPortfolio(username: username))
    case .publicPortfolioCv(let username):
      return AnyView(DbPublicPortfolioCv(username: username))
    case .pageWeather:
      return AnyView(CWeather())
    case .pageFrameworks:
      return AnyView(CFrameworks())
    case .pageAccount:
      return AnyView(CAccount())
    case ._404:
      return rootToView(._404)
    }
  }

  func rootToView(_ root: StackRoot) -> AnyView {
    switch root {
    case .rootWeather:
      return AnyView(PageWeather(pathToView: pathToView))
    case .rootPortfolios:
      return AnyView(PagePortfolios(pathToView: pathToView))
    case .rootFrameworks:
      return AnyView(PageFrameworks(pathToView: pathToView))
    case .rootAccount:
      return AnyView(PageAccount(pathToView: pathToView))
    case ._404:
      return AnyView(Text("404 🍕🧑🏼‍💻"))
    }
  }

  var body: some View {
    CResponsiveTabView(currentTab: $stackVC.currentRoot, tabs: tabs, tabItemDic: tabItemDic, rootToView: rootToView)
      .environmentObject(safari)
      .environmentObject(stackVC)
  }
}

#Preview {
  AppLayout()
}
