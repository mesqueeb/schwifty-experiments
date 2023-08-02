import SwiftUI

enum Padding {
  case none
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
  let padding: Padding
  let alignment: HorizontalAlignment
  let spacing: CGFloat
  let content: Content

  init(scrollView: Bool, padding: Padding, alignment: HorizontalAlignment? = .leading, spacing: CGFloat? = Space.md, @ViewBuilder content: () -> Content) {
    self.scrollView = scrollView
    self.padding = padding
    self.alignment = alignment ?? .leading
    self.spacing = spacing ?? Space.md
    self.content = content()
  }

  // ╔═══════╗
  // ║ Setup ║
  // ╚═══════╝
  @Environment(\.horizontalSizeClass) private var horizontalSizeClass

  var verticalPadding: CGFloat {
    padding == .none || padding == .x ? 0 : horizontalSizeClass == .compact ? Space.lg : Space.xxl
  }

  func horizontalPadding(width: Double) -> CGFloat {
    padding == .none || padding == .y ? 0 : horizontalSizeClass == .compact ? width > 400 ? Space.lg : Space.md : Space.lg
  }

  @ViewBuilder
  var maybeScrollView: some View {
    if scrollView {
      ScrollView {
        VStack(alignment: alignment, spacing: spacing) { content }
          .border(.blue)
      }.border(.red)
    } else {
      VStack(alignment: alignment, spacing: spacing) { content }
    }
  }

  var body: some View {
    if horizontalSizeClass == .compact {
      GeometryReader { geometry in
        maybeScrollView
          .contentMargins(.horizontal, horizontalPadding(width: geometry.size.width), for: .scrollContent)
          .contentMargins(.vertical, verticalPadding, for: .scrollContent)
      }
    } else {
      maybeScrollView
        .contentMargins(.horizontal, horizontalPadding(width: 0), for: .scrollContent)
        .contentMargins(.vertical, verticalPadding, for: .scrollContent)
    }
  }
}

// #Preview {
// }
