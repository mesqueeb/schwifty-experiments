import SwiftUI

struct DbWeather: View {
  // ╔═══════╗
  // ║ Props ║
  // ╚═══════╝
  let path: StackPath

  // ╔═══════╗
  // ║ Setup ║
  // ╚═══════╝
  @EnvironmentObject var stackVC: StackVC

  // ╔══════════╗
  // ║ Template ║
  // ╚══════════╝
  var body: some View {
    VStack {
//      CNavigationHeader(title)
      CWeather()
    }
  }
}

#Preview {
  DbWeather(path: .pageWeather)
}
