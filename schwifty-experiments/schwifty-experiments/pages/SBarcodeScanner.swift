import SwiftUI

struct SBarcodeScanner: View {
  // ╔═══════╗
  // ║ Props ║
  // ╚═══════╝
  let path: StackPath

  // ╔═══════╗
  // ║ Setup ║
  // ╚═══════╝
  @Environment(StackVC.self) private var stackVC

  @State private var scannedCode: String = ""
  @State private var alertItem: AlertItem?

  // ╔══════════╗
  // ║ Template ║
  // ╚══════════╝
  var body: some View {
    VStack {
      CNavigationHeader(path, "👁️ Barcode Scanner")

      VStack {
        #if os(iOS)
        CBarcodeCameraFinder(scannedCode: $scannedCode, alert: $alertItem)
          .frame(maxWidth: .infinity, maxHeight: 300)
        #endif

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

  @State var stackVC = StackVC(initialRootIndex: 1, stackPathPerRootIndex)

  return SBarcodeScanner(path: ._404)
    .environment(stackVC)
}
