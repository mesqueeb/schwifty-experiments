import SwiftUI

struct CSheet<Content: View>: View {
  // ╔═══════╗
  // ║ Props ║
  // ╚═══════╝
  let close: () -> Void
  let content: Content

  init(close: @escaping () -> Void, @ViewBuilder content: () -> Content) {
    self.content = content()
    self.close = close
  }

  // ╔══════════╗
  // ║ Template ║
  // ╚══════════╝
  var body: some View {
    VStack {
      HStack {
        Spacer()
        Button(action: close) {
          Image(systemName: "xmark")
            .foregroundColor(.gray)
            .padding()
            .padding([.top], 8)
        }
      }
      content
    }
  }
}

#Preview {
  CSheet(close: { print("hi") }) {
    VStack {
      Text("Hi")
      Text("Hi")
    }
  }
  .background(Color.black)
}
