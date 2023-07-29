import SwiftUI

struct CFormAccount: View {
  // ╔═══════╗
  // ║ Props ║
  // ╚═══════╝
  @Binding var username: String

  // ╔══════════╗
  // ║ Template ║
  // ╚══════════╝
  var body: some View {
    Form {
      TextField("Username", text: $username)
    }
  }
}

#Preview {
  @State var username = ""

  return CFormAccount(username: $username)
}
