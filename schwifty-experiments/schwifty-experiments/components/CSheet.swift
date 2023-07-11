import SwiftUI

struct CSheet<Content: View>: View {
  let content: Content
  let close: () -> Void

  init(close: @escaping () -> Void, @ViewBuilder content: () -> Content) {
    self.content = content()
    self.close = close
  }

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
