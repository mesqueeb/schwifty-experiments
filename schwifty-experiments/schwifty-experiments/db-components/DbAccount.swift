import SwiftUI

struct DbAccount: View {
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
      CNavigationHeader(path, "🍳 Account")

      Button(action: { stackVC.pushTo(path, .barcodeScanner) }) {
        Text("Barcode Scanner")
      }
    }
  }
}

#Preview {
  @StateObject var stackVC = StackVC(initialRootIndex: 1)

  return DbAccount(path: .pageAccount)
    .environmentObject(stackVC)
}
