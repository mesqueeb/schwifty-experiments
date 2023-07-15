import SwiftUI

struct AccountMenu: View {
  var body: some View {
    ForEach(["Settings", "About"], id: \.self) { sectionTitle in
      Text(sectionTitle)
    }
  }
}

#Preview {
  AccountMenu()
}
