import SwiftUI

struct CCompactView: View {
  let tabs: [StackRoot]
  @EnvironmentObject var stackVC: StackVC

  var body: some View {
    TabView(selection: $stackVC.currentRoot) {
      ForEach(tabs) { stackRoot in
        AppStacksView()
          .tabItem {
            Image(systemName: stackRoot.meta.icon)
            Text(stackRoot.meta.title)
          }
          .tag(stackRoot)
      }
    }
  }
}

struct CWideView: View {
  let tabs: [StackRoot]
  @EnvironmentObject var stackVC: StackVC

  var body: some View {
    NavigationSplitView {
      List(tabs, selection: $stackVC.currentRoot) { stackRoot in
        NavigationLink(stackRoot.meta.title, value: stackRoot)
//        {
//          HStack {
//            Image(systemName: tab.icon)
//            Text(tab.title)
//          }
//        }
      }
//      .listStyle(SidebarListStyle())
    } detail: {
      AppStacksView()
    }
  }
}

struct AppTabView: View {
  let tabs: [StackRoot]

  @Environment(\.horizontalSizeClass) private var horizontalSizeClass

  var body: some View {
    if horizontalSizeClass == .compact {
      CCompactView(tabs: tabs)
    } else {
      CWideView(tabs: tabs)
    }
  }
}

#Preview {
  let tabs: [StackRoot] = [.rootWeather, .rootPortfolios, .rootFrameworks, .rootAccount]

  return AppTabView(tabs: tabs)
}
