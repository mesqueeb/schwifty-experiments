import SwiftUI

struct PageAccount: View {
  @Environment(\.horizontalSizeClass) private var horizontalSizeClass

  @State private var path: [StackPath] = []
  @State private var currentPath: StackPath?

  var body: some View {
    NavigationStack {
      VStack {
        Text("Horizontal Size Class: \(horizontalSizeClass.debugDescription)")
        Text(currentPath?.id ?? "")
      }
      .navigationTitle("🍳 Account")
    }
  }
}

#Preview {
  PageAccount()
}
