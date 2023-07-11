import SwiftUI

struct FrameworkGrid: View {
  let clickItem: (_ payload: Framework) -> Void
  let columns: [GridItem] = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]

  var body: some View {
    LazyVGrid(columns: columns) {
      ForEach(dbFramework.values, id: \.name) { framework in
        FrameworkGridTile(framework: framework).onTapGesture {
          clickItem(framework)
        }
      }
    }
  }
}

#Preview {
  FrameworkGrid(clickItem: { _ in print(123) })
}
