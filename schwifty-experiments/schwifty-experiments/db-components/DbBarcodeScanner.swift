import SwiftUI

struct DbBarcodeScanner: View {
  // ╔═══════╗
  // ║ Props ║
  // ╚═══════╝
  let path: StackPath

  // ╔═══════╗
  // ║ Setup ║
  // ╚═══════╝
  @EnvironmentObject var stackVC: StackVC

  @State private var scannedCode: String = ""
  @State private var alertItem: AlertItem?

  // ╔══════════╗
  // ║ Template ║
  // ╚══════════╝
  var body: some View {
    VStack {
      CNavigationHeader(path, "👁️ Barcode Scanner")

      VStack {
        CBarcodeCameraFinder(scannedCode: $scannedCode, alert: $alertItem)
          .frame(maxWidth: .infinity, maxHeight: 300)

        Label("Scanned Barcode:", systemImage: "barcode.viewfinder")
          .font(.title)

        Text(scannedCode.isEmpty ? "Not Yet Scanned" : scannedCode)
          .bold()
          .font(.largeTitle)
          .foregroundColor(scannedCode.isEmpty ? .red : .green)
          .padding()
      }
      .alert(item: $alertItem) { alertItem in
        Alert(title: Text(alertItem.title),
              message: Text(alertItem.message),
              dismissButton: alertItem.dismissButton)
      }
    }
  }
}

#Preview {
  let stackPathPerRootIndex: [StackPath] = [.pageWeather, .portfolioFeed, .pageFrameworks, .pageAccount]

  @StateObject var stackVC = StackVC(initialRootIndex: 1, stackPathPerRootIndex)

  return DbBarcodeScanner(path: ._404)
    .environmentObject(stackVC)
}
