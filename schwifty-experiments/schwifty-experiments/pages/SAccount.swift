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
    CNavigationRow(title: "Weather App", stacks: [.weather]),
    CNavigationRow(title: "Frameworks Overview", stacks: [.frameworks]),
    CNavigationRow(title: "Barcode Scanner", stacks: [.barcodeScanner]),
    CNavigationRow(title: "Account Form", stacks: [.accountForm]),
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
  let stackPathPerRootIndex: [StackPath] = [.weather, .portfolioFeed, .frameworks, .account]

  @State var stackVC = StackVC(initialRootIndex: 1, stackPathPerRootIndex)

  return SAccount(path: .account)
    .environment(stackVC)
}
