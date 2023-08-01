import SwiftUI

enum Padding {
  case x
  case y
  case a
}

/// Use to wrap each Stack with. Adds optional content margins and/or ScrollView.
struct CStack<Content: View>: View {
  // ╔═══════╗
  // ║ Props ║
  // ╚═══════╝
  let scrollView: Bool
  let padding: Padding?
  let content: Content

  init(scrollView: Bool, padding: Padding? = nil, @ViewBuilder content: () -> Content) {
    self.scrollView = scrollView
    self.padding = padding
    self.content = content()
  }

  // ╔═══════╗
  // ║ Setup ║
  // ╚═══════╝
  @Environment(\.horizontalSizeClass) private var horizontalSizeClass

  var verticalPadding: CGFloat {
    padding == nil || padding == .x ? 0 : horizontalSizeClass == .compact ? Space.lg : Space.xxl
  }

  func horizontalPadding(width: Double) -> CGFloat {
    padding == nil || padding == .y ? 0 : horizontalSizeClass == .compact ? width > 400 ? Space.lg : Space.md : Space.lg
  }

  @ViewBuilder
  var maybeScrollView: some View {
    if scrollView {
      ScrollView { VStack { content }
      }
    } else {
      VStack { content }
    }
  }

  var body: some View {
    if horizontalSizeClass == .compact {
      GeometryReader { geometry in
        maybeScrollView
          .contentMargins(.horizontal, horizontalPadding(width: geometry.size.width))
          .contentMargins(.vertical, verticalPadding)
      }
    } else {
      maybeScrollView
        .contentMargins(.horizontal, horizontalPadding(width: 0))
        .contentMargins(.vertical, verticalPadding)
    }
  }
}

// #Preview {
// }
