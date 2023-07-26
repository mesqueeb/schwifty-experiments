import SwiftUI

struct CBarcodeCameraFinder: UIViewControllerRepresentable {
  @Binding var scannedCode: String
  @Binding var alert: AlertItem?

  func makeUIViewController(context: Context) -> ScannerVC {
    return ScannerVC(scannerDelegate: context.coordinator)
  }

  func updateUIViewController(_ uiViewController: ScannerVC, context: Context) {}

  func makeCoordinator() -> Coordinator {
    Coordinator(scannerView: self)
  }

  final class Coordinator: NSObject, ScannerVCDelegate {
    private let scannerView: CBarcodeCameraFinder

    init(scannerView: CBarcodeCameraFinder) {
      self.scannerView = scannerView
    }

    func didFind(barcode: String) {
      scannerView.scannedCode = barcode
    }

    func didSurface(error: CameraError) {
      switch error {
      case .invalidDeviceInput:
        scannerView.alert = AlertContext.invalidDeviceInput
      case .invalidScannedValue:
        scannerView.alert = AlertContext.invalidScannedType
      }
    }
  }
}
