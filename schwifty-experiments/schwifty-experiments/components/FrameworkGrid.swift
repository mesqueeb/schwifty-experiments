import SwiftUI

struct FrameworkGrid: View {
  // ╔═══════╗
  // ║ Props ║
  // ╚═══════╝
  let clickItem: (_ payload: Framework) -> Void
  let columns: [GridItem] = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]

  // ╔══════════╗
  // ║ Template ║
  // ╚══════════╝
  var body: some View {
    LazyVGrid(columns: columns) {
      ForEach(dbFramework.values, id: \.name) { framework in
        FrameworkGridTile(framework: framework).onTapGesture {
          clickItem(framework)
        }
      }
    }
    .contentMargins(.horizontal, Space.lg)
  }
}

#Preview {
  FrameworkGrid(clickItem: { _ in print(123) })
}
