import SwiftUI

struct DbFrameworks: View {
  // ╔═══════╗
  // ║ Props ║
  // ╚═══════╝
  let path: StackPath

  // ╔═══════╗
  // ║ Setup ║
  // ╚═══════╝
  @State private var shownFramework: Framework? = nil

  // ╔══════════╗
  // ║ Template ║
  // ╚══════════╝
  var body: some View {
    ScrollView {
      CNavigationHeader(path, "🍏 Frameworks")

      FrameworkGrid(clickItem: { payload in shownFramework = payload })
        .padding()
    }
    .sheet(item: $shownFramework) { framework in
      CSheet(close: { shownFramework = nil }) {
        Spacer()
        FrameworkDetails(framework: framework)
        Spacer()
      }
    }
  }
}

#Preview {
  let stackPathPerRootIndex: [StackPath] = [.pageWeather, .portfolioFeed, .pageFrameworks, .pageAccount]

  @StateObject var stackVC = StackVC(initialRootIndex: 1, stackPathPerRootIndex)

  return DbFrameworks(path: .pageFrameworks)
    .environmentObject(stackVC)
}