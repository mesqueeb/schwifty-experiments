import SwiftUI
#if !os(macOS)
import SafariServices

struct CSafariView: UIViewControllerRepresentable {
  let url: URL

  func makeUIViewController(context: UIViewControllerRepresentableContext<CSafariView>) -> SFSafariViewController {
    return SFSafariViewController(url: url)
  }

  func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<CSafariView>) {}
}

struct SafariUrl: Identifiable {
  let id: String
  let url: URL
  init(_ url: String) {
    self.id = url
    self.url = URL(string: url)!
  }
}

class Safari: ObservableObject {
  @Published public var shown: SafariUrl? = nil

  public func openUrl(_ url: String) {
    shown = SafariUrl(url)
  }
}
#endif

#if os(macOS)
class Safari: ObservableObject {
  public func openUrl(_ url: String) {
    NSWorkspace.shared.open(URL(string: url)!)
  }
}
#endif
