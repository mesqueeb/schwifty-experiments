import SwiftUI

struct SAccount: View {
  // ╔═══════╗
  // ║ Props ║
  // ╚═══════╝
  let path: StackPath

  // ╔═══════╗
  // ║ Setup ║
  // ╚═══════╝
  @Environment(StackVC.self) private var stackVC
  let rows = [
    CNavigationRow(title: "Weather App", stacks: [.pageWeather]),
    CNavigationRow(title: "Frameworks Overview", stacks: [.pageFrameworks]),
    CNavigationRow(title: "Barcode Scanner", stacks: [.barcodeScanner]),
    CNavigationRow(title: "Account Form", stacks: [.pageAccountForm]),
  ]

  // ╔══════════╗
  // ║ Template ║
  // ╚══════════╝
  var body: some View {
    CStack(scrollView: true, padding: .a) {
      CNavigationHeader(path, "🍳 Account")

      CNavigationList(rows: rows)
    }
  }
}

#Preview {
  let stackPathPerRootIndex: [StackPath] = [.pageWeather, .portfolioFeed, .pageFrameworks, .pageAccount]

  @State var stackVC = StackVC(initialRootIndex: 1, stackPathPerRootIndex)

  return SAccount(path: .pageAccount)
    .environment(stackVC)
}
