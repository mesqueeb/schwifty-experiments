import SwiftUI

struct PageFrameworks: View {
  @State private var shownFramework: Framework? = nil
  @State private var isShown: Bool = false

  var body: some View {
    NavigationStack {
      ScrollView {
        FrameworkGrid(show: { payload in
          shownFramework = payload
          isShown = true
        })
      }
      .navigationTitle("🍏 Frameworks")
      .sheet(isPresented: $isShown, content: {
        if let shownFramework {
          FrameworkDetails(framework: shownFramework)
        }
      })
    }
  }
}

#Preview {
  PageFrameworks()
}
