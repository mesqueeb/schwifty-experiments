import SwiftUI

struct DbFrameworkGrid: View {
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
        CFrameworkGridTile(framework: framework).onTapGesture {
          clickItem(framework)
        }
      }
    }
    .contentMargins(.horizontal, Space.lg)
  }
}

#Preview {
  DbFrameworkGrid(clickItem: { _ in print(123) })
}
