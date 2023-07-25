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
  @State private var safari = Safari()
  let rootVC = RootVC(initialRoot: .rootWeather)

  var body: some View {
    CResponsiveTabView(rootVC: rootVC, tabs: tabs, tabItemDic: tabItemDic)
      .environment(safari)
      .environment(rootVC)
  }
}

#Preview {
  AppLayout()
}
