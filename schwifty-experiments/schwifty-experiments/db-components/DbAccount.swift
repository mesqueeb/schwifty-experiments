import SwiftUI

struct DbAccount: View {
  // ╔═══════╗
  // ║ Props ║
  // ╚═══════╝
  let path: StackPath

  // ╔══════════╗
  // ║ Template ║
  // ╚══════════╝
  var body: some View {
    VStack {
      CNavigationHeader(path, "🍳 Account")
    }
  }
}

#Preview {
  DbAccount(path: .pageAccount)
}
