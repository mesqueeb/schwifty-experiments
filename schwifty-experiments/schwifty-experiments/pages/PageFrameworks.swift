import SwiftUI

struct PageFrameworks: View {
  @State private var shownFramework: Framework? = nil

  var body: some View {
    NavigationStack {
      ScrollView {
        FrameworkGrid(clickItem: { payload in shownFramework = payload })
      }
      .sheet(item: $shownFramework) { framework in
        FrameworkDetails(framework: framework)
      }
      .navigationTitle("🍏 Frameworks")
    }
  }
}

#Preview {
  PageFrameworks()
}
