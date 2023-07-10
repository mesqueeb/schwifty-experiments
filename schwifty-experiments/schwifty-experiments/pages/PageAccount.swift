import SwiftUI

struct PageAccount: View {
  @State private var path: [StackPathAccount] = []
  @State private var currentPath: StackPathAccount?

  var body: some View {
    VStack {
      InterpolateEnumArray(targetEnumArray: path)
      Text(currentPath?.rawValue ?? "")
      PageAccountSwitch(path: $path, currentPath: $currentPath, forPath: .root)
    }
  }
}

struct PageAccountSwitch: View {
  @Binding var path: [StackPathAccount]
  @Binding var currentPath: StackPathAccount?

  let forPath: StackPathAccount

  var body: some View {
    switch forPath {
    case .root:
      AccountRoot(path: $path, currentPath: $currentPath)
    case .settings:
      Text("Settings")
    case .settings_notifications:
      Text("Notifications")
    case .about:
      Text("About")
    }
  }
}

struct AccountRoot: View {
  @Binding var path: [StackPathAccount]
  @Binding var currentPath: StackPathAccount?

  var body: some View {
    NavigationStack(path: $path) {
      List(StackPathAccount.allCases, id: \.self, selection: $currentPath) { item in
        NavigationLink(item.rawValue, value: item)
      }
      .navigationTitle("Account")
      .navigationDestination(for: StackPathAccount.self) { item in
        PageAccountSwitch(path: $path, currentPath: $currentPath, forPath: item)
      }
    }
  }
}

#Preview {
  PageAccount()
}
