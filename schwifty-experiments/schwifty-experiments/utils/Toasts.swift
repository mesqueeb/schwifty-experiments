import SwiftUI

struct ToastInstance: Identifiable {
  let id: UInt64
  let message: String
  let duration: Double
}

@Observable final class Toasts {
  public var toasts: [ToastInstance] = []

  public func dismiss(_ id: UInt64) {
    if let index = toasts.firstIndex(where: { $0.id == id }) {
      toasts.remove(at: index)
    }
  }

  public func show(_ message: String, duration: Double = 3) {
    let id = DispatchTime.now().rawValue
    let toast = ToastInstance(id: id, message: message, duration: duration)
    print("toast:", message)
    withAnimation(.easeOut) {
      toasts.append(toast)
    }
    DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
      withAnimation(.easeOut) {
        self.dismiss(id)
      }
    }
  }
}

struct ToastsWrapper: View {
  // ╔═══════╗
  // ║ Setup ║
  // ╚═══════╝
  var toasts: Toasts

  // ╔══════════╗
  // ║ Template ║
  // ╚══════════╝
  var body: some View {
    VStack {
      ForEach(Array(toasts.toasts.enumerated()), id: \.element.id) { i, toast in
        HStack {
          Text(toast.message)
            .foregroundColor(.white)
            .padding()
            .background(Color.black)
            .cornerRadius(Space.sm)
        }
        .padding(.top, i == 0 ? Space.lg : 0)
        .transition(.move(edge: .top))
      }
    }
  }
}

let toasts = Toasts()

#Preview {
  let toasts = Toasts()
  return ZStack(alignment: .top) {
    ToastsWrapper(toasts: toasts)
      .zIndex(2)

    VStack {
      Button(action: { toasts.show("this is a toast") }) {
        Text("show toast")
      }
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
  }
  .ignoresSafeArea()
  .frame(maxWidth: .infinity, maxHeight: .infinity)
  .border(.red)
}
