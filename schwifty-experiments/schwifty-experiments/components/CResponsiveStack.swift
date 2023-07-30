import SwiftUI

/// Use to wrap each Stack with. Adds content margins & ScrollView.
struct CResponsiveStack<Content: View>: View {
  // ╔═══════╗
  // ║ Props ║
  // ╚═══════╝
  let stacks: [StackPath]
  let content: Content

  init(stacks: [StackPath], @ViewBuilder content: () -> Content) {
    self.stacks = stacks
    self.content = content()
  }

  // ╔═══════╗
  // ║ Setup ║
  // ╚═══════╝
  @Environment(\.horizontalSizeClass) private var horizontalSizeClass

  var body: some View {
    if horizontalSizeClass == .compact {
      GeometryReader { geometry in
        ScrollView { content }
          .contentMargins(.all, geometry.size.width > 400 ? Space.lg : Space.md)
      }
    } else {
      ScrollView { content }
        .containerRelativeFrame(.horizontal, count: stacks.count == 0 ? 1 : 2, spacing: 0)
        .contentMargins(.vertical, Space.xxl)
        .contentMargins(.horizontal, Space.lg)
    }
  }
}

// #Preview {
// }
