import SwiftUI

enum SchwiftyButtonKind {
  case primary
  case onColor
}

struct SchwiftyButton: View {
  let action: () -> Void
  let label: String
  let kind: SchwiftyButtonKind?

  init(action: @escaping () -> Void, label: String, kind: SchwiftyButtonKind? = .primary) {
    self.action = action
    self.label = label
    self.kind = kind
  }

  var body: some View {
    Button(action: action) {
      Text(label)
        .frame(width: 280, height: 50)
        .background(kind == .onColor ? Color.white : Color.accentColor)
        .font(.callout)
        .bold()
        .foregroundColor(kind == .onColor ? .accentColor : Color.white)
        .cornerRadius(8)
    }
  }
}

#Preview {
  VStack(spacing: 16) {
    SchwiftyButton(action: { print("Get on the floor") }, label: "Get Schwifty")
    SchwiftyButton(action: { print("Get on the floor") }, label: "Get Schwifty", kind: .onColor)
  }
  .padding(16)
  .background(Color.black)
}
