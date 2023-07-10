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
      .tag("/weather")

      NavigationView {
//        PageAccount()
      }
      .tabItem {
        Image(systemName: "person")
        Text("Account")
      }
      .tag("/account")
    }
  }
}

#Preview {
  AppLayout()
}
