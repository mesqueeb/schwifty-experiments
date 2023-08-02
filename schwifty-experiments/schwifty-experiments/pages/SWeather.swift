import SwiftUI

struct SWeather: View {
  // ╔═══════╗
  // ║ Props ║
  // ╚═══════╝
  let path: StackPath

  // ╔═══════╗
  // ║ Setup ║
  // ╚═══════╝
  @Environment(StackVC.self) private var stackVC

  // ╔══════════╗
  // ║ Template ║
  // ╚══════════╝
  var body: some View {
    CStack(scrollView: false, padding: .none) {
      //      CNavigationHeader(title)
      CWeather()
    }
  }
}

#Preview {
  let stackPathPerRootIndex: [StackPath] = [.weather, .portfolioFeed, .frameworks, .account]

  @State var stackVC = StackVC(initialRootIndex: 1, stackPathPerRootIndex)

  return SWeather(path: .weather)
    .environment(stackVC)
}
