import SwiftUI

struct PageFrameworks: View {
  @State private var shownFramework: Framework? = nil

  var body: some View {
    NavigationStack {
      ScrollView {
        FrameworkGrid(clickItem: { payload in shownFramework = payload })
          .padding()
      }
      .sheet(item: $shownFramework) { framework in
        CSheet(close: { shownFramework = nil }) {
          Spacer()
          FrameworkDetails(framework: framework)
          Spacer()
        }
      }
      .navigationTitle("🍏 Frameworks")
    }
  }
}

#Preview {
  PageFrameworks()
}
