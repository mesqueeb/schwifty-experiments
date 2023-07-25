import SwiftUI

enum SchwiftyButtonKind {
  case primary
  case onColor
}

struct SchwiftyButton: View {
  // ╔═══════╗
  // ║ Props ║
  // ╚═══════╝
  let action: (() -> Void)?
  let url: String?
  let label: String
  let kind: SchwiftyButtonKind?

  init(action: @escaping () -> Void, label: String, kind: SchwiftyButtonKind? = .primary) {
    self.action = action
    self.url = nil
    self.label = label
    self.kind = kind
  }

  init(url: String, label: String, kind: SchwiftyButtonKind? = .primary) {
    self.url = url
    self.action = nil
    self.label = label
    self.kind = kind
  }

  @EnvironmentObject private var safari: Safari

  // ╔══════════╗
  // ║ Template ║
  // ╚══════════╝
  var body: some View {
    Button(action: {
      if let action = action {
        action()
      } else if let url = url {
        safari.openUrl(url)
      }
    }) {
      Text(label)
        .frame(width: 280, height: 50)
        .background(kind == .onColor ? Color.white : Color.accentColor)
        .font(.callout)
        .bold()
        .foregroundColor(kind == .onColor ? .accentColor : Color.white)
        .cornerRadius(8)
    }
    #if !os(macOS)
    .sheet(item: $safari.shown) { shown in
      CSafariView(url: shown.url)
    }
    #endif
  }
}

#Preview {
  VStack(spacing: 16) {
    SchwiftyButton(url: "https://apple.com", label: "Get Schwifty")
    SchwiftyButton(action: { print("Get on the floor") }, label: "Get Schwifty")
    SchwiftyButton(action: { print("Get on the floor") }, label: "Get Schwifty", kind: .onColor)
  }
  .padding(16)
  .background(Color.black)
}
