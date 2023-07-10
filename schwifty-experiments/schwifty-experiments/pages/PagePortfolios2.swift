import SwiftUI

// struct PagePorfolios2: View {
//  @State private var path: NavigationPath = []
//  @State private var currentPath: StackPathPortolios?
//  //  @State private var currentPortfolio: Portfolio
//
//  var body: some View {
//    NavigationStack(path: $path) {
//      VStack {
//        InterpolateEnumArray(targetEnumArray: path)
//        Text(currentPath?.rawValue ?? "")
//
//        List(dbPortfolios.dataArray, id: \.username) { p in
//          NavigationLink(p.username, value: p)
//        }
//      }
//      .navigationTitle("Portfolios")
//      .navigationDestination(for: Portfolio.self) { p in
//        PagePortfolio(portfolio: p)
//      }
//    }
//  }
// }


//
// struct PagePorfoliosSwitch: View {
//  @Binding var path: [StackPathPortolios]
//  @Binding var currentPath: StackPathPortolios?
//
//  let forPath: StackPathPortolios
//
//  var body: some View {
//    switch forPath {
//    case .root:
//      AccountRoot(path: $path, currentPath: $currentPath)
//    case .settings:
//      Text("Settings")
//    case .settings_notifications:
//      Text("Notifications")
//    case .about:
//      Text("About")
//    }
//  }
// }

// struct AccountRoot: View {
//  @Binding var path: [StackPathPortolios]
//  @Binding var currentPath: StackPathPortolios?
//
//  var body: some View {
//    NavigationStack(path: $path) {
//      List(StackPathPortolios.allCases, id: \.self, selection: $currentPath) { item in
//        NavigationLink(item.rawValue, value: item)
//      }
//      .navigationTitle("Account")
//      .navigationDestination(for: StackPathPortolios.self) { item in
//        PagePorfoliosSwitch(path: $path, currentPath: $currentPath, forPath: item)
//      }
//    }
//  }
// }

#Preview {
  PagePorfolios()
}
