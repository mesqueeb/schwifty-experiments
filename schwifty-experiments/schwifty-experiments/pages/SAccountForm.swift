import SwiftUI

struct SAccountForm: View {
  // ╔═══════╗
  // ║ Props ║
  // ╚═══════╝
  let path: StackPath

  // ╔═══════╗
  // ║ Setup ║
  // ╚═══════╝
  @Environment(StackVC.self) private var stackVC
  @State var username: String = ""

  // ╔══════════╗
  // ║ Template ║
  // ╚══════════╝
  var body: some View {
    VStack {
      CNavigationHeader(path, "\(username)'s Details")

      Text("test")

      CFormAccount(username: $username)

      Text("test")
    }
    .onAppear {
      print("af has appeared!")
      print(username)
    }
  }
}

#Preview {
  let stackPathPerRootIndex: [StackPath] = [.pageWeather, .portfolioFeed, .pageFrameworks, .pageAccount]

  @State var stackVC = StackVC(initialRootIndex: 1, stackPathPerRootIndex)

  return SAccountForm(path: .pageAccount)
    .environment(stackVC)
}
