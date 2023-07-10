import SwiftUI

struct AppLayout: View {
  @State private var selectedTab: StackPath = .account

  var body: some View {
    TabView(selection: $selectedTab) {
      NavigationView {
        PageWeather()
      }
      .tabItem {
        Image(systemName: "house")
        Text("Weather")
      }
      .tag(StackPath.weather)

      NavigationView {
        PagePorfolios()
      }
      .tabItem {
        Image(systemName: "house")
        Text("Portfolios")
      }
      .tag(StackPath.portfolios)

      NavigationView {
        PageFrameworks()
      }
      .tabItem {
        Image(systemName: "gear")
        Text("Frameworks")
      }
      .tag(StackPath.frameworks)

      NavigationView {
//        PageAccount()
      }
      .tabItem {
        Image(systemName: "person")
        Text("Account")
      }
      .tag(StackPath.account)
    }
  }
}

#Preview {
  AppLayout()
}
