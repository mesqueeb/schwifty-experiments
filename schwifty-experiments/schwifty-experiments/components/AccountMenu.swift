import SwiftUI

struct AccountMenu: View {
  // ╔══════════╗
  // ║ Template ║
  // ╚══════════╝
  var body: some View {
    ForEach(["Settings", "About"], id: \.self) { sectionTitle in
      Text(sectionTitle)
    }
  }
}

#Preview {
  AccountMenu()
}
