import SwiftUI

struct CFrameworkGridTile: View {
  // ╔═══════╗
  // ║ Props ║
  // ╚═══════╝
  let framework: Framework

  // ╔══════════╗
  // ║ Template ║
  // ╚══════════╝
  var body: some View {
    VStack {
      Image(framework.imageName)
        .resizable().frame(width: 90, height: 90)
      Text(framework.name)
        .font(.title2).fontWeight(.semibold).scaledToFit().minimumScaleFactor(0.5)
    }
  }
}

#Preview {
  CFrameworkGridTile(framework: dbFramework.values[0])
}
