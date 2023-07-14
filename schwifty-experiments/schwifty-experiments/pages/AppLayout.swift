import SwiftUI

struct AppLayout: View {
  @StateObject private var safari = Safari()

  @StateObject private var stackVC = StackVC(initialRoot: .rootAccount, initialRootCacheDic: [
    ._404: StackCache(fullPath: [._404]),
    .rootWeather: StackCache(fullPath: [.pageWeather]),
    .rootPortfolios: StackCache(fullPath: [.pagePortfolios]),
    .rootFrameworks: StackCache(fullPath: [.pageFrameworks]),
    .rootAccount: StackCache(fullPath: [.pageAccount]),
  ])

  let tabs: [StackRoot] = [.rootWeather, .rootPortfolios, .rootFrameworks, .rootAccount]

  var body: some View {
    AppTabView(tabs: tabs)
      .environmentObject(safari)
      .environmentObject(stackVC)
  }
}

#Preview {
  AppLayout()
}
