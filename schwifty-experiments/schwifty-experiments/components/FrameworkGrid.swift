import SwiftUI

struct FrameworkGrid: View {
  let show: (_ payload: Framework) -> Void
  let columns: [GridItem] = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]

  var body: some View {
    LazyVGrid(columns: columns) {
      ForEach(dbFramework.values, id: \.name) { framework in
        FrameworkGridTile(framework: framework).onTapGesture {
          show(framework)
        }
      }
    }
  }
}

#Preview {
  FrameworkGrid(show: { _ in print(123) })
}
