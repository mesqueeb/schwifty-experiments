import SwiftUI

struct SFrameworks: View {
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
    CStack(scrollView: true, padding: .a) {
      CNavigationHeader(path, "🍏 Frameworks")

      DbFrameworkGrid(clickItem: { payload in shownFramework = payload })
        .sheet(item: $shownFramework) { framework in
          CSheet(close: { shownFramework = nil }) {
            Spacer()
            CFrameworkDetails(framework: framework)
            Spacer()
          }
        }
    }
  }
}

#Preview {
  let stackPathPerRootIndex: [StackPath] = [.weather, .portfolioFeed, .frameworks, .account]

  @State var stackVC = StackVC(initialRootIndex: 1, stackPathPerRootIndex)

  return SFrameworks(path: .frameworks)
    .environment(stackVC)
}
