import SwiftUI

struct DbAccount: View {
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
    VStack {
      CNavigationHeader(path, "🍳 Account")

      Button(action: { stackVC.pushTo(path, .barcodeScanner) }) {
        Text("Barcode Scanner")
      }
      Button(action: { stackVC.pushTo(path, .pageAccountForm) }) {
        Text("Account Form")
      }
    }
  }
}

#Preview {
  let stackPathPerRootIndex: [StackPath] = [.pageWeather, .portfolioFeed, .pageFrameworks, .pageAccount]

  @State var stackVC = StackVC(initialRootIndex: 1, stackPathPerRootIndex)

  return DbAccount(path: .pageAccount)
    .environment(stackVC)
}
