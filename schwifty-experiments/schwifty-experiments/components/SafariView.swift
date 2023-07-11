import SafariServices
import SwiftUI

struct SafariView: UIViewControllerRepresentable {
  let url: URL

  func makeUIViewController(context: UIViewControllerRepresentableContext<SafariView>) -> SFSafariViewController {
    return SFSafariViewController(url: url)
  }

  func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<SafariView>) {}
}

struct SafariUrl: Identifiable {
  let id: String
  let url: URL
  init(_ url: String) {
    self.id = url
    self.url = URL(string: url)!
  }
}

class SafariVM: ObservableObject {
  @Published var shown: SafariUrl? = nil

  public func openUrl(_ url: String) {
    shown = SafariUrl(url)
  }
}
