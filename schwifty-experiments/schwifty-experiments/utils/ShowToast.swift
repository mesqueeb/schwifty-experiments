import SwiftUI

@Observable final class ShowToast {
  public var isShowing = false

  public var message = ""

  func show(_ message: String, duration: Double = 2) {
    self.message = message
    isShowing = true
    DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
      withAnimation {
        self.isShowing = false
      }
    }
  }
}

struct ToastView: View {
  // ╔═══════╗
  // ║ Setup ║
  // ╚═══════╝
  var showToast: ShowToast

  // ╔══════════╗
  // ║ Template ║
  // ╚══════════╝
  var body: some View {
    if showToast.isShowing {
      Text(showToast.message)
        .foregroundColor(.white)
        .padding()
        .background(Color.black)
        .cornerRadius(8)
    }
  }
}

#Preview {
  let showToast = ShowToast()
  return ZStack {
    ToastView(showToast: showToast).zIndex(2)

    Button(action: { showToast.show("this is a toast") }) {
      Text("show toast")
    }
  }
}
