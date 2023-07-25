import SwiftUI

struct FrameworkDetails: View {
  // ╔═══════╗
  // ║ Props ║
  // ╚═══════╝
  let framework: Framework

  // ╔══════════╗
  // ║ Template ║
  // ╚══════════╝
  var body: some View {
    VStack(spacing: 16) {
      FrameworkGridTile(framework: framework)

      Text(framework.description)
        .font(.body)
        .padding()

      SchwiftyButton(url: framework.url, label: "Learn More")
    }
  }
}

#Preview {
  FrameworkDetails(framework: dbFramework.values[0])
}
