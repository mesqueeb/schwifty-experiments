import SwiftUI

struct AppLayout: View {
  var body: some View {
    TabView {
      PageWeather()
        .tabItem {
          Image(systemName: "house")
          Text("Weather")
        }

      PageAccount()
        .tabItem {
          Image(systemName: "person")
          Text("Account")
        }
    }
  }
}

struct AppLayout_Previews: PreviewProvider {
  static var previews: some View {
    AppLayout()
  }
}
