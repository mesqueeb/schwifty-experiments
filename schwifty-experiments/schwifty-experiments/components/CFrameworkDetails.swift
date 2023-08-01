import SwiftUI

struct CFrameworkDetails: View {
  // ╔═══════╗
  // ║ Props ║
  // ╚═══════╝
  let framework: Framework

  // ╔══════════╗
  // ║ Template ║
  // ╚══════════╝
  var body: some View {
    VStack(spacing: 16) {
      CFrameworkGridTile(framework: framework)

      Text(framework.description)
        .font(.body)
        .padding()

      CButton(url: framework.url, label: "Learn More")
    }
  }
}

#Preview {
  CFrameworkDetails(framework: dbFramework.values[0])
}
