import SwiftUI

struct AlertItem: Identifiable {
  let id = UUID()
  let title: String
  let message: String
  let dismissButton: Alert.Button
}

enum AlertContext {
  static let invalidDeviceInput = AlertItem(title: "Invalid Device Input",
                                            message: "Something is wrong with the camera. We are unable to capture the input.",
                                            dismissButton: .default(Text("OK")))

  static let invalidScannedType = AlertItem(title: "Invalid Scan Type",
                                            message: "The value scanned is not valid. This app scans EAN-8 and EAN-13.",
                                            dismissButton: .default(Text("OK")))
}

// class ShowAlert: ObservableObject {
//  @Published var isShowing = false
//  var message = ""
//
//  func show(_ message: String, duration: Double = 2) {
//    self.message = message
//    isShowing = true
//    DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
//      withAnimation {
//        self.isShowing = false
//      }
//    }
//  }
// }
//
// struct AlertView: View {
//  // ╔═══════╗
//  // ║ Setup ║
//  // ╚═══════╝
//  @ObservedObject var showToast: ShowAlert
//
//  // ╔══════════╗
//  // ║ Template ║
//  // ╚══════════╝
//  var body: some View {
//    VStack {}.alert()
//  }
// }
//
// #Preview {
//  let showToast = ShowAlert()
//  return ZStack {
//    AlertView(showToast: showToast).zIndex(2)
//
//    Button(action: { showToast.show("this is a toast") }) {
//      Text("show toast")
//    }
//  }
// }
